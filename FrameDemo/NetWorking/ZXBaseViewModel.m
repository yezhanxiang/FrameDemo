//
//  BaseViewModel.m
//  FrameDemo
//
//  Created by 展祥叶 on 16/11/8.
//  Copyright © 2016年 ye zhanxiang. All rights reserved.
//

#import "ZXBaseViewModel.h"

@implementation ZXBaseViewModel
@dynamic responseObject;
- (instancetype)init
{
    if (self = [super init]) {
        self.responseParser = [[ZXResponseObject alloc] init];
    }
    
    return self;
}
@end
