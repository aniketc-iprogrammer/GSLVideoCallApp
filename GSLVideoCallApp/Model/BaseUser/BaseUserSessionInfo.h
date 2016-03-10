//
//  BaseUserSessionInfo.h
//  GSLVideoCallApp
//
//  Created by Aniket on 09/03/16.
//  Copyright © 2016 GSLabs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfoModel.h"

@interface BaseUserSessionInfo : NSObject

+(instancetype)sharedInstance;

@property (strong,nonatomic) UserInfoModel* personalInfo;

@end
