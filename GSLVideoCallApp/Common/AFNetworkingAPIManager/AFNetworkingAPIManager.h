//
//  AFNetworkingAPIManager.h
//  GSLVideoCallApp
//
//  Created by Aniket on 09/03/16.
//  Copyright © 2016 GSLabs. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    apiMethodTypeGet,
    apiMethodTypePost
} apiMethodType;

@protocol AFNetworkingAPIManagerDelegate <NSObject>

@optional

- (void)apiCallDidFailed:(NSError *)error;
- (void)apiCallFinished:(id)result;

@end

@interface AFNetworkingAPIManager : NSObject

@property (nonatomic, strong) id <AFNetworkingAPIManagerDelegate> delegate;

-(id)initWithURL:(NSString *)webmethodUrl params:(NSString *)paramerters methodType:(apiMethodType)methodType delegate:(id)delegate;

-(void)startAPIInvokation;

@end
