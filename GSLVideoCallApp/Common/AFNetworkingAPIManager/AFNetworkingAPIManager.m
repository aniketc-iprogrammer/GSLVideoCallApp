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
@property (strong,nonatomic) NSString* parametersString;
@property (nonatomic,assign) apiMethodType methodType;


@end

@implementation AFNetworkingAPIManager

-(id)initWithURL:(NSString *)webmethodUrl params:(NSString *)paramerters methodType:(apiMethodType)methodType delegate:(id)delegate{
    if(self = [super init]){
        _delegate = delegate;
        _webMethodUrl = webmethodUrl;
        _parametersString = paramerters;
        _methodType = methodType;
    }
    return self;
}

-(void)startAPIInvokation{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    if(_methodType == apiMethodTypePost){
    
        NSMutableDictionary *params = [NSMutableDictionary new];
        [params setObject:_parametersString forKey:@"data"];
        [manager POST:_webMethodUrl parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            [_delegate apiCallDidFinish:responseObject];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            [_delegate apiCallDidFail:error];
            
        }];
    
    }else if (_methodType == apiMethodTypeGet){

        [manager GET:_webMethodUrl parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
        
            [_delegate apiCallDidFinish:responseObject];

        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            [_delegate apiCallDidFail:error];
        
        }];
        
    }

}

@end
