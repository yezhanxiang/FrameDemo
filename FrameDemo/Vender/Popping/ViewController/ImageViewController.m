//
//  ImageViewController.m
//  FrameDemo
//
//  Created by 展祥叶 on 16/11/11.
//  Copyright © 2016年 ye zhanxiang. All rights reserved.
//

#import "ImageViewController.h"
#import <POP/POP.h>
#import "ZXImageView.h"

typedef struct {
    CGFloat progress;
    CGFloat toValue;
    CGFloat currentValue;
} AnimationInfo;

@interface ImageViewController ()

@end

@implementation ImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self addImageView];
}

- (void)addImageView
{
    UIPanGestureRecognizer *recognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    
    CGFloat width = CGRectGetWidth(self.view.bounds) - 20;
    CGFloat height = roundf(width*0.75f);//四舍五入
    ZXImageView *imageView = [[ZXImageView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    imageView.center = self.view.center;
    [imageView setImage:[UIImage imageNamed:@"boat.jpg"]];
    [imageView addTarget:self action:@selector(touchDown:) forControlEvents:UIControlEventTouchDown];
    [imageView addTarget:self action:@selector(touchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    [imageView addGestureRecognizer:recognizer];
    
    [self.view addSubview:imageView];
    [self scaleDownView:imageView];
}

- (void)touchDown:(UIControl *)sender
{
    [self pauseAllAnimations:YES forLayer:sender.layer];
}

- (void)touchUpInside:(UIControl *)sender
{
    AnimationInfo animationInfo = [self animationInfoForLayer:sender.layer];
    BOOL hasAnimations = sender.layer.pop_animationKeys.count;
    
    if (hasAnimations && animationInfo.progress < 0.98) {
        [self pauseAllAnimations:YES forLayer:sender.layer];
        return;
    }
    
    [sender.layer pop_removeAllAnimations];
    if (animationInfo.toValue == 1 || sender.layer.affineTransform.a == 1) {
        [self scaleDownView:sender];
        return;
    }
    
    [self scaleUpView:sender];
    
}

- (void)handlePan:(UIPanGestureRecognizer *)recognizer
{
    [self scaleDownView:recognizer.view];
    CGPoint translation = [recognizer translationInView:self.view];
    recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x, recognizer.view.center.y + translation.y);
    [recognizer setTranslation:CGPointZero inView:self.view];
    
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        CGPoint velctity = [recognizer velocityInView:self.view];
        
        POPSpringAnimation *positionAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPosition];
        positionAnimation.velocity = [NSValue valueWithCGPoint:velctity];
        positionAnimation.dynamicsTension = 10.f; //拉力
        positionAnimation.dynamicsFriction = 1.f; //摩擦
        positionAnimation.springBounciness = 12.f; //弹力 [1-20]之间，越大弹力幅度越大
        [recognizer.view.layer pop_addAnimation:positionAnimation forKey:@"layerPositionAnimation"];
    }
}

-(void)scaleUpView:(UIView *)view
{
    POPSpringAnimation *positionAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPosition];
    positionAnimation.toValue = [NSValue valueWithCGPoint:self.view.center];
    [view.layer pop_addAnimation:positionAnimation forKey:@"layerPositionAnimation"];
    
    POPSpringAnimation *scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scaleAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(1.f, 1.f)];
    scaleAnimation.springBounciness = 10.f;
    [view.layer pop_addAnimation:scaleAnimation forKey:@"scaleAnimation"];
}

- (void)scaleDownView:(UIView *)view
{
    POPSpringAnimation *scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scaleAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(0.5, 0.5)];
    scaleAnimation.springBounciness = 10.f;
    [view.layer pop_addAnimation:scaleAnimation forKey:@"scaleAnimation"];
}

- (void)pauseAllAnimations:(BOOL)pause forLayer:(CALayer *)layer
{
    for (NSString *key in layer.pop_animationKeys) {
        POPAnimation *animation = [layer pop_animationForKey:key];
        [animation setPaused:pause];
    }
}

- (AnimationInfo)animationInfoForLayer:(CALayer *)layer
{
    POPSpringAnimation *animation = [layer pop_animationForKey:@"scaleAnimation"];
    CGPoint toValue = [animation.toValue CGPointValue];
    CGPoint currentValue = [[animation valueForKey:@"currentValue"] CGPointValue];
    
    CGFloat min = MIN(toValue.x, currentValue.x);
    CGFloat max = MAX(toValue.x, currentValue.x);
    
    AnimationInfo info;
    info.toValue = toValue.x;
    info.currentValue = currentValue.x;
    info.progress = min /max;
    return info;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
