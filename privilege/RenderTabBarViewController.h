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



@interface RenderTabBarViewController : UITabBarController
{
    NSArray *tabBarNames;
}

// 自定义tabBar数组
@property (nonatomic, strong) NSArray *customTabBarArrays;

@end
