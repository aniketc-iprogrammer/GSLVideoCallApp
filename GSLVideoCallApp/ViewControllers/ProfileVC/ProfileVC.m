//
//  ProfileVC.m
//  GSLVideoCallApp
//
//  Created by Aniket on 11/03/16.
//  Copyright © 2016 GSLabs. All rights reserved.
//

#import "ProfileVC.h"
#import "SWRevealViewController.h"
#import "Constant.h"
#import "UIImageView+AFNetworking.h"


@interface ProfileVC ()

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

@property (weak, nonatomic) IBOutlet UIImageView *imgProfileView;
@property (weak, nonatomic) IBOutlet UITextField *txtDisplayName;
@property (weak, nonatomic) IBOutlet UITextField *txtEmailId;


@end

@implementation ProfileVC

- (void)viewDidLoad {

    [super viewDidLoad];
    [self setupLeftMenuButton];
    [self loadFormData];
}

- (void)loadFormData{
    _txtDisplayName.text = kBASEUSER_PROFILE_INFO.name;
    _txtEmailId.text = kBASEUSER_PROFILE_INFO.email;
    
    NSString *imageUrlString = [NSString stringWithFormat:@"%@%@%@",kSUBSCRIPTION_SERVER_URL_PROD,kBASEUSER.displayPicturePath,kBASEUSER_PROFILE_INFO.avatarName];
    NSURL *displyPictureUrl = [NSURL URLWithString:imageUrlString];
    [_imgProfileView setImageWithURL:displyPictureUrl];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupLeftMenuButton{
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }

}

#pragma mark - BUTTON ACTIONS

- (IBAction)btnCaptureImageTchUp:(id)sender {
    
}

- (IBAction)btnUpdateProfileTchUp:(id)sender {
    
}

@end
