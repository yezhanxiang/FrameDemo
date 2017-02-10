//
//  ZXTabBar.m
//  FrameDemo
//
//  Created by 展祥叶 on 16/10/31.
//  Copyright © 2016年 ye zhanxiang. All rights reserved.
//

#import "ZXTabBar.h"
#import "UIImage+Color.h"


@interface ZXTabBar ()
@property (nonatomic, weak) UIButton *midBtn;
@end

@implementation ZXTabBar

- (instancetype)init
{
    if (self = [super init]) {
        _numOfTabBarItem = 5;
        _isHasMidBtn = NO;
        [self configureTabBar];
        !_isHasMidBtn?:[self addMidBtn];
    }
    
    return self;
}

- (void)configureTabBar
{
    self.shadowImage = [UIImage new];
    [self setBackgroundImage:[UIImage imageWithColor:RGBA_255(0, 0, 0, 1)]];
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:RGB_255(113, 113, 113)} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:RGB_255(218, 85, 107)} forState:UIControlStateSelected];
    
}

- (void)addMidBtn
{
    UIButton *midBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    midBtn.backgroundColor = [UIColor orangeColor];
    [midBtn setTitle:@"+" forState:UIControlStateNormal];
    [midBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    midBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    [midBtn addTarget:self action:@selector(midBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:midBtn];
    _midBtn = midBtn;
}

#pragma mark - Button Action
- (void)midBtnAction:(UIButton *)btn
{
    if ([self.tabBardelegate respondsToSelector:@selector(midButtonDidClick:)]) {
        [self.tabBardelegate midButtonDidClick:btn];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (_isHasMidBtn) {
        int centerX = self.bounds.size.width/2;
        int centerY = self.bounds.size.height/2;
        _midBtn.frame = CGRectMake(centerX-30, centerY-40, 60, 60);
        _midBtn.layer.cornerRadius = CGRectGetWidth(_midBtn.frame)/2;
        _midBtn.layer.masksToBounds = YES;
        
        Class class = NSClassFromString(@"UITabBarButton");
        int index = 0;
        int tabWidth = self.bounds.size.width/_numOfTabBarItem;
        
        for (UIView *view in self.subviews) {
            //找到UITabBarButton类型子控件
            if ([view isKindOfClass:class]) {
                CGRect rect = view.frame;
                rect.origin.x = index * tabWidth;
                rect.size.width = tabWidth;
                view.frame = rect;
                index++;
                //留出位置放置中间凸出按钮
                if (index == _numOfTabBarItem/2) {
                    index++;
                }
            }
        }
    }
    
}

//重写hitTest方法，目的是为了让凸出的部分点击也有反应
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    if (self.isHidden == NO) {
        CGPoint newPoint = [self convertPoint:point toView:_midBtn];
        if ([_midBtn pointInside:newPoint withEvent:event]) {
            return _midBtn;
        }else {
            return [super hitTest:point withEvent:event];
        }
    }
    
    return [super hitTest:point withEvent:event];
}

- (void)setNumOfTabBarItem:(NSUInteger)numOfTabBarItem
{
    _numOfTabBarItem = numOfTabBarItem;
    [self setNeedsLayout];
}

- (void)setIsHasMidBtn:(BOOL)isHasMidBtn
{
    _isHasMidBtn = isHasMidBtn;
    [self setNeedsLayout];
}

@end
