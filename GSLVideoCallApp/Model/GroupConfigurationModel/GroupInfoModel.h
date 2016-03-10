//
//  GroupInfoModel.h
//  GSLVideoCallApp
//
//  Created by Aniket on 09/03/16.
//  Copyright © 2016 GSLabs. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface GroupInfoModel : JSONModel

@property (strong,nonatomic) NSString *groupId;
@property (strong,nonatomic) NSString *groupMemberCount;
@property (strong,nonatomic) NSString *groupName;
@property (strong,nonatomic) NSString *userType;

@end
