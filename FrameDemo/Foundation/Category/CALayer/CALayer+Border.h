//
//  CALayer+Border.h
//  FrameDemo
//
//  Created by 展祥叶 on 16/11/23.
//  Copyright © 2016年 ye zhanxiang. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface CALayer (Border)
- (void)addBorder:(UIRectEdge )edge color:(UIColor *)color borderWidth:(CGFloat)borderWidth;
@end
