//
//  ZXBatchRequest.m
//  FrameDemo
//
//  Created by 展祥叶 on 16/11/2.
//  Copyright © 2016年 ye zhanxiang. All rights reserved.
//

#import "ZXBatchRequest.h"

@interface ZXBatchRequest ()<ZXRequestDelegate>
@property (nonatomic, strong) NSMutableArray *batchRequestArray;
@property (nonatomic, assign) NSInteger requestCompleteCount;
@property (nonatomic, assign) BOOL isLoading;
@end

@implementation ZXBatchRequest

- (instancetype)init
{
    if (self = [super init]) {
        _batchRequestArray = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (void)addRequest:(id<ZXRequestProtocol>)request
{
    if (_isLoading) {
        NSLog(@"ZXBatchRequest is Running,can't add request");
        return;
    }
    request.embedAccesory = self;
    [_batchRequestArray addObject:request];
}

- (void)addRequestArray:(NSArray *)requestArray
{
    for (id<ZXRequestProtocol> request in requestArray) {
        if ([request conformsToProtocol:@protocol(ZXRequestProtocol)]) {
            [self addRequest:request];
        }
    }
}

- (void)cancelRequest:(id<ZXRequestProtocol>)request
{
    request.embedAccesory = nil;
    [request cancel];
    [_batchRequestArray removeObject:request];
}

- (void)setRequestSuccessBlock:(TYBatchRequestSuccessBlock)successBlock failureBlock:(TYBatchRequestFailureBlock)failureBlock
{
    _successBlock = successBlock;
    _failureBlock = failureBlock;
    
}

- (void)loadWithSuccessBlock:(TYBatchRequestSuccessBlock)successBlock failureBlock:(TYBatchRequestFailureBlock)failureBlock
{
    [self setRequestSuccessBlock:successBlock failureBlock:failureBlock];
    
    [self load];
}

- (void)load
{
    if (_isLoading || _batchRequestArray.count == 0) {
        return;
    }
    _isLoading = YES;
    _requestCompleteCount = 0;
    for (id<ZXRequestProtocol> request in _batchRequestArray) {
        [request load];
    }
}

- (void)cancle
{
    for (id<ZXRequestProtocol> request in _batchRequestArray) {
        request.embedAccesory = nil;
        [request cancel];
    }
    [_batchRequestArray removeAllObjects];
    _requestCompleteCount = 0;
    _isLoading = NO;
}

#pragma mark - delegate
- (void)requestDidFinish:(id<ZXRequestProtocol>)request
{
    NSInteger index = [_batchRequestArray indexOfObject:request];
    if (index != NSNotFound) {
        ++_requestCompleteCount;
    }
    
    if (_requestCompleteCount == _batchRequestArray.count) {
        if (_successBlock) {
            _successBlock(self);
        }
        [_batchRequestArray removeAllObjects];
        _isLoading = NO;
    }
    
}

- (void)requestDidFail:(id<ZXRequestProtocol>)request error:(NSError *)error
{
    if (_failureBlock) {
        _failureBlock(self,error);
    }
    [_batchRequestArray removeAllObjects];
    _isLoading = NO;
}

- (void)clearBlocks
{
    _successBlock = nil;
    _failureBlock = nil;
}

- (void)dealloc
{
    [self clearBlocks];
}


@end
