//
//  ZXResponseObject.h
//  FrameDemo
//
//  Created by 展祥叶 on 16/10/27.
//  Copyright © 2016年 ye zhanxiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZXHttpRequest.h"

@interface ZXResponseObject : NSObject<ZXHttpResponseParser>

@property (nonatomic, strong) NSString *msg; //消息

@property (nonatomic, assign) NSInteger status; //状态吗

@property (nonatomic, strong) id data; //json

// 验证
- (BOOL)isValidResponse:(id)response request:(ZXHttpRequest *)request error:(NSError *__autoreleasing *)error;

// 解析 返回ResponseObject
- (id)parseResponse:(id)response request:(ZXHttpRequest *)request;

@end
