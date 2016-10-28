//
//  ZXHttpManager.h
//  FrameDemo
//
//  Created by 展祥叶 on 16/10/26.
//  Copyright © 2016年 ye zhanxiang. All rights reserved.
//

#import "ZXRequestProtocol.h"

@interface ZXHttpManager : NSObject

@property (nonatomic, strong)  ZXRequestConfigure *requestConfiguration; // session configure

+ (ZXHttpManager *)sharedInstance;

- (void)addRequest:(id<ZXRequestProtocol>)request;

- (void)cancelRequest:(id<ZXRequestProtocol>)request;

- (NSString *)buildRequestURL:(id<ZXRequestProtocol>)request;

@end
