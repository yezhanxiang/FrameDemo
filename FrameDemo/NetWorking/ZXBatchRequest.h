//
//  ZXBatchRequest.h
//  FrameDemo
//
//  Created by 展祥叶 on 16/11/2.
//  Copyright © 2016年 ye zhanxiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZXRequestProtocol.h"

@class ZXBatchRequest;
typedef void (^TYBatchRequestSuccessBlock)(ZXBatchRequest *request);
typedef void (^TYBatchRequestFailureBlock)(ZXBatchRequest *request,NSError *error);

@interface ZXBatchRequest : NSObject

@property (nonatomic, strong, readonly) NSArray *batchRequestArray;
@property (nonatomic, assign, readonly) NSInteger requestCompleteCount;

@property (nonatomic, copy, readonly) TYBatchRequestSuccessBlock successBlock; // 请求成功block
@property (nonatomic, copy, readonly) TYBatchRequestFailureBlock failureBlock; // 请求失败block

- (void)addRequest:(id<ZXRequestProtocol>)request;

- (void)addRequestArray:(NSArray *)requestArray;

- (void)cancelRequest:(id<ZXRequestProtocol>)request;

// 设置回调block
- (void)setRequestSuccessBlock:(TYBatchRequestSuccessBlock)successBlock failureBlock:(TYBatchRequestFailureBlock)failureBlock;

- (void)loadWithSuccessBlock:(TYBatchRequestSuccessBlock)successBlock failureBlock:(TYBatchRequestFailureBlock)failureBlock;

- (void)load;

- (void)cancle;

@end
