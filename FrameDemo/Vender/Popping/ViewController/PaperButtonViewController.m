//
//  PaperButtonViewController.m
//  FrameDemo
//
//  Created by 展祥叶 on 16/11/11.
//  Copyright © 2016年 ye zhanxiang. All rights reserved.
//

#import "PaperButtonViewController.h"
#import "PaperButton.h"
#import <POP/POP.h>

@interface PaperButtonViewController ()

@end

@implementation PaperButtonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self addPaperButton];
    
    
    UILabel *countdownLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
    countdownLbl.text = @"00:00:00";
    countdownLbl.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:countdownLbl];
    POPAnimatableProperty *prop = [POPAnimatableProperty propertyWithName:@"countdown" initializer:^(POPMutableAnimatableProperty *prop) {
        
        prop.writeBlock = ^(id obj, const CGFloat values[]) {
            UILabel *lable = (UILabel*)obj;
            lable.text = [NSString stringWithFormat:@"%02d:%02d:%02d",(int)values[0]/60,(int)values[0]%60,(int)(values[0]*100)%100];
        };
        
        prop.threshold = 0.01f;  //决定了动画变化间隔的阈值 值越大writeBlock的调用次数越少
    }];
    
    POPBasicAnimation *anBasic = [POPBasicAnimation linearAnimation];   //秒表当然必须是线性的时间函数
    anBasic.property = prop;    //自定义属性
    anBasic.fromValue = @(0);   //从0开始
    anBasic.toValue = @(3*60);  //180秒
    anBasic.duration = 3*60;    //持续3分钟
    anBasic.beginTime = CACurrentMediaTime() + 1.0f;    //延迟1秒开始
    [countdownLbl pop_addAnimation:anBasic forKey:@"countdown"];
}

- (void)addPaperButton
{
    PaperButton *button = [[PaperButton alloc] initWithFrame:CGRectMake(0, 0, 50, 44)];
    button.center = self.view.center;
    button.tintColor = [UIColor redColor];
    [self.view addSubview:button];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
