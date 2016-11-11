//
//  ButtonViewController.m
//  FrameDemo
//
//  Created by 展祥叶 on 16/11/10.
//  Copyright © 2016年 ye zhanxiang. All rights reserved.
//

#import "ButtonViewController.h"
#import "FlatButton.h"
#import <pop/POP.h>

@interface ButtonViewController ()
@property (nonatomic, weak) FlatButton *button;
@end

@implementation ButtonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self addButtonNode];
}

- (void)addButtonNode
{
    FlatButton *button = [FlatButton button];
    button.frame = CGRectMake(0, 0, 80, 50);
    button.center = self.view.center;
    [button setTitle:@"按钮" forState:UIControlStateNormal];
    
    [self.view addSubview:button];
    _button = button;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
