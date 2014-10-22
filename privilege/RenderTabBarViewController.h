//
//  RenderTabBarViewController.h
//  privilege
//
//  Created by 吴佰清 on 14-10-17.
//  Copyright (c) 2014年 吴佰清. All rights reserved.
//

#import <UIKit/UIKit.h>

// 是否是iphone5设备
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : 0)

// 是否是IOS7 的设备
#define IOS7 [[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0

// TabBar的整体高度
#define customTabBarViewHeight 49

// 每一个TabBar的视图宽度
#define eachTabBarViewWidth 80

// TabBar -> button 按钮宽度
#define tabBarImageWidth 49

// TabBar -> button 按钮高度
#define tabBarImageHeight 49

// TabBar -> TabBar -> button -> margin 按钮间距
#define tabBarImageMargin 8


@interface RenderTabBarViewController : UITabBarController

// 自定义tabBar数组
@property (nonatomic, strong) NSArray *customTabBarArrays;

@end
