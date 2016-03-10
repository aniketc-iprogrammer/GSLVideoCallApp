//
//  LocalSessionManager.h
//  GSLVideoCallApp
//
//  Created by Aniket on 09/03/16.
//  Copyright © 2016 GSLabs. All rights reserved.
//

#import <Foundation/Foundation.h>

#define USERDEFAULTS_KEY_BASE_USER_SESSION @"BaseUserSessionObject"

@interface LocalSessionManager : NSObject

+(void)saveBaseUserSessionInUserdefaults;
+(BOOL)isBaseUserSessionExists;
+(BOOL)clearBaseUserUserSession;
+(BOOL)loadBaseUserSessionIntoMemnoryFromUserDefaults;

@end
