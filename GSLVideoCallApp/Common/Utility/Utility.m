//
//  Utility.m
//  GSLVideoCallApp
//
//  Created by Aniket on 08/03/16.
//  Copyright © 2016 GSLabs. All rights reserved.
//

#import "Utility.h"

@implementation Utility

+(UIImage *)getColouredImage:(CGSize)size color:(UIColor *)color{
    UIGraphicsBeginImageContextWithOptions(size, YES, 0);
    [color setFill];
    UIRectFill(CGRectMake(0, 0, size.width, size.height));
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIColor *)colorFromHexString:(NSString *)hexString {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:0]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}

+ (BOOL)isValidPassword:(NSString *)string {
    NSString *emailRegex = @"[A-Z0-9a-z]*";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:string];
}

+(BOOL)isValidateEmailAddress:(NSString *)email {
    NSString *emailRegex=@"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailtest=[NSPredicate predicateWithFormat:@"Self matches %@",emailRegex];
    return [emailtest evaluateWithObject:email];
}

+(void)showSimpleDefaultAlertWithMessage:(NSString *)message{
    UIAlertView *alertV = [[UIAlertView alloc] initWithTitle:@"" message:message delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alertV show];
}

+ (NSString *) getJsonForNSDictionry:(NSDictionary *)dict{
    
    NSError *error;
    NSData  *jsonData = [NSJSONSerialization dataWithJSONObject:dict
                                                       options:0 // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    NSString *paramsJsonString = @"";
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        paramsJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return paramsJsonString;
}

@end
