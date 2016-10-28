//
//  ZXHttpRequest.m
//  FrameDemo
//
//  Created by 展祥叶 on 16/10/26.
//  Copyright © 2016年 ye zhanxiang. All rights reserved.
//

#import "ZXHttpRequest.h"
#import "ZXHttpManager.h"

@interface ZXHttpRequest ()

@end

@implementation ZXHttpRequest

- (instancetype)init
{
    if (self = [super init]) {
        _cacheTimeInSeconds = 60*60*24*7;
    }
    return self;
}

#pragma mark - load request

- (void)load
{
    _responseFromCache = NO;
    if (_requestFromCache && _cacheTimeInSeconds >=0) {
        //从缓存中获取
       
    }
    
    if (!_responseFromCache) {
        //请求数据
        [super load];
    }
}

- (BOOL)validResponseObject:(id)responseObject error:(NSError *__autoreleasing *)error
{
    id<ZXHttpResponseParser> responseParser = [self responseParser];
    if (responseParser == nil) {
        return [super validResponseObject:responseObject error:error];
    }
    
    if ([responseParser isValidResponse:responseObject request:self error:error]) {
        
        //验证后 解析数据
        id responseParsedObject = [responseParser parseResponse:responseObject request:self];
        return [super validResponseObject:responseParsedObject error:error];
    }else {
        return NO;
    }
}

@end
