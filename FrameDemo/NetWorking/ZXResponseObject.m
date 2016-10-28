//
//  ZXResponseObject.m
//  FrameDemo
//
//  Created by 展祥叶 on 16/10/27.
//  Copyright © 2016年 ye zhanxiang. All rights reserved.
//

#import "ZXResponseObject.h"

@implementation ZXResponseObject

- (BOOL)isValidResponse:(id)response request:(ZXHttpRequest *)request error:(NSError *__autoreleasing *)error
{
    if (!response) {
        *error = [NSError errorWithDomain:@"response is nill" code:-1 userInfo:nil];
        return NO;
    }
    
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)request.dataTask.response;
    NSInteger responseStatusCode = [httpResponse statusCode];
    
    
    //StatusCode
    if (responseStatusCode < 200 || responseStatusCode > 299) {
        *error = [NSError errorWithDomain:@"invalid http request" code:responseStatusCode userInfo:nil];
        return NO;
    }
    return YES;
}

- (id)parseResponse:(id)response request:(ZXHttpRequest *)request
{
    _data = response;
    return self;
}

- (NSString *)description
{
    return  [NSString stringWithFormat:@"\nstatus:%d\nmsg:%@\n",(int)_status,_msg?_msg : @""];
}

@end
