//
//  CALayer+Border.m
//  FrameDemo
//
//  Created by 展祥叶 on 16/11/23.
//  Copyright © 2016年 ye zhanxiang. All rights reserved.
//

#import "CALayer+Border.h"

@implementation CALayer (Border)

- (void)addBorder:(UIRectEdge)edge color:(UIColor *)color borderWidth:(CGFloat)borderWidth
{
    CALayer *border = [CALayer layer];

    switch (edge) {
        case UIRectEdgeTop:
            border.frame = CGRectMake(0, 0, CGRectGetHeight(self.frame), borderWidth);
            break;
        case UIRectEdgeBottom:
            border.frame = CGRectMake(0, CGRectGetHeight(self.frame) - borderWidth, CGRectGetWidth(self.frame), borderWidth);
            break;
        case UIRectEdgeLeft:
            border.frame = CGRectMake(0, 0, borderWidth, CGRectGetHeight(self.frame));
            break;
        case UIRectEdgeRight:
            border.frame = CGRectMake(CGRectGetWidth(self.frame) - borderWidth, 0, borderWidth, CGRectGetHeight(self.frame));
            break;
        default:
            break;
    }
    border.backgroundColor = color.CGColor;
    
    [self addSublayer:border];
}

@end
