//
//  BaseViewModel.h
//  FrameDemo
//
//  Created by 展祥叶 on 16/11/8.
//  Copyright © 2016年 ye zhanxiang. All rights reserved.
//

#import "ZXHttpRequest.h"
#import "ZXResponseObject.h"

@interface ZXBaseViewModel : ZXHttpRequest
@property (nonatomic, strong, readonly) ZXResponseObject *responseObject;
@end
