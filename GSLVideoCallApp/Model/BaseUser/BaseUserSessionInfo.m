//
//  BaseUserSessionInfo.m
//  GSLVideoCallApp
//
//  Created by Aniket on 09/03/16.
//  Copyright © 2016 GSLabs. All rights reserved.
//

#import "BaseUserSessionInfo.h"

@implementation BaseUserSessionInfo

-(id)init{
    if(self = [super init]){
        _personalInfo = [UserInfoModel new];
        _groupInfo = [GroupInfoModel new];
    }
    return self;
}

+(instancetype)sharedInstance{
    static BaseUserSessionInfo *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[BaseUserSessionInfo alloc] init];
    });
    return instance;
}

@end
