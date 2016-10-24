//
//  ZXLaunchView.m
//  FrameDemo
//
//  Created by 展祥叶 on 16/10/24.
//  Copyright © 2016年 ye zhanxiang. All rights reserved.
//

#import "ZXLaunchView.h"
#import "Masonry.h"

#define kSkipBtnWidth 65
#define kSkipBtnHeight 30
#define kSkipRightEdging 20
#define kSkipTopEdging 40

@implementation ZXLaunchView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.launchImageView];
        [self addSubview:self.adImageView];
        [self addSubview:self.skipBtn];
        
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_launchImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.right.mas_equalTo(0);
    }];
    
    [_adImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.right.mas_equalTo(0);
    }];
    
    [_skipBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-kSkipRightEdging);
        make.top.mas_equalTo(kSkipTopEdging);
        make.height.mas_equalTo(kSkipBtnHeight);
        make.width.mas_equalTo(kSkipBtnWidth);
    }];
    
}

#pragma mark Getting and Setting
- (UIImageView *)launchImageView
{
    if (!_launchImageView) {
        UIImageView *imageView = [UIImageView new];
        _launchImageView = imageView;
    }
    
    return _launchImageView;
}

- (UIImageView *)adImageView
{
    if (!_adImageView) {
    UIImageView *imageView = [UIImageView new];
        _adImageView = imageView;
    }
    
    return _adImageView;
}

- (UIButton *)skipBtn
{
    if (!_skipBtn) {
        UIButton *skipBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        skipBtn.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
        [skipBtn setTitle:@"跳过" forState:UIControlStateNormal];
        skipBtn.titleLabel.textColor = [UIColor whiteColor];
        skipBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        skipBtn.alpha = 0.92;
        skipBtn.layer.cornerRadius = 4.0;
        skipBtn.clipsToBounds = YES;
        _skipBtn = skipBtn;
    }
    
    return _skipBtn;
}

@end
