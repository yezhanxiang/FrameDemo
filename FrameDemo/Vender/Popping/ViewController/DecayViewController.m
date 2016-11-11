//
//  DecayViewController.m
//  FrameDemo
//
//  Created by 展祥叶 on 16/11/10.
//  Copyright © 2016年 ye zhanxiang. All rights reserved.
//

#import "DecayViewController.h"
#import <POP/POP.h>

@interface DecayViewController ()<POPAnimationDelegate>
@property (nonatomic, strong) UIControl *dragView;
@end

@implementation DecayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self addDragView];

}

- (void)addDragView
{
    UIPanGestureRecognizer *recognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                                 action:@selector(handlePan:)];
    
    _dragView = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    _dragView.center = self.view.center;
    _dragView.layer.cornerRadius = CGRectGetWidth(_dragView.frame)/2;
    _dragView.layer.masksToBounds = YES;
    _dragView.backgroundColor = [UIColor greenColor];
    [_dragView addTarget:self action:@selector(touchDown:) forControlEvents:UIControlEventTouchDown];
    [_dragView addGestureRecognizer:recognizer];
    
    [self.view addSubview:_dragView];
    
}

- (void)touchDown:(UIControl *)sender
{
    [sender.layer pop_removeAllAnimations];
}

- (void)handlePan:(UIPanGestureRecognizer *)recognizer
{
    CGPoint translation = [recognizer translationInView:self.view];
    recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x,
                                         recognizer.view.center.y + translation.y);
    
    [recognizer setTranslation:CGPointZero inView:self.view];
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        CGPoint velocity = [recognizer velocityInView:self.view];
        POPDecayAnimation *positionAnimation = [POPDecayAnimation animationWithPropertyNamed:kPOPLayerPosition];
        positionAnimation.delegate = self;
        positionAnimation.velocity = [NSValue valueWithCGPoint:velocity];
        [recognizer.view.layer pop_addAnimation:positionAnimation forKey:@"layerPositionAnimation"];
    }
    
}

#pragma mark - POPAnimationDelegate
- (void)pop_animationDidApply:(POPDecayAnimation *)anim
{
     BOOL isDragViewOutsideOfSuperView = !CGRectContainsRect(self.view.frame, self.dragView.frame);
    if (isDragViewOutsideOfSuperView) {
        CGPoint currentVelocity = [anim.velocity CGPointValue];
        CGPoint velocity = CGPointMake(currentVelocity.x, -currentVelocity.y);
        POPSpringAnimation *positionAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPosition];
        positionAnimation.velocity = [NSValue valueWithCGPoint:velocity];
        positionAnimation.toValue = [NSValue valueWithCGPoint:self.view.center];
        [self.dragView.layer pop_addAnimation:positionAnimation forKey:@"layerPositionAnimation"];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
