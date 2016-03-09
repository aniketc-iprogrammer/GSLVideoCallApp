//
//  Utility.h
//  GSLVideoCallApp
//
//  Created by Aniket on 08/03/16.
//  Copyright © 2016 GSLabs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Utility : NSObject

+ (UIImage *)getColouredImage:(CGSize)size color:(UIColor *)color;

+ (UIColor *)colorFromHexString:(NSString *)hexString ;

@end
