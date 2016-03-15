//
//  ConfigureGroupVC.m
//  GSLVideoCallApp
//
//  Created by Aniket on 15/03/16.
//  Copyright © 2016 GSLabs. All rights reserved.
//

#import "ConfigureGroupVC.h"
#import "Constant.h"
#import "AFNetworkingAPIManager.h"
#import "DAAlertController.h"
#import "LocalSessionManager.h"

@interface ConfigureGroupVC ()<UITextFieldDelegate,AFNetworkingAPIManagerDelegate>{
    NSString *inprocessApiMethod;
}

@property (weak, nonatomic) IBOutlet UITextField *txtGroupName;

@end

@implementation ConfigureGroupVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TEXTFIELD METHODS

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    return [textField resignFirstResponder];
}

#pragma mark - BUTTON ACTIONS

- (IBAction)btnSubmitTchUp:(id)sender {
    
    NSString *gropuName = [_txtGroupName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if([gropuName isEqualToString:@""]){
        [Utility showSimpleDefaultAlertWithMessage:@"Please enter Group Name"];
        return;
    }
    
    [self invokeAddGroupApi:gropuName];
    
}


#pragma mark - API INTERACTION

- (void)invokeAddGroupApi:(NSString *)groupName{
    
    [Utility showLoaderInView:self.view];
    NSDictionary *paramsDict = @{@"groupId":_groupId,@"groupName":groupName};
    NSString *paramsJson = [Utility getJsonForNSDictionry:paramsDict];
    [self invokeApi:kAPI_METHOD_UPDATE_GROUP_POST paramsjson:paramsJson apimethodType:apiMethodTypePost method:kAPI_METHOD_UPDATE_GROUP_POST];
    
}

- (void)invokeLoginApi{
    
    [Utility showLoaderInView:self.view];
    NSDictionary *paramsDict = @{@"username":_username,@"password":_password,@"":@""};
    NSString *paramsJson = [Utility getJsonForNSDictionry:paramsDict];
    [self invokeApi:kAPI_METHOD_LOGIN_POST paramsjson:paramsJson apimethodType:apiMethodTypePost method:kAPI_METHOD_LOGIN_POST];
    
}

- (void)invokeGetProfileDataApi{
    
    [self invokeApi:[NSString stringWithFormat:@"%@?username=%@",kAPI_METHOD_USER_GET,_username] paramsjson:nil apimethodType:apiMethodTypeGet method:kAPI_METHOD_USER_GET];
    
}

- (void)invokeApi:(NSString *)webMethodURL paramsjson:(NSString *)paramsjson apimethodType:(apiMethodType)type method:(NSString *)method{
    
    inprocessApiMethod = method;
    AFNetworkingAPIManager *apiInvokationMgr = [[AFNetworkingAPIManager alloc] initWithURL:[NSString stringWithFormat:@"%@%@",kSUBSCRIPTION_SERVER_URL_PROD,webMethodURL] params:paramsjson methodType:type delegate:self];
    [apiInvokationMgr startAPIInvokation];

}

- (void)apiCallDidFinish:(id)result{
    
    @try {
        
        if([inprocessApiMethod isEqualToString:kAPI_METHOD_UPDATE_GROUP_POST]){
        
            [Utility hideLoaderFromView:self.view];
            
            if([[result valueForKey:STATUS] isEqualToString:SUCCESS]){
                
                DAAlertAction *okAction = [DAAlertAction actionWithTitle:@"Ok" style:DAAlertActionStyleDefault handler:^{
                    [self invokeLoginApi];
                }];
                [DAAlertController showAlertViewInViewController:self withTitle:@"Remote Configuration" message:@"Device configuration has been completed successfully" actions:@[okAction]];
                
            }else if([[result valueForKey:STATUS] isEqualToString:FAILED])
                [Utility showSimpleDefaultAlertWithMessage:[result valueForKeyPath:@"error.errorMessage"]];
            else
                [Utility showSimpleDefaultAlertWithMessage:@"Something went wrong please try again"];
            
            
        }
        
        else if ([inprocessApiMethod isEqualToString:kAPI_METHOD_LOGIN_POST]){
            
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

                
        }else if ([inprocessApiMethod isEqualToString:kAPI_METHOD_USER_GET]){
        
            [Utility hideLoaderFromView:self.view];
            
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
    @catch (NSException *exception) {
        NSLog(@"%@",exception);
        [Utility hideLoaderFromView:self.view];
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
