//
//  ZXHttpRequest.h
//  FrameDemo
//
//  Created by 展祥叶 on 16/10/26.
//  Copyright © 2016年 ye zhanxiang. All rights reserved.
//

#import "ZXBaseRequest.h"

@class ZXHttpRequest;
// 请求数据解析 protocol
@protocol ZXHttpResponseParser <NSObject>

- (BOOL)isValidResponse:(id)response request:(ZXHttpRequest *)request error:(NSError *__autoreleasing *)error;

- (id)parseResponse:(id)response request:(ZXHttpRequest *)request;

@end

@interface ZXHttpRequest : ZXBaseRequest

@property (nonatomic, assign, readonly) BOOL responseFromCache; // response是否来自缓存

// 是否请求缓存的response 默认NO
@property (nonatomic, assign) BOOL requestFromCache;

// 是否缓存response ，有效的response才会缓存 默认NO
@property (nonatomic, assign) BOOL cacheResponse;

// 缓存时间 默认7天
@property (nonatomic, assign) NSInteger cacheTimeInSeconds;

// 缓存忽略的某些Paramters的key
@property (nonatomic, strong) NSArray *cacheIgnoreParamtersKeys;

@property (nonatomic, strong) id<ZXHttpResponseParser> responseParser; // 数据解析

@end
