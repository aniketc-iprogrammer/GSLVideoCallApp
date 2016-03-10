//
//  UserInfoModel.h
//  GSLVideoCallApp
//
//  Created by Aniket on 09/03/16.
//  Copyright © 2016 GSLabs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GroupInfoModel.h"

@interface UserInfoModel : NSObject

@property (strong,nonatomic) NSString *firstName;
@property (strong,nonatomic) NSString *lastName;
@property (strong,nonatomic) NSString *fullName;
@property (strong,nonatomic) NSString *emailId;
@property (strong,nonatomic) NSString *displayPictureUrl;
@property (strong,nonatomic) GroupInfoModel *groupInfo;

@end
