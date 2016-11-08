//
//  ZXTopicImageInfo.m
//  FrameDemo
//
//  Created by 展祥叶 on 16/11/1.
//  Copyright © 2016年 ye zhanxiang. All rights reserved.
//

#import "ZXTopicImageInfo.h"
#import "MJExtension.h"

@implementation ZXTopicImageInfo

+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{
                @"address":@"address",
                @"docid":@"docid",
                @"imgUrl":@"imgUrl",
                @"priority":@"priority",
                @"title":@"title"
            };
}

@end
