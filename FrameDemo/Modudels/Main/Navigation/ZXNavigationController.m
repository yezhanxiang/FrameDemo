//
//  ZXNavigationController.m
//  FrameDemo
//
//  Created by 展祥叶 on 16/10/31.
//  Copyright © 2016年 ye zhanxiang. All rights reserved.
//

#import "ZXNavigationController.h"
#import "UIImage+Color.h"

@interface ZXNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation ZXNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.interactivePopGestureRecognizer.delegate = self;
    
    [self configureNavBarTheme];
}

- (void)configureNavBarTheme
{
    NSDictionary *titleAttrs = @{
                                 NSForegroundColorAttributeName:[UIColor whiteColor],
                                 NSFontAttributeName:[UIFont systemFontOfSize:16]
                                 };
    [self.navigationBar setTitleTextAttributes:titleAttrs];
    
    //设置导航的背景图片
    [self.navigationBar setBackgroundImage:[UIImage imageWithColor:RGB_255(0, 0, 0)] forBarMetrics:UIBarMetricsDefault];
    
    //去掉导航栏底部阴影
    [self.navigationBar setShadowImage:[UIImage new]];
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if (self.viewControllers.count <= 1) {
        return NO;
    }
    
    return YES;
}

#pragma mark - override
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count >=1) {
        viewController.hidesBottomBarWhenPushed = YES;
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back2_pgnews"] style:UIBarButtonItemStylePlain target:self action:@selector(navGoBack)];
    }
    
    [super pushViewController:viewController animated:animated];
}

#pragma mark - action

- (void)navGoBack
{
    [self popViewControllerAnimated:YES];
}

- (BOOL)prefersStatusBarHidden
{
    return NO;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
