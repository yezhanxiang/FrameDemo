//
//  ZXBaseRequest.m
//  FrameDemo
//
//  Created by 展祥叶 on 16/10/25.
//  Copyright © 2016年 ye zhanxiang. All rights reserved.
//

#import "ZXBaseRequest.h"
#import "ZXHttpManager.h"

@interface ZXBaseRequest ()
@property (nonatomic, copy) ZXRequestSuccessBlock successBlock;
@property (nonatomic, copy) ZXRequestFailureBlock failureBlock;

@property (nonatomic, assign) ZXRequestState state;
@property (nonatomic, strong) id responseObject;
@end

@implementation ZXBaseRequest

- (instancetype)init
{
    if (self = [super init]) {
        _method = ZXRequestMethodGet;
        _serializerType = ZXRequestSerializerTypeJSON;
        _timeoutInterval = 60;
        _baseURL= BaseURL;
    }
    
    return self;
}

#pragma mark - load request

//请求
- (void)load
{
    [[ZXHttpManager sharedInstance] addRequest:self];
    _state = ZXRequestStateLoading;
}

//取消
- (void)cancel
{
    [_dataTask cancel];
    [self clearRequestBlock];
    _delegate = nil;
    _state = ZXRequestStateCancle;
}

- (void)setRequestSuccessBlock:(ZXRequestSuccessBlock)successBlock failureBlock:(ZXRequestFailureBlock)failureBlock
{
    _successBlock = successBlock;
    _failureBlock = failureBlock;
}

- (void)loadWithSuccessBlock:(ZXRequestSuccessBlock)successBlock failureBlock:(ZXRequestFailureBlock)failureBlock
{
    [self setRequestSuccessBlock:successBlock failureBlock:failureBlock];
    
    [self load];
}

#pragma mark - ZXRequestOverride

//收到数据
- (void)requestDidResponse:(id)responseObject error:(NSError *)error
{
    if (error) {
        [self requestDidFailWithError:error];
    }else {
        if ([self validResponseObject:responseObject error:&error]) {
            [self requestDidFinish];
        }else {
            [self requestDidFailWithError:error];
        }
    }
}

//验证数据
- (BOOL)validResponseObject:(id)responseObject error:(NSError *__autoreleasing *)error
{
    _responseObject = responseObject;
    return _responseObject ? YES : NO;
}


//请求成功
- (void)requestDidFinish
{
    _state = ZXRequestStateFinish;
    
    void (^finishBlock)() = ^{
        if ([_delegate respondsToSelector:@selector(requestDidFinish:)]) {
            [_delegate requestDidFinish:self];
        }
        
        if (_successBlock) {
            _successBlock(self);
        }
        
        if (_embedAccesory && [_embedAccesory respondsToSelector:@selector(requestDidFinish:)]) {
            [_embedAccesory requestDidFinish:self];
        }
    };
    
    if (_asynCompleteQueue) {
        finishBlock();
    }else {
        dispatch_async(dispatch_get_main_queue(), finishBlock);
    }
}

// 请求失败
- (void)requestDidFailWithError:(NSError *)error
{
    _state = ZXRequestStateError;
    
    void (^failBlock)() = ^{
        if ([_delegate respondsToSelector:@selector(requestDidFail:error:)]) {
            [_delegate requestDidFail:self error:error];
        }
        
        if (_failureBlock) {
            _failureBlock(self, error);
        }
        
        if (_embedAccesory && [_embedAccesory respondsToSelector:@selector(requestDidFail:error:)]) {
            [_embedAccesory requestDidFail:self error:error];
        }
    };
    
    if (_asynCompleteQueue) {
        failBlock();
    }else {
        dispatch_async(dispatch_get_main_queue(), failBlock);
    }
}

//清除Block引用
- (void)clearRequestBlock
{
    _successBlock = nil;
    _failureBlock = nil;
    _progressBlock = nil;
    _constructingBodyBlock = nil;
}

- (void)dealloc
{
    [self clearRequestBlock];
    [_dataTask cancel];
    _delegate = nil;
}

@end
