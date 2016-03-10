//
//  BaseUserSessionInfo.h
//  GSLVideoCallApp
//
//  Created by Aniket on 09/03/16.
//  Copyright © 2016 GSLabs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"


@interface BaseUserSessionInfo : NSObject

@property (strong,nonatomic) UserModel *baseUser;

+(instancetype)sharedInstance;


@end
