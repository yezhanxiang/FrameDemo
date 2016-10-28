//
//  ZXBaseRequest.h
//  FrameDemo
//
//  Created by 展祥叶 on 16/10/25.
//  Copyright © 2016年 ye zhanxiang. All rights reserved.
//  

#import "ZXRequestProtocol.h"
#import "ZXRequestURLInfo.h"

typedef void (^ZXRequestSuccessBlock)(id<ZXRequestProtocol> request);
typedef void (^ZXRequestFailureBlock)(id<ZXRequestProtocol> request,NSError *error);

@protocol ZXRequestOverride <NSObject>

// 收到请求数据， 如果error == nil
- (void)requestDidResponse:(id)responseObject error:(NSError *)error;

// 验证请求数据
- (BOOL)validResponseObject:(id)responseObject error:(NSError *__autoreleasing *)error;

// 请求成功
- (void)requestDidFinish;

// 请求失败
- (void)requestDidFailWithError:(NSError* )error;

@end

@interface ZXBaseRequest : NSObject<ZXRequestProtocol, ZXRequestOverride>

#pragma mark - request
@property (nonatomic, weak) NSURLSessionDataTask *dataTask;
@property (nonatomic, assign, readonly) ZXRequestState state;
@property (nonatomic, strong, readonly) id responseObject;

@property (nonatomic, weak) id<ZXRequestDelegate> delegate; //请求代理
@property (nonatomic, strong) id<ZXRequestDelegate> embedAccesory; //完成请求代理 后调用 注意strong

@property (nonatomic, assign) BOOL asynCompleteQueue; // 在异步线程中回调 默认NO

#pragma mark - block
@property (nonatomic, copy, readonly) ZXRequestSuccessBlock successBlock; // 请求成功block
@property (nonatomic, copy, readonly) ZXRequestFailureBlock failureBlock; // 请求失败block

@property (nonatomic, copy) AFProgressBlock progressBlock;// 请求进度block
@property (nonatomic, copy) AFConstructingBodyBlock constructingBodyBlock;// post请求组装body block

#pragma mark - request params
// baseURL 如果为空，则为全局或者本类requestConfigure.baseURL
@property (nonatomic, strong) NSString *baseURL;

// 请求的URLString 或者 URL path
@property (nonatomic, strong) NSString *URLString;

//请求方法 默认GET
@property (nonatomic, assign) ZXRequestMethod method;

// 请求参数
@property (nonatomic, strong) NSDictionary *parameters;

//设置请求格式  默认JSON
@property (nonatomic, assign) ZXRequestSerializerType serializerType;

// 请求缓存策略
@property (nonatomic, assign) NSURLRequestCachePolicy cachePolicy;

// 请求的连接超时时间，默认为60秒
@property (nonatomic, assign) NSTimeInterval timeoutInterval;

// 请求设置 默认 使用 全局的requestConfigure
@property (nonatomic, strong) ZXRequestConfigure *configuration;

// 在HTTP报头添加的自定义参数
@property (nonatomic, strong) NSDictionary *headerFieldValues;

#pragma mark - method
// 请求
- (void)load;

//设置回调Block
- (void)setRequestSuccessBlock:(ZXRequestSuccessBlock)successBlock failureBlock:(ZXRequestFailureBlock)failureBlock;

- (void)loadWithSuccessBlock:(ZXRequestSuccessBlock)successBlock failureBlock:(ZXRequestFailureBlock)failureBlock;

//取消
- (void)cancel;

@end
