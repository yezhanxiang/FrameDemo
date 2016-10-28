//
//  ZXHttpManager.m
//  FrameDemo
//
//  Created by 展祥叶 on 16/10/26.
//  Copyright © 2016年 ye zhanxiang. All rights reserved.
//

#import "ZXHttpManager.h"
#import "AFNetworking.h"

@implementation ZXHttpManager

+ (ZXHttpManager *)sharedInstance
{
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

+ (dispatch_queue_t)completeQueue {
    static dispatch_queue_t completeQueue = NULL;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        completeQueue = dispatch_queue_create("com.ZXHttpManager.completeQueue", DISPATCH_QUEUE_SERIAL);
        dispatch_set_target_queue(completeQueue, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0));
    });
    return completeQueue;
}

- (instancetype)init
{
    if (self = [super init]) {
        _requestConfiguration = [ZXRequestConfigure sharedInstance];
    }
    
    return self;
}

#pragma mark - add request

- (void)addRequest:(id<ZXRequestProtocol>)request
{
    AFHTTPSessionManager *manager = [self defaultSessionManagerWithRequest:request];
    
    [self configurationSessionManager:manager request:request];
    
    [self loadRequest:request sessionManager:manager];
}

- (void)cancelRequest:(id<ZXRequestProtocol>)request
{
    [request cancel];
}

#pragma mark - configure http manager
- (AFHTTPSessionManager *)defaultSessionManagerWithRequest:(id<ZXRequestProtocol>)request
{
    ZXRequestConfigure *requestConfiguration = [request configuration];
    if (requestConfiguration == nil) {
        requestConfiguration = self.requestConfiguration;
    }
    
    AFHTTPSessionManager *manager = nil;
    if (requestConfiguration.sessionConfiguration) {
        manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:requestConfiguration.baseURL] sessionConfiguration:requestConfiguration.sessionConfiguration];
    }else {
        manager = [AFHTTPSessionManager manager];
    }
    manager.completionQueue = [[self class] completeQueue];
    return manager;
}

- (void)configurationSessionManager:(AFHTTPSessionManager *)manager request:(id<ZXRequestProtocol>)request;
{
    if ([request serializerType] == ZXRequestSerializerTypeJSON) {
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
    }else if ([request serializerType] == ZXRequestSerializerTypeString) {
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    }
    
    NSDictionary *headerFieldValue = [request headerFieldValues];
    if (headerFieldValue) {
        [headerFieldValue enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            if ([key isKindOfClass:[NSString class]] && [obj isKindOfClass:[NSString class]]) {
                [manager.requestSerializer setValue:obj forHTTPHeaderField:key];
            }
        }];
    }
    
    manager.requestSerializer.cachePolicy = [request cachePolicy];
    manager.requestSerializer.timeoutInterval = [request timeoutInterval];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain", @"text/javascript", @"text/json", @"text/html", nil];
    
}

- (NSString *)buildRequestURL:(id<ZXRequestProtocol>)request
{
    NSString *URLPath = [request URLString];
    if ([URLPath hasPrefix:@"http:"]) {
        return URLPath;
    }
    
    NSString *baseURL = request.baseURL.length > 0 ? request.baseURL : request.configuration.baseURL;
    
    return [NSString stringWithFormat:@"%@%@", baseURL?baseURL:@"", URLPath];
}

- (void)loadRequest:(id<ZXRequestProtocol>)request sessionManager:(AFHTTPSessionManager *)manager
{
    NSString *URLString = [self buildRequestURL:request];
    NSDictionary *parameters = [request parameters];
    
    ZXRequestMethod requestMethod = [request method];
    AFProgressBlock progressBlock = [request progressBlock];
    
    if (requestMethod == ZXRequestMethodGet) {
        request.dataTask = [manager GET:URLString parameters:parameters progress:progressBlock success:^(NSURLSessionDataTask *task, id  responseObject) {
            [request requestDidResponse:responseObject error:nil];
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [request requestDidResponse:nil error:error];
        }]; 
    }else if (requestMethod == ZXRequestMethodPost) {
        
        AFConstructingBodyBlock constructingBodyBlock = [request constructingBodyBlock];
        if (constructingBodyBlock) {
        
            request.dataTask = [manager POST:URLString parameters:parameters constructingBodyWithBlock:constructingBodyBlock progress:progressBlock success:^(NSURLSessionDataTask *task, id responseObject) {
                [request requestDidResponse:responseObject error:nil];
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                [request requestDidResponse:nil error:error];
            }];
            
        }else {
        
            request.dataTask = [manager POST:URLString parameters:parameters progress:progressBlock success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [request requestDidResponse:responseObject error:nil];
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                [request requestDidResponse:nil error:error];
            }];
            
        }
        
    }else if (requestMethod == ZXRequestMethodHead) {
        
        request.dataTask = [manager HEAD:URLString parameters:parameters success:^(NSURLSessionDataTask * task) {
            [request requestDidResponse:nil error:nil];
        } failure:^(NSURLSessionDataTask * task, NSError * error) {
            [request requestDidResponse:nil error:error];
        }];
    }else if (requestMethod == ZXRequestMethodPut) {
        
        request.dataTask = [manager PUT:URLString parameters:parameters success:^(NSURLSessionDataTask * task, id responseObject) {
            [request requestDidResponse:responseObject error:nil];
        } failure:^(NSURLSessionDataTask * task, NSError * error) {
            [request requestDidResponse:nil error:error];
        }];
    }else if (requestMethod == ZXRequestMethodPatch) {
        
        request.dataTask = [manager PATCH:URLString parameters:parameters success:^(NSURLSessionDataTask * task, id responseObject) {
            [request requestDidResponse:responseObject error:nil];
        } failure:^(NSURLSessionDataTask * task, NSError * error) {
            [request requestDidResponse:nil error:error];
        }];
    }

}

@end
