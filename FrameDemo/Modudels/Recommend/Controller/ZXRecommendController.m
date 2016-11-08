//
//  ZXRecommendController.m
//  FrameDemo
//
//  Created by 展祥叶 on 16/11/1.
//  Copyright © 2016年 ye zhanxiang. All rights reserved.
//

#import "ZXRecommendController.h"
#import "ZXImagePagerCellNode.h"
#import "ZXRecommendCellNode.h"
#import "ZXRecommendViewModel.h"
#import "ZXLoadingView.h"

@interface ZXRecommendController ()<ASCollectionDelegate, ASCollectionDataSource>

//UI
@property (nonatomic, strong) ASCollectionNode *collectionNode;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

//VM
@property (nonatomic, strong) ZXRecommendViewModel *viewModel;

@end

#define kRecommendPagerHeight 113
#define kRecommendItemWidth (kScreenWidth > 320 ? 98 : 86)
#define kRecommendItemHeight 102
#define kRecommendItemHorEdge (kScreenWidth > 320 ? 16 : 10)
#define kRecommendItemVerEdge 20

static NSString *footerId = @"UICollectionReusableView";

@implementation ZXRecommendController

#pragma mark - life cycle
- (instancetype)init
{
    if (self = [super initWithNode:[ASDisplayNode new]]) {
        _viewModel = [[ZXRecommendViewModel alloc] init];
        [self addCollectionNode];
    }
    return self;
}

- (void)addCollectionNode
{
    _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _collectionNode = [[ASCollectionNode alloc] initWithCollectionViewLayout:_flowLayout];
    _collectionNode.backgroundColor = [UIColor whiteColor];
    _collectionNode.delegate = self;
    _collectionNode.dataSource = self;
    
    [self.node addSubnode:_collectionNode];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"推荐";
    [_collectionNode.view registerSupplementaryNodeOfKind:UICollectionElementKindSectionFooter];
    
    [self loadData];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    _collectionNode.frame = self.node.bounds;
}

- (void)loadData
{
    [ZXLoadingView showLodingInView:self.view];
    WEAK_REF(self)
    [_viewModel fetchAllDataWithBlock:^(NSError *error) {
        [ZXLoadingView hideLoadingForView:weak_self.view];
        if (error) {
            NSLog(@"%@", [error domain]);
        }else{
            [weak_self.collectionNode reloadData];
        }
    }];
}

#pragma mark - ASCollectionDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 1;
        case 1:
            return _viewModel.imageInfoDatas.count;
        default:
            return 0;
    }
}

- (ASCellNodeBlock)collectionView:(ASCollectionView *)collectionView nodeBlockForItemAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
            ASCellNode *(^cellNodeBlock)() = ^ASCellNode *() {
                ZXImagePagerCellNode *cellNode = [[ZXImagePagerCellNode alloc] initWithImageInfos:_viewModel.topicDatas];
                return cellNode;
            };
            return cellNodeBlock;
        }
        case 1:
        {
            ZXRecommendItem *item = _viewModel.imageInfoDatas[indexPath.row];
            ASCellNode *(^cellNodeBlock)() = ^ASCellNode *() {
                ZXRecommendCellNode *cellNode = [[ZXRecommendCellNode alloc] initWithItem:item];
                return cellNode;
            };
            return cellNodeBlock;
        }
        default:
            return nil;
    }
}

- (ASCellNode *)collectionView:(ASCollectionView *)collectionView nodeForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && [kind isEqualToString:UICollectionElementKindSectionFooter]) {
        
        ASCellNode *cellNode = [[ASCellNode alloc] init];
        cellNode.backgroundColor = RGB_255(241, 241, 241);
        cellNode.preferredFrameSize = CGSizeMake(CGRectGetWidth(self.view.frame), 6);
        return cellNode;
    }
    
    return nil;
}

#pragma mark - ASCollectionDelegate
- (CGSize)collectionView:(ASCollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return CGSizeMake(CGRectGetWidth(self.view.frame), 6);
    }
    return CGSizeZero;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    switch (section) {
        case 0:
            return UIEdgeInsetsMake(15, 0, 15, 0);
        case 1:
            return UIEdgeInsetsMake(kRecommendItemVerEdge, kRecommendItemHorEdge, kRecommendItemVerEdge, kRecommendItemHorEdge);
        default:
            return UIEdgeInsetsZero;
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    switch (section) {
        case 1:
            return 35;
        default:
            return 0;
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    switch (section) {
        case 1:
            return floor((CGRectGetWidth(collectionView.frame) - 3*kRecommendItemWidth - 2*kRecommendItemHorEdge)/2);
        default:
            return 0;
    }
}

- (ASSizeRange)collectionView:(ASCollectionView *)collectionView constrainedSizeForNodeAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            return ASSizeRangeMake(CGSizeMake(CGRectGetWidth(self.view.frame), kRecommendPagerHeight),CGSizeMake(CGRectGetWidth(self.view.frame), kRecommendPagerHeight));
        case 1:
            return ASSizeRangeMake(CGSizeMake(kRecommendItemWidth, kRecommendItemHeight),CGSizeMake(kRecommendItemWidth, kRecommendItemHeight));
        default:
            return ASSizeRangeMake(CGSizeZero,CGSizeZero);
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
