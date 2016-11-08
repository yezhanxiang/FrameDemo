//
//  ZXRecommendItem.h
//  FrameDemo
//
//  Created by 展祥叶 on 16/11/2.
//  Copyright © 2016年 ye zhanxiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZXRecommendItem : NSObject

@property (nonatomic, strong) NSString *bannerUrl;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSString *iconUrl;
@property (nonatomic, strong) NSString *topicIconName;
@property (nonatomic, strong) NSString *topicId;
@property (nonatomic, strong) NSString *topicName;
@property (nonatomic, assign) NSInteger followUserCount;
@property (nonatomic, assign) NSInteger platform;
@property (nonatomic, assign) NSInteger sourceType;


@end
