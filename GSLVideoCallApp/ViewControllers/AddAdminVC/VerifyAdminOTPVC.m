//
//  VerifyAdminOTPVC.m
//  GSLVideoCallApp
//
//  Created by Aniket on 15/03/16.
//  Copyright © 2016 GSLabs. All rights reserved.
//

#import "VerifyAdminOTPVC.h"
#import "AFNetworkingAPIManager.h"
#import "Constant.h"
#import "ConfigureGroupVC.h"

@interface VerifyAdminOTPVC ()<UITextFieldDelegate,AFNetworkingAPIManagerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *txtOTP;
@end

@implementation VerifyAdminOTPVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpTextField];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    self.title = @"Verify OTP";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TEXT FIELD METHODS

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

#pragma mark - BUTTON ACTIONS

- (IBAction)btnSubmitTchUp:(id)sender {
    
//    [self navigateNextDirect];
    
    NSString *otp = [_txtOTP.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if([otp isEqualToString:@""]){
        [Utility showSimpleDefaultAlertWithMessage:@"Please enter OTP"];
        return;
    }
    
    [self invokeVerifyOTPApi:otp];

}

- (void)navigateNextDirect{

    ConfigureGroupVC *grpVC = [self.storyboard instantiateViewControllerWithIdentifier:@"configuregrp"];
    grpVC.groupId = _groupId;
    grpVC.displayname = _displayname;
    grpVC.username = _username;
    grpVC.password = _password;
    [self.navigationController pushViewController:grpVC animated:YES];

}

#pragma mark - API INTERACTION

- (void)invokeVerifyOTPApi:(NSString *)OTP{
    
    [Utility showLoaderInView:self.view];
    NSDictionary *paramsDict = @{@"name":_displayname,@"username":_username,@"otp":OTP,@"password":_password,@"userType":@"admin"};
    NSString *paramsJson = [Utility getJsonForNSDictionry:paramsDict];
    [self invokeApi:kAPI_METHOD_VERIFYOTP_POST paramsjson:paramsJson apimethodType:apiMethodTypePost method:kAPI_METHOD_VERIFYOTP_POST];
    
}
- (void)invokeApi:(NSString *)webMethodURL paramsjson:(NSString *)paramsjson apimethodType:(apiMethodType)type method:(NSString *)method{
    
    AFNetworkingAPIManager *apiInvokationMgr = [[AFNetworkingAPIManager alloc] initWithURL:[NSString stringWithFormat:@"%@%@",kSUBSCRIPTION_SERVER_URL_PROD,webMethodURL] params:paramsjson methodType:type delegate:self];
    [apiInvokationMgr startAPIInvokation];
    
}

- (void)apiCallDidFinish:(id)result{
    
    @try {
        
        if([[result valueForKey:STATUS] isEqualToString:SUCCESS]){
            
            ConfigureGroupVC *grpVC = [self.storyboard instantiateViewControllerWithIdentifier:@"configuregrp"];
            grpVC.groupId = _groupId;
            grpVC.displayname = _displayname;
            grpVC.username = _username;
            grpVC.password = _password;
            
            [self.navigationController pushViewController:grpVC animated:YES];
            
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
