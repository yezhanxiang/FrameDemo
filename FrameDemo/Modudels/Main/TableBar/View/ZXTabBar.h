//
//  ZXTabBar.h
//  FrameDemo
//
//  Created by 展祥叶 on 16/10/31.
//  Copyright © 2016年 ye zhanxiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZXTabBarDelegate <NSObject>

- (void)midButtonDidClick:(UIButton *)btn;

@end

@interface ZXTabBar : UITabBar
@property (nonatomic, weak, readonly) UIButton *midBtn;
@property (nonatomic, assign) NSUInteger numOfTabBarItem;
@property (nonatomic, assign) BOOL isHasMidBtn;
@property (nonatomic, weak) id<ZXTabBarDelegate> tabBardelegate;
@end
