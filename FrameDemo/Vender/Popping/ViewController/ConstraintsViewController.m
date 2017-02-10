//
//  ConstraintsViewController.m
//  FrameDemo
//
//  Created by 展祥叶 on 16/11/16.
//  Copyright © 2016年 ye zhanxiang. All rights reserved.
//

#import "ConstraintsViewController.h"
#import "Masonry.h"

@interface ConstraintsViewController ()
@property (nonatomic, strong) UIView *redView;
@property (nonatomic, strong) UIView *greenView;
@property (nonatomic, strong) UIView *blueView;
@property (nonatomic, strong) UIView *contentView;
@end

@implementation ConstraintsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self addBarButton];
    [self addViews];
    [self updateConstraints:nil];
}

#pragma mark - Private Instance Methods

- (void)addBarButton
{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"转换"
                                                             style:UIBarButtonItemStylePlain
                                                            target:self
                                                            action:@selector(updateConstraints:)];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)addViews
{
    self.contentView = [UIView new];
    self.contentView.translatesAutoresizingMaskIntoConstraints = NO;
    self.contentView.backgroundColor = self.view.backgroundColor;
    [self.view addSubview:self.contentView];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.mas_equalTo(0);
    }];
    
    self.redView = [UIView new];
    self.redView.backgroundColor = [UIColor redColor];
    self.redView.translatesAutoresizingMaskIntoConstraints = NO;
    self.redView.layer.cornerRadius = 4.f;
    self.greenView = [UIView new];
    self.greenView.backgroundColor = [UIColor greenColor];
    self.greenView.translatesAutoresizingMaskIntoConstraints = NO;
    self.greenView.layer.cornerRadius = 4.f;
    self.blueView = [UIView new];
    self.blueView.backgroundColor = [UIColor yellowColor];
    self.blueView.translatesAutoresizingMaskIntoConstraints = NO;
    self.blueView.layer.cornerRadius = 4.f;
    
    [self.contentView addSubview:self.redView];
    [self.contentView addSubview:self.greenView];
    [self.contentView addSubview:self.blueView];
}

- (void)updateConstraints:(id)sender
{
    [self.contentView layoutIfNeeded];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_redView, _greenView, _blueView);
    NSArray *viewNames = [self shuffledArrayFromArray:views.allValues];
    
    UIView *firstView= (UIView *)viewNames[0];
    UIView *secondView = (UIView *)viewNames[1];
    UIView *thirdView = (UIView *)viewNames[2];
    
    [firstView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(150);
    }];
    
    [secondView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(firstView.mas_bottom).mas_equalTo(5);
        make.left.mas_equalTo(10);
        make.width.mas_equalTo(kScreenWidth/2-15);
        make.height.mas_equalTo(200);
    }];
    
    [thirdView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(firstView.mas_bottom).mas_equalTo(5);
        make.right.mas_equalTo(-10);
        make.width.mas_equalTo(kScreenWidth/2-15);
        make.height.mas_equalTo(200);
    }];
    
    [UIView animateWithDuration:0.5
                          delay:0
         usingSpringWithDamping:0.7
          initialSpringVelocity:0.7
                        options:0
                     animations:^{
                         [self.contentView layoutIfNeeded];
                     } completion:NULL];
    
}

- (NSArray *)shuffledArrayFromArray:(NSArray *)array
{
    NSMutableArray *shuffleArray = [array mutableCopy];
    NSUInteger count = shuffleArray.count;
    for (NSUInteger i = 0; i < count; i++) {
        NSUInteger nElements = count - i;
        NSUInteger n = arc4random_uniform((uint32_t)nElements) + i;
        [shuffleArray exchangeObjectAtIndex:i withObjectAtIndex:n];
    }
    
    return [shuffleArray copy];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
