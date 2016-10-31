//
//  ZXLaunchViewModel.h
//  FrameDemo
//
//  Created by 展祥叶 on 16/10/26.
//  Copyright © 2016年 ye zhanxiang. All rights reserved.
//

#import "ZXHttpRequest.h"
#import "ZXResponseObject.h"

@class ZXLaunchController;
@interface ZXLaunchViewModel : ZXHttpRequest
@property (nonatomic, strong, readonly) ZXResponseObject *responseObject;

- (void)loadLaunchImageDate;
@end
