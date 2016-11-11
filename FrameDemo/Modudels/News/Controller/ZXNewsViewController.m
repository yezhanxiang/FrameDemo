//
//  ZXNewsViewController.m
//  FrameDemo
//
//  Created by 展祥叶 on 16/10/31.
//  Copyright © 2016年 ye zhanxiang. All rights reserved.
//

#import "ZXNewsViewController.h"
#import "ButtonViewController.h"
#import "DecayViewController.h"
#import "CircleViewController.h"
#import "ImageViewController.h"
#import "CustomTransitionViewController.h"
#import "PaperButtonViewController.h"

@interface ZXNewsViewController ()<ASTableDelegate, ASTableDataSource>
@property (nonatomic, strong) ASTableNode *tableNode;
@property (nonatomic, strong) NSArray *dataArray;
@end

@implementation ZXNewsViewController

- (instancetype)init
{
    if (self = [super initWithNode:[ASTableNode new]]) {
        
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableNode.delegate = self;
    self.tableNode.dataSource = self;
}

#pragma mark - ASTableDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (ASCellNodeBlock)tableView:(ASTableView *)tableView nodeBlockForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ^{
        ASTextCellNode *textCellNode = [ASTextCellNode new];
        textCellNode.text = [self.dataArray[indexPath.row] firstObject];
        return textCellNode;
    };
}

#pragma mark - ASTableDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *viewController = [self viewControllerForRowAtIndexPath:indexPath];
    viewController.title = [self titleForRowAtIndexPath:indexPath];
    [self.navigationController pushViewController:viewController animated:YES];
}

#pragma mark - Private instance methods
- (NSString *)titleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.dataArray[indexPath.row] firstObject];
}

- (UIViewController *)viewControllerForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [[self.dataArray[indexPath.row] lastObject] new];
}

#pragma mark - Getter and Setter
- (ASTableNode *)tableNode
{
    return (ASTableNode *)self.node;
}

- (NSArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = @[
                        @[@"Button Animation", [ButtonViewController class]],
                        @[@"Decay Animation", [DecayViewController class]],
                        @[@"Circle Animation", [CircleViewController class]],
                        @[@"Image Animation", [ImageViewController class]],
                        @[@"Custom Transition", [CustomTransitionViewController class]],
                        @[@"Paper Button Animation", [PaperButtonViewController class]]
                       ];
    }
    return _dataArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    self.tableNode.delegate = nil;
    self.tableNode.dataSource = nil;
}

@end
