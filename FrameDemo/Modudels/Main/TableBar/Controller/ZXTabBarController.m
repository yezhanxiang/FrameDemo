//
//  ZXTabBarController.m
//  FrameDemo
//
//  Created by 展祥叶 on 16/10/31.
//  Copyright © 2016年 ye zhanxiang. All rights reserved.
//

#import "ZXTabBarController.h"
#import "ZXTabBar.h"
#import "ZXNavigationController.h"
#import "ZXMainViewController.h"
#import "ZXNewsViewController.h"
#import "ZXRecommendController.h"
#import "ZXMineViewController.h"


@interface ZXTabBarController ()<ZXTabBarDelegate>

@end

@implementation ZXTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    [self configureTabBar];
    
    [self configureChildViewControllers];
    
}

- (void)configureTabBar
{
    ZXTabBar *tabBar = [[ZXTabBar alloc] init];
    tabBar.tabBardelegate = self;
    tabBar.numOfTabBarItem = 5;
    [self setValue:tabBar forKey:@"tabBar"];
}

- (void)configureChildViewControllers
{
    //
    [self addNewsViewController];
    [self addRecommendViewController];
    [self addMineViewController];
    [self addMineViewController];
    [self addMineViewController];
    [self addMineViewController];

}

- (void)addNewsViewController
{
    UIEdgeInsets imageInsets = UIEdgeInsetsZero;
    UIOffset titlePosition = UIOffsetMake(0, -2);
    
    ZXNewsViewController *newsVC = [[ZXNewsViewController alloc] init];
    
    [self addChildViewController:newsVC title:@"新闻" image:@"userIcon" selectedImage:@"selectedUserIcon" imageInsets:imageInsets titlePosition:titlePosition navControllerClass:[ZXNavigationController class]];
}

- (void)addRecommendViewController
{                                                                                                                                                    
    UIEdgeInsets imageInsets = UIEdgeInsetsZero;
    UIOffset titlePosition = UIOffsetMake(0, -2);
    
    ZXRecommendController *recommendVC = [[ZXRecommendController alloc] init];
    [self addChildViewController:recommendVC title:@"精选" image:@"userIcon" selectedImage:@"selectedUserIcon" imageInsets:imageInsets titlePosition:titlePosition navControllerClass:[ZXNavigationController class]];
}

- (void)addMineViewController
{
    UIEdgeInsets imageInsets = UIEdgeInsetsZero;
    UIOffset titlePosition = UIOffsetMake(0, -2);
    
    ZXMineViewController *mineVC = [[ZXMineViewController alloc] init];
    [self addChildViewController:mineVC title:@"个人中心" image:@"userIcon" selectedImage:@"selectedUserIcon" imageInsets:imageInsets titlePosition:titlePosition navControllerClass:[ZXNavigationController class]];
}

- (void)addChildViewController:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage imageInsets:(UIEdgeInsets)imageInsets titlePosition:(UIOffset)titlePosition navControllerClass:(Class)navControllerClass
{
    [self configureChildViewController:childVc title:title image:image selectedImage:selectedImage imageInsets:imageInsets titlePosition:titlePosition];
    
    // 给控制器 包装 一个导航控制器
    id nav = nil;
    if (navControllerClass == nil) {
        nav = [[UINavigationController alloc] initWithRootViewController:childVc];
    }else {
        nav = [[navControllerClass alloc] initWithRootViewController:childVc];
    }
    
    // 添加为子控制器
    [self addChildViewController:nav];
}

- (void)configureChildViewController:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage imageInsets:(UIEdgeInsets)imageInsets titlePosition:(UIOffset)titlePosition
{
    childVc.title = title;
    childVc.tabBarItem.title = title;
    childVc.tabBarItem.image = [UIImage imageNamed:image];
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVc.tabBarItem.imageInsets = imageInsets;
    childVc.tabBarItem.titlePositionAdjustment = titlePosition;
}

#pragma mark - ZXTabBarDelegate
- (void)midButtonDidClick:(UIButton *)btn
{
    NSLog(@"!!!!!!");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
