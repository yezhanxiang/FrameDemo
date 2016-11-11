//
//  CircleView.m
//  FrameDemo
//
//  Created by 展祥叶 on 16/11/10.
//  Copyright © 2016年 ye zhanxiang. All rights reserved.
//

#import "CircleView.h"
#import <POP/POP.h>

@interface CircleView ()
@property (nonatomic, strong) CAShapeLayer *circleLayer;
@end

@implementation CircleView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        NSAssert(frame.size.width == frame.size.height, @"圆的高和宽必须相等.");
        [self addCircleLayer];
        
    }
    return self;
}

#pragma mark - Instance Methods

- (void)setStrokeEnd:(CGFloat)strokeEnd animated:(BOOL)animated
{
    if (animated) {
        [self animateToStrokeEnd:strokeEnd];
        return;
    }
    self.circleLayer.strokeEnd = strokeEnd;
}

#pragma mark - Property Setters

- (void)setStrokeColor:(UIColor *)strokeColor
{
    self.circleLayer.strokeColor = strokeColor.CGColor;
    _strokeColor = strokeColor;
}

#pragma mark - Private Instance methods
- (void)addCircleLayer
{
    
    CGFloat lineW = 1.f;
    CGFloat r = CGRectGetWidth(self.bounds)/2 - lineW;
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    CGRect frame = CGRectMake(lineW/2, lineW/2, r*2, r*2);
    shapeLayer.path = [UIBezierPath bezierPathWithRoundedRect:frame cornerRadius:r].CGPath;
    shapeLayer.strokeColor = [UIColor lightGrayColor].CGColor;
    shapeLayer.fillColor = nil;
    shapeLayer.lineWidth = lineW;
    [self.layer addSublayer:shapeLayer];
    
    CGFloat lineWidth = 4.f;
    CGFloat radius = CGRectGetWidth(self.bounds)/2 - lineWidth/2;
    self.circleLayer = [CAShapeLayer layer];
    //根据矩形画带圆角的曲线
    self.circleLayer.path = [UIBezierPath bezierPathWithRoundedRect:frame cornerRadius:radius].CGPath;
    
    self.circleLayer.strokeColor = self.tintColor.CGColor;
    self.circleLayer.fillColor = nil;
    self.circleLayer.lineWidth = lineWidth;
    self.circleLayer.lineCap = kCALineCapRound;
    self.circleLayer.lineJoin = kCALineCapRound;
    
    [shapeLayer addSublayer:self.circleLayer];
    
}

- (void)animateToStrokeEnd:(CGFloat)strokeEnd
{
    POPSpringAnimation *strokeAnimantion = [POPSpringAnimation animationWithPropertyNamed:kPOPShapeLayerStrokeEnd];
    strokeAnimantion.toValue = @(strokeEnd);
    strokeAnimantion.springBounciness = 12.f;
    strokeAnimantion.removedOnCompletion = NO;
    [self.circleLayer pop_addAnimation:strokeAnimantion forKey:@"layerStrokeAnimation"];
}


@end
