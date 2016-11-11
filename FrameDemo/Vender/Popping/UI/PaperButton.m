//
//  PaperButton.m
//  FrameDemo
//
//  Created by 展祥叶 on 16/11/11.
//  Copyright © 2016年 ye zhanxiang. All rights reserved.
//

#import "PaperButton.h"
#import <POP/POP.h>

@interface PaperButton ()
@property (nonatomic, strong) CALayer *topLayer;
@property (nonatomic, strong) CALayer *middleLayer;
@property (nonatomic, strong) CALayer *bottomLayer;
@property (nonatomic, assign) BOOL showMenu;
@end

@implementation PaperButton

+ (instancetype)button
{
    return [self buttonWithOrigin:CGPointZero];
}

+ (instancetype)buttonWithOrigin:(CGPoint)origin
{
    return [[self alloc] initWithFrame:CGRectMake(origin.x,
                                                  origin.y,
                                                  24,
                                                  17)];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

@end
