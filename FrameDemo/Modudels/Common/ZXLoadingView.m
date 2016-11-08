//
//  ZXLoadingView.m
//  FrameDemo
//
//  Created by 展祥叶 on 16/11/8.
//  Copyright © 2016年 ye zhanxiang. All rights reserved.
//

#import "ZXLoadingView.h"
#import "MBProgressHUD.h"

@implementation ZXLoadingView

+ (void)showLodingInView:(UIView *)view
{
    [MBProgressHUD showHUDAddedTo:view animated:YES];
}

+ (void)hideLoadingForView:(UIView *)view
{
    [MBProgressHUD hideHUDForView:view animated:YES];
}

@end
