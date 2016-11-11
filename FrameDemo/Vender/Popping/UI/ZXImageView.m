//
//  ZXImageView.m
//  FrameDemo
//
//  Created by 展祥叶 on 16/11/11.
//  Copyright © 2016年 ye zhanxiang. All rights reserved.
//

#import "ZXImageView.h"

@interface ZXImageView ()

@property(nonatomic) UIImageView *imageView;

@end

@implementation ZXImageView

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame]) {
        self.layer.cornerRadius = 5.f;
        self.layer.masksToBounds = YES;
        
        _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        [self addSubview:_imageView];
    }
    return self;
}

#pragma mark - Property Setters

- (void)setImage:(UIImage *)image
{
    [self.imageView setImage:image];
    _image = image;
}

@end
