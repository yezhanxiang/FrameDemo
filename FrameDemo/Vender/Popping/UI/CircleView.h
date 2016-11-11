//
//  CircleView.h
//  FrameDemo
//
//  Created by 展祥叶 on 16/11/10.
//  Copyright © 2016年 ye zhanxiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CircleView : UIView
@property(nonatomic) UIColor *strokeColor;

- (void)setStrokeEnd:(CGFloat)strokeEnd animated:(BOOL)animated;

@end
