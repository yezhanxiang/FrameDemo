//
//  ZXImageInfoCellNode.m
//  FrameDemo
//
//  Created by 展祥叶 on 16/11/1.
//  Copyright © 2016年 ye zhanxiang. All rights reserved.
//

#import "ZXImageInfoCellNode.h"
#import "ZXTopicImageInfo.h"

@interface ZXImageInfoCellNode ()

@property (nonatomic, strong) ZXTopicImageInfo *imageInfo;

@property (nonatomic, strong) ASNetworkImageNode *imageNode;
@property (nonatomic, strong) ASTextNode *titleNode;

@end

@implementation ZXImageInfoCellNode

- (instancetype)initWithImageInfo:(ZXTopicImageInfo *)imageInfo
{
    if (self = [super init]) {
        _imageInfo = imageInfo;
        
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
    imageNode.contentMode = UIViewContentModeScaleToFill;
    imageNode.layerBacked = YES;
    NSString *urlStr = [NSString stringWithFormat:@"%@?w=750&h=20000&quality=75",_imageInfo.imgUrl ];
    imageNode.URL = [NSURL URLWithString:urlStr];
    [self addSubnode:imageNode];
    _imageNode = imageNode;
}

- (void)addTitleNode
{
    ASTextNode *titleNode = [[ASTextNode alloc] init];
    titleNode.layerBacked = YES;
    titleNode.maximumNumberOfLines = 1;
    titleNode.backgroundColor = RGBA_255(0, 0, 0, 0.2);
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    [paragraph setAlignment:NSTextAlignmentCenter];
    NSDictionary *attrs = @{ NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue" size:14.0f] ,NSForegroundColorAttributeName: [UIColor whiteColor],NSParagraphStyleAttributeName:paragraph};
    titleNode.attributedText = [[NSAttributedString alloc]initWithString:_imageInfo.title attributes:attrs];
    [self addSubnode:titleNode];
    _titleNode = titleNode;
    
}

- (ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize
{
    _imageNode.preferredFrameSize = CGSizeMake(267, 113);
    _titleNode.flexShrink = YES;
    ASStackLayoutSpec *verStackLayout = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical spacing:0 justifyContent:ASStackLayoutJustifyContentEnd alignItems:ASStackLayoutAlignItemsStretch children:@[_titleNode]];
    ASOverlayLayoutSpec *overlayLayout = [ASOverlayLayoutSpec overlayLayoutSpecWithChild:_imageNode overlay:verStackLayout];
    return overlayLayout;
}

@end
