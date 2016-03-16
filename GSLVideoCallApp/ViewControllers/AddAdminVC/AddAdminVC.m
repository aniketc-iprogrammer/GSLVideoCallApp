//
//  AddAdminVC.m
//  GSLVideoCallApp
//
//  Created by Aniket on 15/03/16.
//  Copyright © 2016 GSLabs. All rights reserved.
//

#import "AddAdminVC.h"
#import "Constant.h"
#import "AFNetworkingAPIManager.h"
#import "VerifyAdminOTPVC.h"
#import "DAAlertController.h"

@interface AddAdminVC ()<UITextFieldDelegate,AFNetworkingAPIManagerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *txtDisplayName;
@property (weak, nonatomic) IBOutlet UITextField *txtEmailId;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;

@end

@implementation AddAdminVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    self.title = @"Create Admin";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TEXT FIELD METHODS

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    return [textField resignFirstResponder];
}

#pragma mark - BUTTON ACTIONS

- (IBAction)btnSubmitTchUp:(id)sender {
    
//    [self navigateNextDirect];
   
    NSString *displayName = [_txtDisplayName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *emailId = [_txtEmailId.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *password = [_txtPassword.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if([displayName isEqualToString:@""]){
        [Utility showSimpleDefaultAlertWithMessage:@"Please enter display name"];
        return;
    }
    
    if([emailId isEqualToString:@""]){
        [Utility showSimpleDefaultAlertWithMessage:@"Please enter email Id"];
        return;
    }else if (![emailId isEqualToString:@""] && ![Utility isValidateEmailAddress:emailId]){
        [Utility showSimpleDefaultAlertWithMessage:@"Please enter valid email id"];
        return;
    }
    
    
    if([password isEqualToString:@""]){
        [Utility showSimpleDefaultAlertWithMessage:@"Please enter password"];
        return;
    }else if (password.length < 6){
        [Utility showSimpleDefaultAlertWithMessage:@"Password lenght should be mimimum 6 characters"];
        return;
    }
    
    [self invokeAddMemberSendOTPApi:displayName emailId:emailId password:password];
    
}

- (void)navigateNextDirect{
    
    VerifyAdminOTPVC *verifyAdminOTPVC = [self.storyboard instantiateViewControllerWithIdentifier:@"veroifyadminotp"];
    verifyAdminOTPVC.username = [_txtEmailId.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    verifyAdminOTPVC.displayname = [_txtDisplayName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    verifyAdminOTPVC.password = [_txtPassword.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    verifyAdminOTPVC.groupId = _groupId;
    [self.navigationController pushViewController:verifyAdminOTPVC animated:YES];

}

#pragma mark - API INTERACTION

- (void)invokeAddMemberSendOTPApi:(NSString *)displayName emailId:(NSString *)emailid password:(NSString *)password{
    
    NSDictionary *paramsDict = @{@"username":emailid,@"name":displayName,@"password":password,@"groupId":_groupId,@"userType":@"admin"};
    NSString *paramsJson = [Utility getJsonForNSDictionry:paramsDict];
    
    [Utility showLoaderInView:self.view];
    
    [self invokeApi:kAPI_METHOD_ADD_USER_POST paramsjson:paramsJson apimethodType:apiMethodTypePost method:kAPI_METHOD_ADD_USER_POST];
}

- (void)invokeApi:(NSString *)webMethodURL paramsjson:(NSString *)paramsjson apimethodType:(apiMethodType)type method:(NSString *)method{
  
    AFNetworkingAPIManager *apiInvokationMgr = [[AFNetworkingAPIManager alloc] initWithURL:[NSString stringWithFormat:@"%@%@",kSUBSCRIPTION_SERVER_URL_PROD,webMethodURL] params:paramsjson methodType:type delegate:self];
    [apiInvokationMgr startAPIInvokation];

}

- (void)apiCallDidFinish:(id)result{
    
    @try {
        
            if([[result valueForKey:STATUS] isEqualToString:SUCCESS]){
                
                DAAlertAction *okAction = [DAAlertAction actionWithTitle:@"Ok" style:DAAlertActionStyleDefault handler:^{
                  
                    VerifyAdminOTPVC *verifyAdminOTPVC = [self.storyboard instantiateViewControllerWithIdentifier:@"veroifyadminotp"];
                    verifyAdminOTPVC.username = [_txtEmailId.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                    verifyAdminOTPVC.displayname = [_txtDisplayName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                    verifyAdminOTPVC.password = [_txtPassword.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                    verifyAdminOTPVC.groupId = _groupId;
                    
                    [self.navigationController pushViewController:verifyAdminOTPVC animated:YES];

                }];
                [DAAlertController showAlertViewInViewController:self withTitle:@"Admin Account Setup" message:@"An OTP has been sent successfully to the entered email id." actions:@[okAction]];
                
                
            }else if([[result valueForKey:STATUS] isEqualToString:FAILED]){
                [Utility showSimpleDefaultAlertWithMessage:[result valueForKeyPath:@"error.errorMessage"]];
                [Utility hideLoaderFromView:self.view];
            }else{
                [Utility showSimpleDefaultAlertWithMessage:@"Something went wrong please try again"];
                [Utility hideLoaderFromView:self.view];
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
