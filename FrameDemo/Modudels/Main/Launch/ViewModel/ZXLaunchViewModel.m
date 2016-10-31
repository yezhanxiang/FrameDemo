//
//  ZXLaunchViewModel.m
//  FrameDemo
//
//  Created by 展祥叶 on 16/10/26.
//  Copyright © 2016年 ye zhanxiang. All rights reserved.
//

#import "ZXLaunchViewModel.h"
#import "ZXLaunchController.h"

@implementation ZXLaunchViewModel
@dynamic responseObject;

- (instancetype)init
{
    if (self = [super init]) {
        self.timeoutInterval = 10.0;
        self.responseParser = [[ZXResponseObject alloc] init];
    }
    
    return self;
}

- (void)loadLaunchImageDate
{
    self.serializerType = ZXRequestSerializerTypeString;
    self.URLString = @"/news/initLogo/ios_iphone6";

    [self load];
    
}

@end
