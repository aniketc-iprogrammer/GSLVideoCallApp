//
//  AddMemberVC.m
//  GSLVideoCallApp
//
//  Created by Aniket on 11/03/16.
//  Copyright © 2016 GSLabs. All rights reserved.
//

#import "AddMemberVC.h"
#import "SWRevealViewController.h"
#import "Utility.h"
#import "AFNetworking.h"
#import "Constant.h"
#import "MBProgressHUD.h"
#import "AFNetworkingAPIManager.h"

@interface AddMemberVC ()<UITextFieldDelegate,AFNetworkingAPIManagerDelegate>{
    NSString *inprocessAPIMethod;
}

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sideBarButton;
@property (weak, nonatomic) IBOutlet UITextField *txtEmailId;

@end

@implementation AddMemberVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupLeftMenuButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupLeftMenuButton{
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sideBarButton setTarget: self.revealViewController];
        [self.sideBarButton setAction: @selector(revealToggle:)];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
}

#pragma mark - UITEXTFIELD

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    return [textField resignFirstResponder];
}

- (IBAction)btnAddMemberTchUp:(id)sender {
    
    NSString *emaild = [_txtEmailId.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if([emaild isEqualToString:@""]){
        [Utility showSimpleDefaultAlertWithMessage:@"Please enter an Email Id"];
        return;
    }else if(![emaild isEqualToString:@""] && ![Utility isValidateEmailAddress:emaild]){
        [Utility showSimpleDefaultAlertWithMessage:@"Please enter a valid Email Id"];
        return;
    }
    
    [self invokeAddMemberSendOTPApi:emaild];

}


#pragma mark - API INTERACTION

- (void)invokeAddMemberSendOTPApi:(NSString *)emailId{
    NSDictionary *paramsDict = @{@"username":emailId,@"name":@"",@"password":@"",@"groupId":kBASEUSER_GROUP_INFO.groupId,@"password":@"",@"userType":@"user"};
    NSString *paramsJson = [Utility getJsonForNSDictionry:paramsDict];
    
    [Utility showLoaderInView:self.view];
    
    [self invokeApi:kAPI_METHOD_ADD_USER_POST paramsjson:paramsJson apimethodType:apiMethodTypePost method:kAPI_METHOD_ADD_USER_POST];
}

- (void)invokeApi:(NSString *)webMethodURL paramsjson:(NSString *)paramsjson apimethodType:(apiMethodType)type method:(NSString *)method{
    inprocessAPIMethod = method;
    AFNetworkingAPIManager *apiInvokationMgr = [[AFNetworkingAPIManager alloc] initWithURL:[NSString stringWithFormat:@"%@%@",kSUBSCRIPTION_SERVER_URL_PROD,webMethodURL] params:paramsjson methodType:type delegate:self];
    [apiInvokationMgr startAPIInvokation];
}

- (void)apiCallDidFinish:(id)result{
    [Utility hideLoaderFromView:self.view];
    
    @try {
        
        if([inprocessAPIMethod isEqualToString:kAPI_METHOD_ADD_USER_POST]){
            
            if([[result valueForKey:STATUS] isEqualToString:SUCCESS]){
                
                [Utility showSimpleDefaultAlertWithMessage:@"OTP has been sent successfully to the provided email id"];
            
            }else if([[result valueForKey:STATUS] isEqualToString:FAILED]){
            
                [Utility showSimpleDefaultAlertWithMessage:[result valueForKeyPath:@"error.errorMessage"]];
                [Utility hideLoaderFromView:self.view];
            
            }else{
                [Utility showSimpleDefaultAlertWithMessage:@"Something went wrong please try again"];
                [Utility hideLoaderFromView:self.view];
            }
        }
    
    }@catch(NSException *exc){
        NSLog(@"%@",exc);
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
