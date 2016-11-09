//
//  ZXMineViewController.m
//  FrameDemo
//
//  Created by 展祥叶 on 16/11/9.
//  Copyright © 2016年 ye zhanxiang. All rights reserved.
//

#import "ZXMineViewController.h"
#import "ZXMineHeaderView.h"

@interface ZXMineViewController ()<ASTableDelegate, ASTableDataSource>
@property (nonatomic, strong) ASTableNode *tableNode;
@property (nonatomic, strong) ZXMineHeaderView *headerView;
@end

@implementation ZXMineViewController

- (instancetype)init
{
    if (self = [super initWithNode:[ASDisplayNode new]]) {

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addTableNode];
    [self addTableHeader];
}

- (void)addTableNode
{
    _tableNode = [[ASTableNode alloc] initWithStyle:UITableViewStyleGrouped];
    _tableNode.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - 49 - 64);
    _tableNode.backgroundColor = [UIColor whiteColor];
    _tableNode.delegate = self;
    _tableNode.dataSource = self;
//    _tableNode.view.contentInset = UIEdgeInsetsMake(0, 0, 49, 0);
//    _tableNode.view.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 49, 0);
    [self.node addSubnode:_tableNode];
}

- (void)addTableHeader
{
    _headerView = [[ZXMineHeaderView alloc] initWithFrame: CGRectMake(0, 0, kScreenWidth, 150)];
    
    _tableNode.view.tableHeaderView = _headerView;

}

#pragma mark - ASTableDelegate, ASTableDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (ASCellNodeBlock)tableView:(ASTableView *)tableView nodeBlockForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ^{
        ASTextCellNode *cellNode = [[ASTextCellNode alloc] init];
        cellNode.text = @"321";
        return cellNode;
    };
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
    headerView.backgroundColor = UIColorFromRGBA(0xE7E7E7, 1);
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    if(offsetY <= 0) {
        [_headerView.bgView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(offsetY);
        }];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
