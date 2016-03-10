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

@interface SidebarViewController ()

@property (nonatomic, strong) NSArray *menuItems;

@end

@implementation SidebarViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _menuItems = [NSArray arrayWithObjects:@"Home",@"Edit Profile",@"Logout", nil];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

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
