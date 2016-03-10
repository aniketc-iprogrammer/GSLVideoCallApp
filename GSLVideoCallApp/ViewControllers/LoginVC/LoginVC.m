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
    
    
    NSDictionary *paramsDict = @{@"username":_txtUsername.text,@"password":_txtPassword.text,@"":@""};
    NSString *paramsJson = [Utility getJsonForNSDictionry:paramsDict];
    [self invokeApiMethod:kAPI_METHOD_LOGIN_POST paramsjson:paramsJson apimethodType:apiMethodTypePost];

}

#pragma mark - APICONNECTION MANAGER DELEGATE

- (void)invokeApiMethod:(NSString *)method paramsjson:(NSString *)paramsjson apimethodType:(apiMethodType)type{
    
    inprocessAPIMethod = method;
    
    AFNetworkingAPIManager *apiInvokationMgr = [[AFNetworkingAPIManager alloc] initWithURL:[NSString stringWithFormat:@"%@%@/",kSUBSCRIPTION_SERVER_URL_PROD,method] params:paramsjson methodType:type delegate:self];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [apiInvokationMgr startAPIInvokation];

}

- (void)apiCallFinished:(id)result{
    if([inprocessAPIMethod isEqualToString:kAPI_METHOD_LOGIN_POST]){
    
    }else if ([inprocessAPIMethod isEqualToString:kAp]){
    
    }
    
}

-(void)apiCallDidFailed:(NSError *)error{

}

@end
