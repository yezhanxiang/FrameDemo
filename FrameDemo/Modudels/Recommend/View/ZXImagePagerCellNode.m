//
//  ZXImagePagerCellNode.m
//  FrameDemo
//
//  Created by 展祥叶 on 16/11/1.
//  Copyright © 2016年 ye zhanxiang. All rights reserved.
//

#import "ZXImagePagerCellNode.h"
#import "ZXImageInfoCellNode.h"

@interface ZXImagePagerCellNode ()<ASPagerDataSource, ASPagerDelegate>
@property (nonatomic, strong) NSArray *imageInfos;
@property (nonatomic, strong) ASPagerNode *pagerNode;
@end

@implementation ZXImagePagerCellNode

- (instancetype)initWithImageInfos:(NSArray *)imageInfos
{
    if (self = [super init]) {
        _imageInfos = imageInfos;
        self.userInteractionEnabled = YES;
        [self addPagerNode];
    }
    return self;
}

- (void)addPagerNode
{
    ASPagerFlowLayout *flowLayout = [[ASPagerFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.minimumLineSpacing = 10;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 15, 0, 15);
    ASPagerNode *pagerNode = [[ASPagerNode alloc] initWithCollectionViewLayout:flowLayout];
    pagerNode.delegate = self;
    pagerNode.dataSource = self;
    
    [self addSubnode:pagerNode];
    _pagerNode = pagerNode;
}

- (void)didLoad
{
    [super didLoad];
    _pagerNode.view.pagingEnabled = NO;
    _pagerNode.view.allowsSelection = YES;
    [_pagerNode reloadData];
}

- (ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize
{
    ASInsetLayoutSpec *insetLayout = [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsZero child:_pagerNode];
    
    return insetLayout;
}

#pragma mark - ASPagerDataSource

- (NSInteger)numberOfPagesInPagerNode:(ASPagerNode *)pagerNode
{
    return _imageInfos.count;
}

- (ASCellNodeBlock)pagerNode:(ASPagerNode *)pagerNode nodeBlockAtIndex:(NSInteger)index
{
    ZXTopicImageInfo *imageInfo = _imageInfos[index];
    ASCellNode *(^cellNodeBlock)() = ^ASCellNode *() {
        ZXImageInfoCellNode *cellNode = [[ZXImageInfoCellNode alloc] initWithImageInfo:imageInfo];
        return cellNode;
    };
    return cellNodeBlock;
}

- (ASSizeRange)pagerNode:(ASPagerNode *)pagerNode constrainedSizeForNodeAtIndexPath:(NSIndexPath *)indexPath
{
    return ASSizeRangeMake(CGSizeMake(kScreenWidth-57, 113), CGSizeMake(kScreenWidth-57, 113));
}

#pragma mark - ASPagerDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
