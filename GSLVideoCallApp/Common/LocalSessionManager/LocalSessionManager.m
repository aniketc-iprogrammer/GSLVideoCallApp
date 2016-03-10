//
//  LocalSessionManager.m
//  GSLVideoCallApp
//
//  Created by Aniket on 09/03/16.
//  Copyright © 2016 GSLabs. All rights reserved.
//

#import "LocalSessionManager.h"
#import "Constant.h"
#import "NSUserDefaults+RMSaveCustomObject.h"


@implementation LocalSessionManager

+(void)saveBaseUserSessionInUserdefaults{
    [[NSUserDefaults standardUserDefaults] rm_setCustomObject:kBASEUSER forKey:USERDEFAULTS_KEY_BASE_USER_SESSION];
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

+(BOOL)loadBaseUserSessionIntoMemnoryFromUserDefaults{
    BOOL successToLoad;
    if([[NSUserDefaults standardUserDefaults] objectForKey:USERDEFAULTS_KEY_BASE_USER_SESSION]){
        kBASEUSER = [[NSUserDefaults standardUserDefaults] rm_customObjectForKey:USERDEFAULTS_KEY_BASE_USER_SESSION];
        successToLoad = YES;
    }else{
        successToLoad = NO;
    }
    return successToLoad;
}

@end
