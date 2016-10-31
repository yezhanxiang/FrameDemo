//
//  ZXLaunchController.m
//  FrameDemo
//
//  Created by 展祥叶 on 16/10/24.
//  Copyright © 2016年 ye zhanxiang. All rights reserved.
//

#import "ZXLaunchController.h"
#import "ZXLaunchView.h"
#import "UIImage+LaunchImage.h"
#import <YYWebImage.h>

@interface ZXLaunchController ()

@property (nonatomic, weak) ZXLaunchView *adLaunchView;
@property (nonatomic, strong) dispatch_source_t timer;
@property (nonatomic, strong) ZXLaunchViewModel *viewModel;

@end

@implementation ZXLaunchController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _viewModel = [ZXLaunchViewModel new];
    _viewModel.delegate = self;
    
    [self addADLaunchView];
    
    [self loadData];

}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    _adLaunchView.frame = self.view.bounds;
}

- (void)addADLaunchView
{
    ZXLaunchView *adLaunchView = [[ZXLaunchView alloc] init];
    adLaunchView.skipBtn.hidden = YES;
    adLaunchView.launchImageView.image = [UIImage ty_getLaunchImage];
    [adLaunchView.skipBtn addTarget:self action:@selector(skipADAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:adLaunchView];
    _adLaunchView = adLaunchView;
}

- (void)loadData
{
    //http://i.play.163.com/news/initLogo/ios_iphone6
    //    NSString *urlStr = @"http://img3.cache.netease.com/game/app/qidong/history/20161024/20161024_750x1334.jpg";
    [_viewModel loadLaunchImageDate];
}

#pragma mark - private

- (void)showADImageWithURL:(NSURL *)url
{

    __weak typeof(self) weakSelf = self;
    [_adLaunchView.adImageView yy_setImageWithURL:url placeholder:nil options:YYWebImageOptionSetImageWithFadeAnimation completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
        // 启动倒计时
        [weakSelf scheduledGCDTimer];
    }];
    
}

- (void)showSkipBtnTitleTime:(int)timeLeave
{
    NSString *timeLeaveStr = [NSString stringWithFormat:@"跳过 %ds", timeLeave];
    [_adLaunchView.skipBtn setTitle:timeLeaveStr forState:UIControlStateNormal];
    _adLaunchView.skipBtn.hidden = NO;
}

- (void)scheduledGCDTimer
{
    [self cancleGCDTimer];
    __block int timeLeave = 3; //倒计时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0);
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0*NSEC_PER_SEC, 0);////每秒执行
    __typeof (self) __weak weakSelf = self;
    dispatch_source_set_event_handler(_timer, ^{
        if (timeLeave <= 0) { //倒计时结束，关闭
            dispatch_source_cancel(weakSelf.timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //关闭界面
                [weakSelf dismissController];
            });
        }else {
            int curTimeLeave = timeLeave;
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面
                [weakSelf showSkipBtnTitleTime:curTimeLeave];
            });
            
            --timeLeave;
            
        }
    });
    
    dispatch_resume(_timer);
    
}

- (void)cancleGCDTimer
{
    if (_timer) {
        dispatch_source_cancel(_timer);
        _timer = nil;
    }
}

#pragma mark - Action
- (void)skipADAction
{
    [self dismissController];
}

- (void)dismissController
{
    [_viewModel cancel];
    [self cancleGCDTimer];
    
    [UIView animateWithDuration:1 delay:0.2 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        self.view.transform = CGAffineTransformMakeScale(1.1, 1.1);
        self.view.alpha = 0;
        
    } completion:^(BOOL finished) {
        [self.view removeFromSuperview];
        [self removeFromParentViewController];
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    [self cancleGCDTimer];
}

#pragma mark - TYRequestDelegate
- (void)requestDidFinish:(ZXLaunchViewModel *)request
{
    NSString *imageURL = (NSString *)request.responseObject.data;
    if (!imageURL && ![imageURL isKindOfClass:[NSString class]]) {
        [self dismissController];
    }
    
    [self showADImageWithURL:[NSURL URLWithString:imageURL]];
}

- (void)requestDidFail:(ZXLaunchViewModel *)request error:(NSError *)error
{
    [self dismissController];
}

@end
