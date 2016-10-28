//
//  ZXRequestConfigure.h
//  FrameDemo
//
//  Created by 展祥叶 on 16/10/26.
//  Copyright © 2016年 ye zhanxiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZXRequestConfigure : NSObject

@property (nonatomic, strong) NSString *baseURL;

// seesion configure
@property (nonatomic, strong) NSURLSessionConfiguration *sessionConfiguration;

+ (ZXRequestConfigure *)sharedInstance;

@end
