//
//  SidebarViewController.m
//  SidebarDemo
//
//  Created by Simon on 29/6/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import "SidebarViewController.h"
#import "LeftMenuTableCell.h"
#import "Utility.h"
#import "LocalSessionManager.h"
#import "Constant.h"
#import "UIImageView+AFNetworking.h"
#import "DAAlertController.h"

@interface SidebarViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSArray *menuItems;
@property (nonatomic, strong) NSArray *menuImageItems;

@property (weak, nonatomic) IBOutlet UITableView *tblMenuList;
@property (weak, nonatomic) IBOutlet UILabel *lblUserDisplayName;
@property (weak, nonatomic) IBOutlet UILabel *lblUserEmail;
@property (weak, nonatomic) IBOutlet UIImageView *imgUserDisplayPicture;

@end

@implementation SidebarViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadData];
    [self setUpTableView];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Data Loading

- (void)loadData{
   
    if([kBASEUSER_GROUP_INFO.userType isEqualToString:@"admin"]){
        _menuItems = [NSArray arrayWithObjects:@"Home",@"Profile",@"Add Member",@"Logout", nil];
        _menuImageItems = [NSArray arrayWithObjects:@"home",@"edit",@"add",@"logout", nil];
    }else{
        _menuItems = [NSArray arrayWithObjects:@"Home",@"Profile",@"Logout", nil];
        _menuImageItems = [NSArray arrayWithObjects:@"home",@"edit",@"logout", nil];
    }
    
    _lblUserDisplayName.text = [kBASEUSER_PROFILE_INFO.name capitalizedString];
    _lblUserEmail.text = kBASEUSER_PROFILE_INFO.email;
    
    _imgUserDisplayPicture.layer.cornerRadius = 34.0f;
    _imgUserDisplayPicture.layer.borderWidth = 2.0;
    _imgUserDisplayPicture.layer.borderColor = [UIColor whiteColor].CGColor;
    _imgUserDisplayPicture.clipsToBounds = YES;
    
    NSString *imageUrlString = [NSString stringWithFormat:@"%@%@%@",kSUBSCRIPTION_SERVER_URL_PROD,kBASEUSER.displayPicturePath,kBASEUSER_PROFILE_INFO.avatarName];
    NSURL *displyPictureUrl = [NSURL URLWithString:imageUrlString];
    [_imgUserDisplayPicture setImageWithURL:displyPictureUrl];

}

#pragma mark - Table view data source

- (void)setUpTableView{
    _tblMenuList.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _menuItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"leftmenucellidef";
    LeftMenuTableCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.lblMenuItemTitle.text = [_menuItems objectAtIndex:indexPath.row];
    cell.imgMenuItem.image = [UIImage imageNamed:[_menuImageItems objectAtIndex:indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath .row == 0){
        [self performSegueWithIdentifier:@"revelhomevc" sender:nil];
        return;
    }else if (indexPath.row == 1){
        [self performSegueWithIdentifier:@"revelprofilevc" sender:nil];
        return;
    }
    
    if([kBASEUSER_GROUP_INFO.userType isEqualToString:@"admin"] && indexPath.row == 3){
        
        [self logOut];
        
    }else if (![kBASEUSER_GROUP_INFO.userType isEqualToString:@"admin"] && indexPath.row == 2){
        
        [self logOut];
        
    }else if ([kBASEUSER_GROUP_INFO.userType isEqualToString:@"admin"] && indexPath.row == 2){
    
        [self performSegueWithIdentifier:@"reveladdmembervc" sender:nil];
    
    }
    
}

- (void)logOut{
    
    DAAlertAction *okAction = [DAAlertAction actionWithTitle:@"Logout" style:DAAlertActionStyleDefault handler:^{
        if([LocalSessionManager clearBaseUserUserSession])
            [Utility setNavigationForLoggedOutSession];
    }];
    
    DAAlertAction *cancelAction = [DAAlertAction actionWithTitle:@"Cancel" style:DAAlertActionStyleCancel handler:nil];
    
    [DAAlertController showAlertViewInViewController:self withTitle:@"Logout" message:@"Are you sure, you want to log out?" actions:@[cancelAction,okAction]];
}

@end
