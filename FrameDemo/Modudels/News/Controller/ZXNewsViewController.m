//
//  ZXNewsViewController.m
//  FrameDemo
//
//  Created by 展祥叶 on 16/10/31.
//  Copyright © 2016年 ye zhanxiang. All rights reserved.
//

#import "ZXNewsViewController.h"

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
        textCellNode.text = self.dataArray[indexPath.row];
        return textCellNode;
    };
}

#pragma mark - ASTableDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

#pragma mark - Getter and Setter
- (ASTableNode *)tableNode
{
    return (ASTableNode *)self.node;
}

- (NSArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = @[@"abstract", @"animals", @"business", @"cats", @"city", @"food", @"nightlife", @"fashion", @"people", @"nature", @"sports", @"technics", @"transport"];
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
