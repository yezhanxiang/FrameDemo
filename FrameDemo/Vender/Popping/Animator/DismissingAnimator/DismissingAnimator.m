//
//  DismissingAnimator.m
//  FrameDemo
//
//  Created by 展祥叶 on 16/11/11.
//  Copyright © 2016年 ye zhanxiang. All rights reserved.
//

#import "DismissingAnimator.h"
#import <POP/POP.h>

@implementation DismissingAnimator

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.5f;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    //获取要转场的控制器
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    toVC.view.tintAdjustmentMode = UIViewTintAdjustmentModeNormal;
    toVC.view.userInteractionEnabled = YES;
    
    //获取fromViewController
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    //获取dimmingView
    __block UIView *dimmingView;
    [transitionContext.containerView.subviews enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop) {
        if (obj.layer.opacity < 1.f) {
            dimmingView = obj;
            *stop = YES;
        }
    }];
    
    
    //渐变动画
    POPBasicAnimation *opacityAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerOpacity];
    opacityAnimation.toValue = @(0);
    
    //位移动画
    POPBasicAnimation *offscreenAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    offscreenAnimation.toValue = @(-fromVC.view.layer.position.y);
    [offscreenAnimation setCompletionBlock:^(POPAnimation *anim, BOOL finish) {
        [transitionContext completeTransition:YES];
    }];
    [fromVC.view.layer pop_addAnimation:offscreenAnimation forKey:@"offscreenAnimation"];
    [dimmingView.layer pop_addAnimation:opacityAnimation forKey:@"opacityAnimation"];
    
}

@end
