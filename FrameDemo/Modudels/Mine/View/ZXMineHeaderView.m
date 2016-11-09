//
//  ZXMineHeaderView.m
//  FrameDemo
//
//  Created by 展祥叶 on 16/11/9.
//  Copyright © 2016年 ye zhanxiang. All rights reserved.
//

#import "ZXMineHeaderView.h"

@interface ZXMineHeaderView ()
@property (nonatomic, strong) UIImageView *headerIcon;
@property (nonatomic, strong) UILabel *tipLable;
@end

@implementation ZXMineHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self layoutUI];
        [self configConstraint];
    }
    
    return self;
}

- (void)layoutUI
{
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.headerIcon];
    [self.bgView addSubview:self.tipLable];
}

- (void)configConstraint
{
    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(0);
    }];
    
    [_headerIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.mas_equalTo(50);
        make.centerX.mas_equalTo(_bgView);
//        make.centerY.mas_equalTo(_bgView).mas_equalTo(-10);
        make.bottom.mas_equalTo(-50);
    }];
    
    [_tipLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_headerIcon.mas_bottom).mas_equalTo(10);
        make.centerX.mas_equalTo(_bgView);
        make.height.mas_equalTo(21);
    }];
}

#pragma mark - 懒加载
- (UIImageView *)bgView
{
    if (!_bgView) {
        _bgView = [[UIImageView alloc] init];
        _bgView.image = [UIImage imageNamed:@"bg_pgmy"];
        _bgView.contentMode = UIViewContentModeScaleAspectFill;
        _bgView.clipsToBounds = YES;
    }
    
    return _bgView;
}

- (UIImageView *)headerIcon
{
    if (!_headerIcon) {
        _headerIcon = [[UIImageView alloc] init];
        _headerIcon.image = [UIImage imageNamed:@""];
        _headerIcon.backgroundColor = UIColorFromRGBA(0xe7e7e7, 1);
        _headerIcon.layer.cornerRadius = 4;
        _headerIcon.layer.masksToBounds = YES;
    }
    
    return _headerIcon;
}

- (UILabel *)tipLable
{
    if (!_tipLable) {
        _tipLable = [UILabel new];
        _tipLable.textColor = [UIColor whiteColor];
        _tipLable.textAlignment = NSTextAlignmentCenter;
        _tipLable.font = [UIFont systemFontOfSize:12];
        _tipLable.text = @"请登陆";
    }
    
    return _tipLable;
}

@end
