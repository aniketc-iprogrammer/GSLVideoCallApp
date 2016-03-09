//
//  LoginVC.h
//  GSLVideoCallApp
//
//  Created by Aniket on 09/03/16.
//  Copyright © 2016 GSLabs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginVC : UIViewController

@property (weak,nonatomic) IBOutlet UIButton *btnLogin;
@property (weak,nonatomic) IBOutlet UITextField *txtUsername;
@property (weak,nonatomic) IBOutlet UITextField *txtPassword;

- (IBAction)btnLoginTchUp:(UIButton *)sender;

@end
