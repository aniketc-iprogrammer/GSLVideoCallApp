//
//  ProfileVC.m
//  GSLVideoCallApp
//
//  Created by Aniket on 11/03/16.
//  Copyright © 2016 GSLabs. All rights reserved.
//

#import "ProfileVC.h"
#import "SWRevealViewController.h"

@interface ProfileVC ()

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

@end

@implementation ProfileVC

- (void)viewDidLoad {

    [super viewDidLoad];
    [self setupLeftMenuButton];
    // Do any additional setup after loading the view.
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

@end
