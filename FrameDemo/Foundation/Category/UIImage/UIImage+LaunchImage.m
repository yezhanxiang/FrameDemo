//
//  UIImage+LaunchImage.m
//  FrameDemo
//
//  Created by 展祥叶 on 16/10/24.
//  Copyright © 2016年 ye zhanxiang. All rights reserved.
//

#import "UIImage+LaunchImage.h"

//current window
#define tyCurrentWindow [[UIApplication sharedApplication].windows firstObject]

@implementation UIImage (LaunchImage)

// 引用自stackflow
+ (NSString *)ty_getLaunchImageName
{
    NSString *viewOrientation = @"Portrait";
    if (UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation])) {
        viewOrientation = @"Landscape";
    }
    NSString *launchImageName = nil;
    NSArray* imagesDict = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"UILaunchImages"];
    CGSize viewSize = tyCurrentWindow.bounds.size;
    for (NSDictionary* dict in imagesDict)
    {
        CGSize imageSize = CGSizeFromString(dict[@"UILaunchImageSize"]);
        
        if (CGSizeEqualToSize(imageSize, viewSize) && [viewOrientation isEqualToString:dict[@"UILaunchImageOrientation"]])
        {
            launchImageName = dict[@"UILaunchImageName"];
        }
    }
    return launchImageName;
}

+ (UIImage *)ty_getLaunchImage
{
    return [UIImage imageNamed:[self ty_getLaunchImageName]];
}


@end
