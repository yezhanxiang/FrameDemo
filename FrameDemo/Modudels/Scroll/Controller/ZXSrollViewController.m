//
//  ZXSrollViewController.m
//  FrameDemo
//
//  Created by 展祥叶 on 16/11/21.
//  Copyright © 2016年 ye zhanxiang. All rights reserved.
//

#import "ZXSrollViewController.h"

@interface ZXSrollViewController ()<UIScrollViewDelegate>
@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, weak) UIImageView *redView;
@property (nonatomic, weak) UIImageView *greenView;
@property (nonatomic, weak) UIImageView *blueView;
@end

@implementation ZXSrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self addScrollView];
    [self configScrollView];
}

#pragma mark - Private Instance Methods
- (void)addScrollView
{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.contentSize = CGSizeMake(3*kScreenWidth, self.view.bounds.size.height);
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    _scrollView = scrollView;
    
}

- (void)configScrollView
{
    CGFloat height = self.view.bounds.size.height;
    UIImageView *redView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, height)];
    redView.backgroundColor = [UIColor clearColor];
    redView.contentMode = UIViewContentModeScaleAspectFit;
    redView.image = [UIImage imageNamed:@"img1.jpg"];
    [_scrollView addSubview:redView];
    _redView = redView;
    
    UIImageView *greenView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth, 0, kScreenWidth, height)];
    greenView.backgroundColor = [UIColor clearColor];
    greenView.contentMode = UIViewContentModeScaleAspectFit;
    greenView.image = [UIImage imageNamed:@"img2.jpg"];
    [_scrollView addSubview:greenView];
    _greenView = greenView;
    
    UIImageView *blueView = [[UIImageView alloc] initWithFrame:CGRectMake(2*kScreenWidth, 0, kScreenWidth, height)];
    blueView.backgroundColor = [UIColor clearColor];
    blueView.contentMode = UIViewContentModeScaleAspectFit;
    blueView.image = [UIImage imageNamed:@"img3.jpg"];
    [_scrollView addSubview:blueView];
    _blueView = blueView;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat x = scrollView.contentOffset.x;
    NSInteger pageIndex = x/kScreenWidth;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
