//
//  Constant.h
//  Idea
//
//  Created by Nilesh Kotkar on 11/2/15.
//  Copyright (c) 2015 iProgrammer Pvt Ltd. All rights reserved.
//

#ifndef Idea_Constant_h
#define Idea_Constant_h


#import "Utility.h"
#import "BaseUserSessionInfo.h"

#ifndef DLog
#ifdef DEBUG
#define DLog(_format_, ...) NSLog(_format_, ## __VA_ARGS__)
#else
#define DLog(_format_, ...)
#endif
#endif




#pragma mark - DEVICE COMMON CONSTATNS

#define IS_IPAD (UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPhone)
#define IS_IPHONE (!IS_IPAD)
#define IS_IPHONE_4 (fabs((double)[[UIScreen mainScreen]bounds].size.height - (double)480) < DBL_EPSILON)
#define IS_IPHONE_5 (fabs((double)[[UIScreen mainScreen]bounds].size.height - (double)568) < DBL_EPSILON)
#define IS_IPHONE_6 (fabs((double)[[UIScreen mainScreen]bounds].size.height - (double)667) < DBL_EPSILON)
#define IS_IPHONE_6_PLUS (fabs((double)[[UIScreen mainScreen]bounds].size.height - (double)736) < DBL_EPSILON)
#define IS_OS_7_OR_BEFORE    ([[[UIDevice currentDevice] systemVersion] floatValue] < 8.0)
#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define IOS_NEWER_OR_EQUAL_TO_7 ( [ [ [ UIDevice currentDevice ] systemVersion ] floatValue ] >= 7.0 )




#pragma mark - FONT CONSTANTS

#define kHELVETICA_NEUE @"HelveticaNeue"
#define kHELVETICA_NEUE_LIGHT @"HelveticaNeue-Light"
#define kHELVETICA_NEUE_BOLD @"HelveticaNeue-Bold"
#define kHELVETICA_NEUE_MEDIUM @"HelveticaNeue-Medium"
#define kHELVETICA_NEUE_CONDENSED @"HelveticaNeue-CondensedBlack"

#define kSF_UI_TEXT_REGULAR   @"SFUIText-Regular"
#define kSF_UI_TEXT_LIGHT     @"SFUIText-Light"
#define kSF_UI_TEXT_BOLD     @"SFUIText-Bold"
#define kSF_UI_TEXT_MEDIUM     @"SFUIText-Medium"




#pragma mark - COLOR COMMON CONSTATNS

#define RGB(r, g, b, a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

#define kDEFAULT_NAVBAR_COLOR_BG [Utility colorFromHexString:@"ffc12d"]

#define kCOLOR_FROM_HEX(hexcode) [Utility colorFromHexString:hexcode];



#pragma mark - SUBSCRIPTION SERVER AND API CONSTANTS

#define kSUBSCRIPTION_SERVER_URL_PROD @"http://173.72.57.143/"
#define kSUBSCRIPTION_SERVER_URL_DEV @"http://10.43.5.22/" //173.72.57.143 //ec2-54-208-109-141.compute-1.amazonaws.com
#define kAPI_METHOD_LOGIN_POST @"login"
#define kAPI_METHOD_USER_GET @"user"
#define kAPI_METHOD_VERIFYOTP_POST @"verifyOTP"
#define kAPI_METHOD_ADD_USER_POST @"add/user"



#pragma mark - API RESPONSE CONSTATNS

#define STATUS @"status"
#define SUCCESS @"success"
#define FAILED @"failed"


#pragma mark - BASEUSER SESSION OBJECT CONSTANTS

#define kBASEUSER [BaseUserSessionInfo sharedInstance].baseUser
#define kBASEUSER_PROFILE_INFO [BaseUserSessionInfo sharedInstance].baseUser.profileInfo
#define kBASEUSER_GROUP_INFO [BaseUserSessionInfo sharedInstance].baseUser.groupInfo

#endif


