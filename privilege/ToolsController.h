/**
 * 页面工具栏
 * Copyright (c) 2014年 吴佰清. All rights reserved.
 */
#import <UIKit/UIKit.h>

// 是否是iphone5设备
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : 0)

// 每个TabBar的宽度
#define toolsWidth 80

// TabBar的整体高度
#define toolsHeight 49

// Tabbar 图标TAG
#define tabbarImageTag = 1000;

// Tabbar 标签TAG
#define tabbarLabelTag = 2000;

@interface ToolsController : UITabBarController
{
}

// 自定义tabBar数组
@property (nonatomic, strong) NSArray *customTabBarArrays;

- (void) showTools;
- (void) hiddenTools;

@end
