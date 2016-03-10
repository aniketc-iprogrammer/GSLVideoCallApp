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

@interface SidebarViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSArray *menuItems;
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
   
    _menuItems = [NSArray arrayWithObjects:@"Home",@"Edit Profile",@"Logout", nil];
    _lblUserDisplayName.text = kBASEUSER_PROFILE_INFO.name;
    _lblUserEmail.text = kBASEUSER_PROFILE_INFO.email;
    
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
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.row == 2){
        
        if([LocalSessionManager clearBaseUserUserSession]){
            [Utility setNavigationForLoggedOutSession];
        }
    
    }
}

@end
