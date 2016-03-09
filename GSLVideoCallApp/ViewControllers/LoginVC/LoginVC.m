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

@interface LoginVC ()<UITextFieldDelegate>

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
    // Dispose of any resources that can be recreated.
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
        
        UIAlertView *alertV = [[UIAlertView alloc] initWithTitle:@"" message:@"Please enter email id" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alertV show];
        return;

        
    }else if (![enteredEmail isEqualToString:@""] && ![Utility isValidateEmailAddress:enteredEmail]){
        
        UIAlertView *alertV = [[UIAlertView alloc] initWithTitle:@"" message:@"Please enter valid email id" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alertV show];
        return;
    }
    
    if([enteredPassword isEqualToString:@""]){
        
        UIAlertView *alertV = [[UIAlertView alloc] initWithTitle:@"" message:@"Please enter password" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alertV show];
        return;
    
    }else if(![enteredPassword isEqualToString:@""] && ![Utility isValidPassword:enteredPassword]){
        
        UIAlertView *alertV = [[UIAlertView alloc] initWithTitle:@"" message:@"Please enter a valid password" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alertV show];
        return;
    
    }
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    NSDictionary *paramsDictInternal = @{@"username":@"dabar.parihar@gslab.com",@"password":@"qwerty",@"":@""};
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:paramsDictInternal
                                                       options:0 // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    NSString *paramsJsonString = @"";
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        paramsJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
    NSMutableDictionary *params = [NSMutableDictionary new];
    [params setObject:paramsJsonString forKey:@"data"];
    
    [manager POST:[NSString stringWithFormat:@"%@%@/",kSUBSCRIPTION_SERVER_URL_PROD,kAPI_METHOD_LOGIN_POST] parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"%@",responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error.description);
        
    }];
    
}

@end
