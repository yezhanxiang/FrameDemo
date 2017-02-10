//
//  FoldingView.m
//  FrameDemo
//
//  Created by 展祥叶 on 16/11/15.
//  Copyright © 2016年 ye zhanxiang. All rights reserved.
//

#import "FoldingView.h"
#import <POP/POP.h>
#import "UIImage+Blur.h"

typedef NS_ENUM(NSInteger, LayerSection)
{
    LayerSectionTop,
    LayerSectionBottom
};

@interface FoldingView()<POPAnimationDelegate>
@property (nonatomic, strong) UIImage *image;
@property(nonatomic) UIImageView *topView;
@property(nonatomic) UIImageView *backView;
@property(nonatomic) CAGradientLayer *bottomShadowLayer;
@property(nonatomic) CAGradientLayer *topShadowLayer;
@property(nonatomic) NSUInteger initialLocation;
@end

@implementation FoldingView

- (instancetype)initWithFrame:(CGRect)frame image:(UIImage *)image
{
    self = [super initWithFrame:frame];
    if (self) {
        _image = image;
        
        [self addBottomView];
        [self addTopView];
        
        [self addGestureRecognizers];
    }
    return self;
}

#pragma mark - Private Instance methods

- (void)addTopView
{
    UIImage *image = [self imageForSection:LayerSectionTop withImage:self.image];
    
    self.topView = [[UIImageView alloc] initWithFrame:CGRectMake(0.f, 0.f,
                                                                CGRectGetWidth(self.bounds),
                                                                CGRectGetMidY(self.bounds))];
    self.topView.image = image;
    self.topView.layer.anchorPoint = CGPointMake(0.5f, 1.0);
    self.topView.layer.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    self.topView.layer.transform = [self transform3D];
    self.topView.layer.mask = [self maskForSection:LayerSectionTop withRect:self.topView.bounds];
    self.topView.userInteractionEnabled = YES;
    self.topView.contentMode = UIViewContentModeScaleAspectFill;
    
    self.backView = [[UIImageView alloc] initWithFrame:self.topView.bounds];
    self.backView.image = [image blurredImage];
    self.backView.alpha = 0.0f;
    
    self.topShadowLayer = [CAGradientLayer layer];
    self.topShadowLayer.frame = self.topView.bounds;
    self.topShadowLayer.colors = @[(id)[UIColor clearColor].CGColor, (id)[UIColor blackColor].CGColor];
    self.topShadowLayer.opacity = 0;
    
    [self.topView addSubview:self.backView];
    [self.topView.layer addSublayer:self.topShadowLayer];
    [self addSubview:self.topView];
}

- (void)addBottomView
{
    UIImage *image = [self imageForSection:LayerSectionBottom withImage:self.image];
    
    UIImageView *bottomView = [[UIImageView alloc] initWithFrame:CGRectMake(0.f,
                                                                           CGRectGetMidY(self.bounds),
                                                                           CGRectGetWidth(self.bounds),
                                                                            CGRectGetMidY(self.bounds))];
    
    bottomView.image = image;
    bottomView.contentMode = UIViewContentModeScaleAspectFill;
    bottomView.layer.mask = [self maskForSection:LayerSectionBottom withRect:bottomView.bounds];;
    
    self.bottomShadowLayer = [CAGradientLayer layer];
    self.bottomShadowLayer.frame = bottomView.bounds;
    //渐变的颜色
    self.bottomShadowLayer.colors = @[(id)[UIColor blackColor].CGColor, (id)[UIColor clearColor].CGColor];
    self.bottomShadowLayer.opacity = 0;
    
    [bottomView.layer addSublayer:self.bottomShadowLayer];
    [self addSubview:bottomView];
    
}

- (void)addGestureRecognizers
{
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(poke)];
    
    [self.topView addGestureRecognizer:pan];
    [self.topView addGestureRecognizer:tap];
}

- (void)poke
{
    [self rotateToOriginWithVelocity:5];
}

