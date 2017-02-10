//
//  PasswordViewController.m
//  FrameDemo
//
//  Created by 展祥叶 on 16/11/15.
//  Copyright © 2016年 ye zhanxiang. All rights reserved.
//

#import "PasswordViewController.h"
#import "PasswordStrengthIndicatorView.h"
#import "Masonry.h"

@interface PasswordViewController ()
@property(nonatomic) UITextField *passwordTextField;
@property(nonatomic) PasswordStrengthIndicatorView *passwordStrengthIndicatorView;
@end

@implementation PasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self addPasswordTextField];
    [self addPasswordStrengthView];
}

#pragma mark - Private Interface methods

- (void)addPasswordTextField
{
    UIView *leftPaddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 0)];
    
    self.passwordTextField = [UITextField new];
    self.passwordTextField.leftView = leftPaddingView;
    self.passwordTextField.leftViewMode = UITextFieldViewModeAlways;
    self.passwordTextField.backgroundColor = [UIColor colorWithWhite:0 alpha:0.05];
    self.passwordTextField.secureTextEntry = YES;
    self.passwordTextField.layer.cornerRadius = 2.f;
    self.passwordTextField.placeholder = @"请输入密码";
    [self.passwordTextField becomeFirstResponder];
    [self.passwordTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:self.passwordTextField];
    
    [_passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(36);
    }];
    
}

- (void)addPasswordStrengthView
{
    self.passwordStrengthIndicatorView = [PasswordStrengthIndicatorView new];
    [self.view addSubview:self.passwordStrengthIndicatorView];
    
    [_passwordStrengthIndicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_passwordTextField.mas_bottom).mas_equalTo(5);
        make.left.right.mas_equalTo(_passwordTextField);
        make.height.mas_equalTo(10);
    }];
}

- (void)textFieldDidChange:(UITextField *)sender
{
    if (sender.text.length < 1) {
        self.passwordStrengthIndicatorView.status = PasswordStrengthIndicatorViewStatusNone;
        return;
    }
    
    if (sender.text.length < 4) {
        self.passwordStrengthIndicatorView.status = PasswordStrengthIndicatorViewStatusWeak;
        return;
    }
    
    if (sender.text.length < 8) {
        self.passwordStrengthIndicatorView.status = PasswordStrengthIndicatorViewStatusFair;
        return;
    }
    
    self.passwordStrengthIndicatorView.status = PasswordStrengthIndicatorViewStatusStrong;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
