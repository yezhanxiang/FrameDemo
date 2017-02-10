//
//  PasswordStrengthIndicatorView.h
//  FrameDemo
//
//  Created by 展祥叶 on 16/11/15.
//  Copyright © 2016年 ye zhanxiang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, PasswordStrengthIndicatorViewStatus) {
    PasswordStrengthIndicatorViewStatusNone,
    PasswordStrengthIndicatorViewStatusWeak,
    PasswordStrengthIndicatorViewStatusFair,
    PasswordStrengthIndicatorViewStatusStrong
};

@interface PasswordStrengthIndicatorView : UIView

@property(nonatomic) PasswordStrengthIndicatorViewStatus status;

@end
