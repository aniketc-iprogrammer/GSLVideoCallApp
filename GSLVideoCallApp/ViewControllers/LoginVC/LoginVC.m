//
//  LoginVC.m
//  GSLVideoCallApp
//
//  Created by Aniket on 09/03/16.
//  Copyright © 2016 GSLabs. All rights reserved.
//

#import "LoginVC.h"
#import "Utility.h"

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
    
}

@end
