//
//  PasswordStrengthIndicatorView.m
//  FrameDemo
//
//  Created by 展祥叶 on 16/11/15.
//  Copyright © 2016年 ye zhanxiang. All rights reserved.
//

#import "PasswordStrengthIndicatorView.h"
#import "Masonry.h"
#import <POP/POP.h>

@interface PasswordStrengthIndicatorView ()
@property (nonatomic, strong) UIView *indicatorView;
@end

@implementation PasswordStrengthIndicatorView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.05];
        self.layer.cornerRadius = .2f;
        [self addIndicatorView];
    }
    return self;
}

#pragma mark - Private Instance Methods

- (void)animateIndicatorViewToStatus:(PasswordStrengthIndicatorViewStatus)status
{
    
    WEAK_REF(self)
    [_indicatorView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo([weak_self multiplierForStatus:status] * CGRectGetWidth(weak_self.bounds));
    }];
    
    [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:0.7 options:0 animations:^{
        [self layoutIfNeeded];
        self.indicatorView.backgroundColor = [self colorForStatus:status];
    } completion:NULL];
}

- (void)addIndicatorView
{
    self.indicatorView = [UIView new];
    self.indicatorView.layer.cornerRadius = self.layer.cornerRadius;
    self.indicatorView.layer.masksToBounds = YES;
    [self addSubview:self.indicatorView];
    
    [_indicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.mas_equalTo(0);
        make.width.mas_equalTo(0);
    }];
}

- (CGFloat)multiplierForStatus:(PasswordStrengthIndicatorViewStatus)status
{
    switch (status) {
        case PasswordStrengthIndicatorViewStatusWeak:
            return 0.33f;
        case PasswordStrengthIndicatorViewStatusFair:
            return 0.66f;
        case PasswordStrengthIndicatorViewStatusStrong:
            return 1.f;
        default:
            return 0.f;
    }
}

- (UIColor *)colorForStatus:(PasswordStrengthIndicatorViewStatus)status
{
    switch (status) {
        case PasswordStrengthIndicatorViewStatusWeak:
            return RGBA_255(231, 76, 60, 1);
        case PasswordStrengthIndicatorViewStatusFair:
            return RGBA_255(241, 196, 15, 1);
        case PasswordStrengthIndicatorViewStatusStrong:
            return RGBA_255(46, 204, 113, 1);
        default:
            return [UIColor lightGrayColor];
    }
}

#pragma mark -Property Setters

- (void)setStatus:(PasswordStrengthIndicatorViewStatus)status
{
    if (status == _status) {
        return;
    }
    _status = status;
    [self animateIndicatorViewToStatus:status];
}

@end
