//
//  ZXRequestProtocol.h
//  FrameDemo
//
//  Created by 展祥叶 on 16/10/25.
//  Copyright © 2016年 ye zhanxiang. All rights reserved.
//  学习用的，参考自TYHttpManager

#import <Foundation/Foundation.h>
#import "ZXRequestConfigure.h"

typedef NS_ENUM(NSUInteger, ZXRequestMethod) {
    ZXRequestMethodGet,
    ZXRequestMethodPost,
    ZXRequestMethodHead,
    ZXRequestMethodPut,
    ZXRequestMethodDelete,
    ZXRequestMethodPatch
};

typedef NS_ENUM(NSInteger , ZXRequestSerializerType) {
    ZXRequestSerializerTypeHTTP,
    ZXRequestSerializerTypeJSON,
    ZXRequestSerializerTypeString
};

typedef NS_ENUM(NSUInteger, ZXRequestState) {
    ZXRequestStateReady,
    ZXRequestStateLoading,
    ZXRequestStateCancle,
    ZXRequestStateFinish,
    ZXRequestStateError
};

@protocol AFMultipartFormData; // need import afnetwork
typedef void(^AFProgressBlock)(NSProgress * progress);
typedef void(^AFConstructingBodyBlock)(id <AFMultipartFormData> formData);


@protocol ZXRequestProtocol;
@protocol ZXRequestDelegate <NSObject>

@optional

- (void)requestDidFinish:(id<ZXRequestProtocol>)request;

- (void)requestDidFail:(id<ZXRequestProtocol>)request error:(NSError *)error;

@end


@protocol ZXRequestProtocol <NSObject>
@property (nonatomic, weak) NSURLSessionDataTask *dataTask;

@property (nonatomic, assign, readonly) ZXRequestState state;
@property (nonatomic, strong, readonly) id responseObject;

@property (nonatomic, weak) id<ZXRequestDelegate> delegate; // 请求代理
@property (nonatomic, strong) id<ZXRequestDelegate> embedAccesory; // 嵌入请求代理 注意strong

// baseURL 如果为空，则为全局或者本类requestConfigure.baseURL
- (NSString *)baseURL;

// 请求的URLString,或者 URL path
- (NSString *)URLString;

// 请求参数
- (NSDictionary *)parameters;

// 请求的方法 默认get
- (ZXRequestMethod)method;

//request configure
- (ZXRequestConfigure *)configuration;

// 在HTTP报头添加的自定义参数
- (NSDictionary *)headerFieldValues;

// 请求的连接超时时间，默认为60秒
- (NSTimeInterval)timeoutInterval;

// 缓存策略
- (NSURLRequestCachePolicy) cachePolicy;

// 设置请求格式 默认 JSON
- (ZXRequestSerializerType)serializerType;

// 返回进度block
- (AFProgressBlock)progressBlock;

// 返回post组装body block
- (AFConstructingBodyBlock)constructingBodyBlock;

// 处理请求数据， 如果error == nil ,请求成功
- (void)requestDidResponse:(id)responseObject error:(NSError *)error;

// 请求
- (void)load;

//取消
- (void)cancel;

@end
