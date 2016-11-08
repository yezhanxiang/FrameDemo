//
//  zxRecommendViewModel.h
//  FrameDemo
//
//  Created by 展祥叶 on 16/11/2.
//  Copyright © 2016年 ye zhanxiang. All rights reserved.
//

#import "ZXBaseViewModel.h"

typedef void (^CompleteHandler)(id data, NSError *error);

@interface ZXRecommendViewModel : ZXBaseViewModel

// Data
@property (nonatomic, strong) NSArray *topicDatas;
@property (nonatomic, strong) NSArray *imageInfoDatas;

- (void)fetchTopicDataWithBlock:(CompleteHandler)completeHandler;  //获取头部推荐数据
- (void)fetchRecommendDataWithBlock:(CompleteHandler)completeHandler; //获取推荐数据
- (void)fetchAllDataWithBlock:(void (^)(NSError *error))completeHandler;

@end
