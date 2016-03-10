//
//  LoginVC.m
//  GSLVideoCallApp
//
//  Created by Aniket on 09/03/16.
//  Copyright © 2016 GSLabs. All rights reserved.
//

#import "LoginVC.h"
#import "Utility.h"
#import "AFNetworking.h"
#import "Constant.h"
#import "MBProgressHUD.h"
#import "BaseUserSessionInfo.h"
#import "AFNetworkingAPIManager.h"
#import "LocalSessionManager.h"

@interface LoginVC ()<UITextFieldDelegate,AFNetworkingAPIManagerDelegate>{
    NSString *inprocessAPIMethod;
}

@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    self.title = @"Login";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   //Dispose of any resources that can be recreated.
}


#pragma mark - UITEXTFIELD

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - BUTTON ACTIONS

- (IBAction)btnLoginTchUp:(UIButton *)sender {
    
    [self.view endEditing:YES];
    
    NSString *enteredEmail = [_txtUsername.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *enteredPassword = [_txtPassword.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if([enteredEmail isEqualToString:@""]){
        [Utility showSimpleDefaultAlertWithMessage:@"Please enter email id"];
        return;
    }else if (![enteredEmail isEqualToString:@""] && ![Utility isValidateEmailAddress:enteredEmail]){
        [Utility showSimpleDefaultAlertWithMessage:@"Please enter valid email id"];
        return;
    }
    if([enteredPassword isEqualToString:@""]){
        [Utility showSimpleDefaultAlertWithMessage:@"Please enter password"];
        return;
    }else if(![enteredPassword isEqualToString:@""] && ![Utility isValidPassword:enteredPassword]){
        [Utility showSimpleDefaultAlertWithMessage:@"Please enter a valid password"];
        return;
    }
    
    
    [self invokeLoginApi];

}

#pragma mark - APICONNECTION MANAGER DELEGATE

- (void)invokeLoginApi{

    [Utility showLoaderInView:self.view];
    NSDictionary *paramsDict = @{@"username":_txtUsername.text,@"password":_txtPassword.text,@"":@""};
    NSString *paramsJson = [Utility getJsonForNSDictionry:paramsDict];
    [self invokeApi:kAPI_METHOD_LOGIN_POST paramsjson:paramsJson apimethodType:apiMethodTypePost method:kAPI_METHOD_LOGIN_POST];

}

- (void)invokeGetProfileDataApi{

    [self invokeApi:[NSString stringWithFormat:@"%@?username=%@",kAPI_METHOD_USER_GET,_txtUsername.text] paramsjson:nil apimethodType:apiMethodTypeGet method:kAPI_METHOD_USER_GET];
    
}

- (void)invokeApi:(NSString *)webMethodURL paramsjson:(NSString *)paramsjson apimethodType:(apiMethodType)type method:(NSString *)method{
    
    inprocessAPIMethod = method;
    
    AFNetworkingAPIManager *apiInvokationMgr = [[AFNetworkingAPIManager alloc] initWithURL:[NSString stringWithFormat:@"%@%@",kSUBSCRIPTION_SERVER_URL_PROD,webMethodURL] params:paramsjson methodType:type delegate:self];
    
    [apiInvokationMgr startAPIInvokation];

}

- (void)apiCallDidFinish:(id)result{

    if([inprocessAPIMethod isEqualToString:kAPI_METHOD_LOGIN_POST]){
    
        if([result isKindOfClass:[NSDictionary class]]){
        
            if([[result valueForKey:STATUS] isEqualToString:SUCCESS]){
                
                NSError *error;
                kBASEUSER_GROUP_INFO = [[GroupInfoModel alloc] initWithDictionary:[[result valueForKeyPath:@"data.groupConfiguration"] objectAtIndex:0] error:&error];
                kBASEUSER.displayPicturePath = [result valueForKeyPath:@"data.serverConfiguration.avatar_base_url"];
                
                if(!error)
                    [self invokeGetProfileDataApi];
                else{
                    [Utility hideLoaderFromView:self.view];
                    [Utility showSimpleDefaultAlertWithMessage:error.description];
                }
                
            }else{
            
                [Utility hideLoaderFromView:self.view];
                [Utility showSimpleDefaultAlertWithMessage:@"Incorrect Username or password"];
            
            }
            
        }
        
    }else if([inprocessAPIMethod isEqualToString:kAPI_METHOD_USER_GET]){
        
        [Utility hideLoaderFromView:self.view];
        
        if([result isKindOfClass:[NSDictionary class]]){
           
            if([[result valueForKey:STATUS] isEqualToString:SUCCESS]){
                
                NSError *error;
                kBASEUSER_PROFILE_INFO = [[ProfileInfoModel alloc] initWithDictionary:[result valueForKey:@"data"] error:&error];
                
                if(!error){
                    [LocalSessionManager saveBaseUserSessionInUserdefaults];
                    [Utility setNavigationForLoggedInSession];
                }else{
                    [Utility showSimpleDefaultAlertWithMessage:error.description];
                }
            
            }
        
        }
    
    }

}

-(void)apiCallDidFail:(NSError *)error{
    [Utility hideLoaderFromView:self.view];
    if(error.code == -1009)
        [Utility showSimpleDefaultAlertWithMessage:@"The Internet connection appears to be offline"];
    else
        [Utility showSimpleDefaultAlertWithMessage:error.description];
}

@end
