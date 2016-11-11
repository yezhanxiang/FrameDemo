//
//  CircleViewController.m
//  FrameDemo
//
//  Created by 展祥叶 on 16/11/10.
//  Copyright © 2016年 ye zhanxiang. All rights reserved.
//

#import "CircleViewController.h"
#import "CircleView.h"

@interface CircleViewController ()
@property (nonatomic, strong) CircleView *circelView;
@end

@implementation CircleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self addCircleView];
    [self addSlider];
}

#pragma mark - Private Instance methods

- (void)addCircleView
{
    CGRect frame = CGRectMake(0.f, 0.f, 200.f, 200.f);
    self.circelView = [[CircleView alloc] initWithFrame:frame];
    self.circelView.strokeColor = self.view.tintColor;
    self.circelView.center = self.view.center;
    
    [self.view addSubview:self.circelView];
}

- (void)addSlider
{
    UISlider *slider = [UISlider new];
    slider.value = 0.2f;
    slider.tintColor = RGB_255(52, 152, 219);
    slider.translatesAutoresizingMaskIntoConstraints = NO;
    [slider addTarget:self action:@selector(sliderChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:slider];
    NSDictionary *views = NSDictionaryOfVariableBindings(slider, _circelView);
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_circelView]-(20)-[slider]"
                                                                    options:NSLayoutFormatAlignAllCenterX
                                                                    metrics:nil
                                                                      views:views]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(50)-[slider]-(50)-|"
                                                                    options:NSLayoutFormatAlignAllCenterX
                                                                    metrics:nil
                                                                      views:views]];
    
    [self.circelView setStrokeEnd:slider.value animated:NO];
}

- (void)sliderChanged:(UISlider *)slider
{
    [self.circelView setStrokeEnd:slider.value animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
