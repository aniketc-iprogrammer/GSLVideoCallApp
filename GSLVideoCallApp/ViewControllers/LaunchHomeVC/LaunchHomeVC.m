//
//  LaunchHomeVC.m
//  GSLVideoCallApp
//
//  Created by Aniket on 09/03/16.
//  Copyright © 2016 GSLabs. All rights reserved.
//

#import "LaunchHomeVC.h"
#import "DAAlertController.h"
#import "AFNetworkingAPIManager.h"
#import "Constant.h"
#import "AddAdminVC.h"

@interface LaunchHomeVC ()<AFNetworkingAPIManagerDelegate>{
    UITextField *txtOTP;
}

@end

@implementation LaunchHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - BUTTON ACTIONS

- (void)doneTap{
    [txtOTP resignFirstResponder];
}

- (IBAction)btnRemoteConfigurationTchUp:(id)sender {
    
//  [self navigateNextDirect];
    
    DAAlertAction *cancelAction = [DAAlertAction actionWithTitle:@"Cancel" style:DAAlertActionStyleCancel handler:nil];
    DAAlertAction *okAction = [DAAlertAction actionWithTitle:@"Verify" style:DAAlertActionStyleDefault handler:^{
        [self invokeVerifyCodeAPI];
    }];
    
    [DAAlertController showAlertViewInViewController:self
                                           withTitle:@"Remote Configuration"
                                             message:@"Please enter OTP"
                                             actions:@[cancelAction, okAction]
                                  numberOfTextFields:1
                      textFieldsConfigurationHandler:^(NSArray *textFields)
    {
        txtOTP = [textFields firstObject];
        txtOTP.placeholder = @"OTP";
        txtOTP.keyboardType = UIKeyboardTypeNumberPad;
        
        UIToolbar *keyboardDoneButtonView = [[UIToolbar alloc] init];
        [keyboardDoneButtonView sizeToFit];
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                       style:UIBarButtonItemStyleDone target:self
                                                                      action:@selector(doneTap)];
        [keyboardDoneButtonView setItems:[NSArray arrayWithObjects:doneButton, nil]];
        txtOTP.inputAccessoryView = keyboardDoneButtonView;
        
    } validationBlock:^BOOL(NSArray *textFields) {
       
        txtOTP = [textFields firstObject];
        return txtOTP.text.length > 0;
    
    }];
    
}

- (void)navigateNextDirect{
    AddAdminVC *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"addadminvc"];
    [self.navigationController pushViewController:controller animated:YES];
}


#pragma mark - API INTERACTION

- (void)invokeVerifyCodeAPI{

    [Utility showLoaderInView:self.view];
    NSString *otp = [txtOTP.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSDictionary *paramsDict = @{@"code":otp};
    NSString *paramsJson = [Utility getJsonForNSDictionry:paramsDict];
    [self invokeApi:kAPI_METHOD_VERIFYCODE_POST paramsjson:paramsJson apimethodType:apiMethodTypePost method:kAPI_METHOD_VERIFYCODE_POST];

}

- (void)invokeApi:(NSString *)webMethodURL paramsjson:(NSString *)paramsjson apimethodType:(apiMethodType)type method:(NSString *)method{
    
    AFNetworkingAPIManager *apiInvokationMgr = [[AFNetworkingAPIManager alloc] initWithURL:[NSString stringWithFormat:@"%@%@",kSUBSCRIPTION_SERVER_URL_PROD,webMethodURL] params:paramsjson methodType:type delegate:self];
    
    [apiInvokationMgr startAPIInvokation];
    
}

- (void)apiCallDidFinish:(id)result{
    @try {
        [Utility hideLoaderFromView:self.view];
        
        if([[result valueForKey:STATUS] isEqualToString:SUCCESS]){
            
            AddAdminVC *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"addadminvc"];
            controller.groupId = [result valueForKeyPath:@"data.groupId"];
            [self.navigationController pushViewController:controller animated:YES];
            
        }else if ([[result valueForKey:STATUS] isEqualToString:FAILED]){
            
            [Utility showSimpleDefaultAlertWithMessage:[result valueForKeyPath:@"error.errorMessage"]];
       
        }else{
        
        }
    }
    @catch (NSException *exception) {
        NSLog(@"%@",exception);
    }
}

- (void)apiCallDidFail:(NSError *)error{
    [Utility hideLoaderFromView:self.view];
    if(error.code == -1009)
        [Utility showSimpleDefaultAlertWithMessage:@"The Internet connection appears to be offline"];
    else
        [Utility showSimpleDefaultAlertWithMessage:error.description];
}

@end
