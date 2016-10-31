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


#pragma mark - Getter and Setter
- (ASTableNode *)tableNode
{
    return (ASTableNode *)self.node;
}

- (NSArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = @[@"打算电话卡就是多卡就是等哈来上课记得换卡了是丢为企业期望",
                       @"ewqueoiwqueoiqwu",
                       @"大连市空间woeuqwoieuoqw空间溜达我阿斯顿啊四大俗撒打算打算打算打算打算的啊打算阿迪阿斯顿",
                       @"恶趣味",
                       @"额外",
                       @"大叔大叔大叔大叔",
                       @"大连市空间woeuqwoieuoqw空间溜达我阿斯顿啊四大俗撒打算打算打算打算打算的啊打算阿迪阿斯顿大连市空间woeuqwoieuoqw空间溜达我阿斯顿啊四大俗撒打算打算打算打算打算的啊打算阿迪阿斯顿大连市空间woeuqwoieuoqw空间溜达我阿斯顿啊四大俗撒打算打算打算打算打算的啊打算阿迪阿斯顿",
                       @"打算的大叔大叔大叔大叔答打算的啊四大俗阿斯顿啊啊岁的啊",
                       @"213123213123",
                       @"oqwueoiqwueoiqwuoeiwqueqiwoueoqwiueoqwieuqowieuqwoeiuq"];
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
