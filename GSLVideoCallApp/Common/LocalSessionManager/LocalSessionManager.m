//
//  LocalSessionManager.m
//  GSLVideoCallApp
//
//  Created by Aniket on 09/03/16.
//  Copyright © 2016 GSLabs. All rights reserved.
//

#import "LocalSessionManager.h"

@implementation LocalSessionManager

+(void)saveBaseUserSessionInUserdefaults:(NSObject *)baseuserSession{
    [[NSUserDefaults standardUserDefaults] setObject:baseuserSession forKey:USERDEFAULTS_KEY_BASE_USER_SESSION];
}

+(BOOL)isBaseUserSessionExists{
    
    if([[NSUserDefaults standardUserDefaults] objectForKey:USERDEFAULTS_KEY_BASE_USER_SESSION])
        return YES;
    else
        return NO;

}

+(BOOL)clearBaseUserUserSession{
    @try {
        
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:USERDEFAULTS_KEY_BASE_USER_SESSION];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    @catch (NSException *exception) {
        NSLog(@"%@",exception);
        return false;
    }
    return true;
}

@end
