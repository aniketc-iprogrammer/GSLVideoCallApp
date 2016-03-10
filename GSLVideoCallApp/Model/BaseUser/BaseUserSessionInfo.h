//
//  BaseUserSessionInfo.h
//  GSLVideoCallApp
//
//  Created by Aniket on 09/03/16.
//  Copyright © 2016 GSLabs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfoModel.h"
#import "GroupInfoModel.h"

@interface BaseUserSessionInfo : NSObject

+(instancetype)sharedInstance;

@property (strong,nonatomic) UserInfoModel* personalInfo;
@property (strong,nonatomic) GroupInfoModel *groupInfo;


@end