- (void)handlePan:(UIPanGestureRecognizer *)recognizer
{
    CGPoint location = [recognizer locationInView:self];
    
    if (recognizer.state ==UIGestureRecognizerStateBegan) {
        self.initialLocation = location.y;
    }
    
    if ([[self.topView.layer valueForKey:@"transform.rotation.x"] floatValue] == -M_PI_2) {
        self.backView.alpha = 1.0;
        [CATransaction begin];
        [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
        self.topShadowLayer.opacity = 0.0;
        self.bottomShadowLayer.opacity = (location.y-self.initialLocation)/(CGRectGetHeight(self.bounds)-self.initialLocation);
        [CATransaction commit];
    }else {
        self.backView.alpha = 0.0;
        [CATransaction begin];
        [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
        CGFloat opacity = (location.y-self.initialLocation)/(CGRectGetHeight(self.bounds)-self.initialLocation);
        self.bottomShadowLayer.opacity = opacity;
        self.topShadowLayer.opacity = opacity;
        [CATransaction commit];
    }
    
    if ([self isLocation:location inView:self]) {
        CGFloat conversionFactor = -M_PI / (CGRectGetHeight(self.bounds) - self.initialLocation);
        POPBasicAnimation *rotationAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerRotationX];
        
        rotationAnimation.duration = 0.01;
        rotationAnimation.toValue = @((location.y-self.initialLocation)*conversionFactor);
        [self.topView.layer pop_addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    } else {
        recognizer.enabled = NO;
        recognizer.enabled = YES;
    }
    
    if (recognizer.state == UIGestureRecognizerStateEnded ||
        recognizer.state == UIGestureRecognizerStateCancelled) {
        [self rotateToOriginWithVelocity:0];
    }
    
}

- (void)rotateToOriginWithVelocity:(CGFloat)velocity
{
    POPSpringAnimation *rotationAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerRotationX];
    if (velocity > 0) {
        rotationAnimation.velocity = @(velocity);
    }
    rotationAnimation.springBounciness = 18.0f;
    rotationAnimation.dynamicsMass = 2.0f;
    rotationAnimation.dynamicsTension = 200;
    rotationAnimation.toValue = @(0);
    rotationAnimation.delegate = self;
    [self.topView.layer pop_addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

- (CATransform3D)transform3D
{
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = 2.5/-2000;
    return transform;
}

- (BOOL)isLocation:(CGPoint)location inView:(UIView *)view
{
    if ((location.x > 0 && location.x < CGRectGetWidth(self.bounds)) &&
        (location.y > 0 && location.y < CGRectGetHeight(self.bounds))) {
        return YES;
    }
    return NO;
}

- (UIImage *)imageForSection:(LayerSection)section withImage:(UIImage *)image
{
    CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height/2);
    if (section == LayerSectionBottom) {
        rect.origin.y = image.size.height/2;
    }
    
    CGImageRef imgRef = CGImageCreateWithImageInRect(image.CGImage, rect);
    UIImage *imagePart = [UIImage imageWithCGImage:imgRef];
    CGImageRelease(imgRef);
    
    return imagePart;
}

- (CAShapeLayer *)maskForSection:(LayerSection)section withRect:(CGRect)rect
{
    CAShapeLayer *layerMask = [CAShapeLayer layer];
    UIRectCorner corners = (section == LayerSectionTop) ? 3 : 12;
    
    layerMask.path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:CGSizeMake(5, 5)].CGPath;
    
    return layerMask;
}

#pragma mark - POPAnimationDelegate

- (void)pop_animationDidApply:(POPAnimation *)anim
{
    CGFloat currentValue = [[anim valueForKey:@"currentValue"] floatValue];
    if (currentValue > -M_PI_2) {
        self.backView.alpha = 0.f;
        [CATransaction begin];
        [CATransaction setValue:(id)kCFBooleanTrue
                         forKey:kCATransactionDisableActions];
        self.bottomShadowLayer.opacity = -currentValue/M_PI;
        self.topShadowLayer.opacity = -currentValue/M_PI;
        [CATransaction commit];
    }
}


@end
