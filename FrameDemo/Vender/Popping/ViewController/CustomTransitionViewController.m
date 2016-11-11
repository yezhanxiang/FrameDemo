//
//  CustomTransitionViewController.m
//  FrameDemo
//
//  Created by 展祥叶 on 16/11/11.
//  Copyright © 2016年 ye zhanxiang. All rights reserved.
//

#import "CustomTransitionViewController.h"
#import "PresentingAnimator.h"
#import "DismissingAnimator.h"
#import "ModalViewController.h"

@interface CustomTransitionViewController ()<UIViewControllerTransitioningDelegate>

@end

@implementation CustomTransitionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self addPresentButton];
}

#pragma mark - UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return [PresentingAnimator new];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return [DismissingAnimator new];
}

#pragma mark - Private Instance methods

- (void)addPresentButton
{
    UIButton *presentButton = [UIButton buttonWithType:UIButtonTypeSystem];
    presentButton.translatesAutoresizingMaskIntoConstraints = NO;
    [presentButton setTitle:@"Present Modal View Controller" forState:UIControlStateNormal];
    [presentButton addTarget:self action:@selector(present:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:presentButton];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:presentButton
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1.f
                                                           constant:0.f]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:presentButton
                                                          attribute:NSLayoutAttributeCenterY
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterY
                                                         multiplier:1.f
                                                           constant:0.f]];
    
}

- (void)present:(id)sender
{
    ModalViewController *modalVC = [ModalViewController new];
    modalVC.transitioningDelegate = self;
    modalVC.modalPresentationStyle = UIModalPresentationCustom;
    
    [self.navigationController presentViewController:modalVC animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
