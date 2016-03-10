//
//  AFNetworkingAPIManager.m
//  GSLVideoCallApp
//
//  Created by Aniket on 09/03/16.
//  Copyright © 2016 GSLabs. All rights reserved.
//

#import "AFNetworkingAPIManager.h"
#import "AFNetworking.h"


@interface AFNetworkingAPIManager(){

}

@property (strong,nonatomic) NSString* webMethodUrl;
@property (strong,nonatomic) NSString* parametersJsonString;
@property (nonatomic,assign) apiMethodType methodType;


@end

@implementation AFNetworkingAPIManager

-(id)initWithURL:(NSString *)webmethodUrl params:(NSString *)paramerters methodType:(apiMethodType)methodType delegate:(id)delegate{
    if(self = [super init]){
        _delegate = delegate;
        _webMethodUrl = webmethodUrl;
        _parametersJsonString = paramerters;
        _methodType = methodType;
    }
    return self;
}

-(void)startAPIInvokation{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    
    NSMutableDictionary *params = [NSMutableDictionary new];
    [params setObject:_parametersJsonString forKey:@"data"];
    
    
    [manager POST:_webMethodUrl parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
                [_delegate apiCallFinished:responseObject];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [_delegate apiCallDidFailed:error];
    
    }];
    
}

@end
