//
//  zxRecommendViewModel.m
//  FrameDemo
//
//  Created by 展祥叶 on 16/11/2.
//  Copyright © 2016年 ye zhanxiang. All rights reserved.
//

#import "ZXRecommendViewModel.h"
#import "Define_Basic.h"
#import "ZXTopicImageInfo.h"
#import "ZXRecommendItem.h"
#import "MJExtension.h"
#import "ZXBatchRequest.h"

@implementation ZXRecommendViewModel

- (void)fetchTopicDataWithBlock:(CompleteHandler)completeHandler
{
    self.URLString = [NSString stringWithFormat:@"%@",NewsRecommendImageInfosURL];
    
    WEAK_REF(self);
    [self loadWithSuccessBlock:^(ZXRecommendViewModel<ZXRequestProtocol> *request) {
        NSDictionary *data = request.responseObject.data;
        NSError *error = nil;
        if ([data[@"code"] integerValue] == 0) {
            weak_self.topicDatas = [ZXTopicImageInfo objectArrayWithKeyValuesArray:data[@"info"]];
        }else {
            error = [NSError errorWithDomain:@"获取头部图片失败" code:-1 userInfo:nil];
        }
        completeHandler(weak_self.topicDatas, error);
        
    } failureBlock:^(id<ZXRequestProtocol> request, NSError *error) {
        NSLog(@"%@", [error localizedDescription]);
        completeHandler(nil, error);
    }];
}

- (void)fetchRecommendDataWithBlock:(CompleteHandler)completeHandler
{
    self.URLString = [NSString stringWithFormat:@"%@", NewsRecommendTopicURL];
    
    WEAK_REF(self);
    [self loadWithSuccessBlock:^(ZXRecommendViewModel<ZXRequestProtocol> *request) {
        
        NSDictionary *data = request.responseObject.data;
        NSError *error = nil;
        if ([data[@"code"] integerValue] == 0) {
            weak_self.imageInfoDatas = [ZXRecommendItem objectArrayWithKeyValuesArray:data[@"info"]];
        }else {
            error = [NSError errorWithDomain:@"获取推荐数据失败" code:-1 userInfo:nil];
        }
        completeHandler(weak_self.imageInfoDatas, error);
        
    } failureBlock:^(id<ZXRequestProtocol> request, NSError *error) {
        NSLog(@"%@", [error localizedDescription]);
        completeHandler(nil, error);
    }];
}

- (void)fetchAllDataWithBlock:(void (^)(NSError *))completeHandler
{
    ZXRecommendViewModel *topicRequest = [[ZXRecommendViewModel alloc] init];
    topicRequest.URLString = NewsRecommendImageInfosURL;
    ZXRecommendViewModel *recommendRequest = [[ZXRecommendViewModel alloc] init];
    recommendRequest.URLString = NewsRecommendTopicURL;
    
    NSArray *requestArray = @[topicRequest, recommendRequest];
    ZXBatchRequest *batchRequest  = [[ZXBatchRequest alloc] init];
    [batchRequest addRequestArray:requestArray];
    
    WEAK_REF(self)
    [batchRequest loadWithSuccessBlock:^(ZXBatchRequest *request) {
        NSError *error = nil;
        if (request.requestCompleteCount >= requestArray.count) {
            ZXRecommendViewModel *topicReq = request.batchRequestArray[0];
            ZXRecommendViewModel *recommendReq = request.batchRequestArray[1];
            NSDictionary *topocData = topicReq.responseObject.data;
            NSDictionary *imageinfoData = recommendReq.responseObject.data;
            if ([topocData[@"code"] integerValue] == 0) {
                 weak_self.topicDatas = [ZXTopicImageInfo objectArrayWithKeyValuesArray:topocData[@"info"]];
            }
            
            if ([imageinfoData[@"code"] integerValue] == 0) {
                weak_self.imageInfoDatas = [ZXRecommendItem objectArrayWithKeyValuesArray:imageinfoData[@"info"]];
            }
        }else {
            error = [NSError errorWithDomain:@"获取推荐数据失败" code:-1 userInfo:nil];
        }
        
        completeHandler(error);
        
    } failureBlock:^(ZXBatchRequest *request, NSError *error) {
        NSLog(@"%@", [error localizedDescription]);
        completeHandler(error);
    }];
}

-(NSArray *)topicDatas
{
    if (!_topicDatas) {
        _topicDatas = [NSArray array];
    }
    
    return _topicDatas;
}

-(NSArray *)imageInfoDatas
{
    if (!_imageInfoDatas) {
        _imageInfoDatas = [NSArray array];
    }
    
    return _imageInfoDatas;
}

@end
