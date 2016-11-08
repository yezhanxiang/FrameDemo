//
//  ZXRecommendCellNode.m
//  FrameDemo
//
//  Created by 展祥叶 on 16/11/2.
//  Copyright © 2016年 ye zhanxiang. All rights reserved.
//

#import "ZXRecommendCellNode.h"

@interface ZXRecommendCellNode ()

@property (nonatomic, strong) ZXRecommendItem *item;

@property (nonatomic, strong) ASNetworkImageNode *imageNode;
@property (nonatomic, strong) ASTextNode *titleNode;

@end

@implementation ZXRecommendCellNode

- (instancetype)initWithItem:(ZXRecommendItem *)item
{
    if (self = [super init]) {
        _item = item;
        
        [self addImageNode];
        
        [self addTitleNode];
    }
    return self;
}

- (void)addImageNode
{
    ASNetworkImageNode *imageNode = [[ASNetworkImageNode alloc] init];
    imageNode.placeholderEnabled = YES;
    imageNode.placeholderColor = RGB_255(245, 245, 245);
    imageNode.layerBacked = YES;
    NSString *urlStr = [NSString stringWithFormat:@"%@?w=750&h=20000&quality=75",_item.iconUrl ];
    imageNode.URL = [NSURL URLWithString:urlStr];
    [self addSubnode:imageNode];
    _imageNode = imageNode;
}

- (void)addTitleNode
{
    ASTextNode  *titleNode = [ASTextNode new];
    titleNode.placeholderEnabled = YES;
    titleNode.placeholderColor = RGB_255(245, 245, 245);
    titleNode.layerBacked = YES;
    titleNode.maximumNumberOfLines = 1;
    NSDictionary *attrs = @{ NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue" size:12.0f] ,NSForegroundColorAttributeName: RGB_255(36, 36, 36)};
    titleNode.attributedText = [[NSAttributedString alloc]initWithString:_item.topicName ? _item.topicName :@"" attributes:attrs];
    [self addSubnode:titleNode];
    _titleNode = titleNode;
}

- (ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize
{
    _imageNode.preferredFrameSize = CGSizeMake(78, 78);
    _titleNode.flexShrink = YES;
    ASStackLayoutSpec *verStackLayout = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical spacing:8 justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsCenter children:@[_imageNode, _titleNode]];
    
    return verStackLayout;
}

@end
