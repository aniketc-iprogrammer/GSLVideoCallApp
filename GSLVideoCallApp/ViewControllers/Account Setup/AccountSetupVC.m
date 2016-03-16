//
//  AccountSetupVC.m
//  GSLVideoCallApp
//
//  Created by Aniket on 10/03/16.
//  Copyright © 2016 GSLabs. All rights reserved.
//

#import "AccountSetupVC.h"
#import "Utility.h"
#import "AFNetworking.h"
#import "Constant.h"
#import "MBProgressHUD.h"
#import "BaseUserSessionInfo.h"
#import "AFNetworkingAPIManager.h"
#import "LocalSessionManager.h"

@interface AccountSetupVC ()<UITextFieldDelegate,AFNetworkingAPIManagerDelegate>{

    NSString *inprocessAPIMethod;
    
}

@property (weak, nonatomic) IBOutlet UITextField *txtDisplayName;
@property (weak, nonatomic) IBOutlet UITextField *txtEmailId;
@property (weak, nonatomic) IBOutlet UITextField *txtOTP;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
@property (weak, nonatomic) IBOutlet UITextField *txtConfirmPassword;

- (IBAction)btnSubmitTchUp:(id)sender;

@end

@implementation AccountSetupVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpTextField];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    self.title = @"Account Setup";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITextField Delegate

- (void)setUpTextField{
    UIToolbar *keyboardDoneButtonView = [[UIToolbar alloc] init];
    [keyboardDoneButtonView sizeToFit];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                   style:UIBarButtonItemStyleDone target:self
                                                                  action:@selector(doneTap)];
    [keyboardDoneButtonView setItems:[NSArray arrayWithObjects:doneButton, nil]];
    _txtOTP.inputAccessoryView = keyboardDoneButtonView;
}

- (void)doneTap{
    [_txtOTP resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    return [textField resignFirstResponder];
}

#pragma mark - button actions

- (IBAction)btnSubmitTchUp:(id)sender {

    NSString *displayName = [_txtDisplayName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *emailId = [_txtEmailId.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *otp = [_txtOTP.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *password = [_txtPassword.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *confirmPassword = [_txtConfirmPassword.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];

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
    
    if([otp isEqualToString:@""]){
        [Utility showSimpleDefaultAlertWithMessage:@"Please enter OTP"];
        return;
    }
    
    if([password isEqualToString:@""]){
        [Utility showSimpleDefaultAlertWithMessage:@"Please enter password"];
        return;
    }else if (password.length < 6){
        [Utility showSimpleDefaultAlertWithMessage:@"Password lenght should be mimimum 6 characters"];
        return;
    }
    
    if([confirmPassword isEqualToString:@""]){
        [Utility showSimpleDefaultAlertWithMessage:@"Please comfirm entered password"];
        return;
    }
    
    if(![password isEqualToString:confirmPassword]){
        [Utility showSimpleDefaultAlertWithMessage:@"Entered password does not match"];
        return;
    }
    
    [self invokeVerifyOTPApi];
}

#pragma mark - APICONNECTION MANAGER DELEGATE

- (void)invokeVerifyOTPApi{
    
    [Utility showLoaderInView:self.view];
    NSDictionary *paramsDict = @{@"name":_txtDisplayName.text,@"username":_txtEmailId.text,@"otp":_txtOTP.text,@"password":_txtPassword.text,@"userType":@"user_new"};
    NSString *paramsJson = [Utility getJsonForNSDictionry:paramsDict];
    [self invokeApi:kAPI_METHOD_VERIFYOTP_POST paramsjson:paramsJson apimethodType:apiMethodTypePost method:kAPI_METHOD_VERIFYOTP_POST];
    
}

- (void)invokeLoginApi{
    
    NSDictionary *paramsDict = @{@"username":_txtEmailId.text,@"password":_txtPassword.text,@"":@""};
    NSString *paramsJson = [Utility getJsonForNSDictionry:paramsDict];
    [self invokeApi:kAPI_METHOD_LOGIN_POST paramsjson:paramsJson apimethodType:apiMethodTypePost method:kAPI_METHOD_LOGIN_POST];
    
}

- (void)invokeGetProfileDataApi{
    
    [self invokeApi:[NSString stringWithFormat:@"%@?username=%@",kAPI_METHOD_USER_GET,_txtEmailId.text] paramsjson:nil apimethodType:apiMethodTypeGet method:kAPI_METHOD_USER_GET];
    
}

- (void)invokeApi:(NSString *)webMethodURL paramsjson:(NSString *)paramsjson apimethodType:(apiMethodType)type method:(NSString *)method{
    inprocessAPIMethod = method;
    AFNetworkingAPIManager *apiInvokationMgr = [[AFNetworkingAPIManager alloc] initWithURL:[NSString stringWithFormat:@"%@%@",kSUBSCRIPTION_SERVER_URL_PROD,webMethodURL] params:paramsjson methodType:type delegate:self];
    [apiInvokationMgr startAPIInvokation];
}

- (void)apiCallDidFinish:(id)result{
    
    @try {
        
        if([inprocessAPIMethod isEqualToString:kAPI_METHOD_VERIFYOTP_POST]){
            
                if([[result valueForKey:STATUS] isEqualToString:SUCCESS]){
                    [self invokeLoginApi];
                }else if([[result valueForKey:STATUS] isEqualToString:FAILED]){
                    [Utility showSimpleDefaultAlertWithMessage:[result valueForKeyPath:@"error.errorMessage"]];
                    [Utility hideLoaderFromView:self.view];
                }else{
                    [Utility showSimpleDefaultAlertWithMessage:@"Something went wrong please try again"];
                    [Utility hideLoaderFromView:self.view];
                }
            
            
        }if([inprocessAPIMethod isEqualToString:kAPI_METHOD_LOGIN_POST]){
            
            
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
                
            
            
        }else if([inprocessAPIMethod isEqualToString:kAPI_METHOD_USER_GET]){
            
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
