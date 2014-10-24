//
//  RenderTabBarViewController.m
//  privilege
//
//  Created by 吴佰清 on 14-10-17.
//  Copyright (c) 2014年 吴佰清. All rights reserved.
//

#import "RenderTabBarViewController.h"

// 引用视图
#import "IndexViewController.h"     // 首页
#import "GuangViewController.h"     // 分类
#import "NowViewController.h"       // 最新
#import "UserCenterViewController.h"// 个人中心

@interface RenderTabBarViewController ()

@end

@implementation RenderTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 载入所有导航控制器
    [self loadCustomNavigationViewControllers];
    
    // 载入所有自定义tabBar
    [self loadCustomTabBarViewControllers];
}

- (void) loadCustomNavigationViewControllers
{
    IndexViewController *index = [[IndexViewController alloc] init];
    UINavigationController *indexNav = [[UINavigationController alloc] initWithRootViewController:index];
    
    GuangViewController *guang = [[GuangViewController alloc] init];
    UINavigationController *guangNav = [[UINavigationController alloc] initWithRootViewController:guang];
    
    NowViewController *now = [[NowViewController alloc] init];
    UINavigationController *nowNav = [[UINavigationController alloc] initWithRootViewController:now];
    
    UserCenterViewController *user = [[UserCenterViewController alloc] init];
    UINavigationController *userNav = [[UINavigationController alloc] initWithRootViewController:user];
    
    // 添加视图
    _customTabBarArrays = @[indexNav, guangNav, nowNav, userNav];
    [self setViewControllers:_customTabBarArrays animated:YES];
}

- (void) loadCustomTabBarViewControllers
{
    // 隐藏系统自带tabBar
    self.tabBar.hidden = YES;
    
    UIView *customTabBarImageView;
    
    // 自定义TabBar
    if (iPhone5) {
        customTabBarImageView = [[UIView alloc] initWithFrame:CGRectMake(0, 519, 320, 49)];
    } else {
        customTabBarImageView = [[UIView alloc] initWithFrame:CGRectMake(0, 431, 320, 49)];
    }
    
    [customTabBarImageView setBackgroundColor:[UIColor whiteColor]];
    customTabBarImageView.userInteractionEnabled = YES;
    
    // 偏移量
    CGFloat tabBarTextMargin = tabBarImageMargin + tabBarImageHeight;
    CGFloat tabBarViewCoordinate= 0;
    
    NSArray *tabBarNames = @[@"首页", @"值得逛", @"最新", @"个人中心"];
    
    // 添加四个TabBar
    for (int i = 0; i < tabBarNames.count; i++) {
        
        // 添加外边框视图，为了让文字和图片居中
        UIView *tabBarView = [[UIView alloc] initWithFrame:CGRectMake(tabBarViewCoordinate, 0, eachTabBarViewWidth, customTabBarViewHeight)];
        [tabBarView setBackgroundColor:[UIColor whiteColor]];
        tabBarViewCoordinate += eachTabBarViewWidth;
        
        // 添加自定义tabBar按钮，并加上点击事件
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        button.tag = i;
        // 按钮居中
        button.frame = CGRectMake(eachTabBarViewWidth / 2 - tabBarImageWidth / 2, 5, tabBarImageWidth, tabBarImageHeight);
        
        // 添加TabBar图片
        NSString *imageName = [NSString stringWithFormat:@"tabbar_button_hightlight_%d", i];
        [button setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        [button setFrame:CGRectMake(49/2 -  30/2, 0, 30, 30)];
        [button addTarget:self action:@selector(clickTabBar:) forControlEvents:UIControlEventTouchUpInside];
        [tabBarView addSubview:button];
        
        // 添加TabBar底部按钮
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, tabBarTextMargin, 80, 8)];
        [label setFont:[UIFont fontWithName:@"Helvetica" size:11.0]];
        label.text = [tabBarNames objectAtIndex:i];
        [label setTextAlignment:NSTextAlignmentCenter];
        [tabBarView addSubview:label];
        
        // 添加到UITabBarController中
        [customTabBarImageView addSubview:tabBarView];
    }
    
    [self.view addSubview:customTabBarImageView];
}

// 点击TabBar效果
- (void) clickTabBar:(UIButton *)button
{
    self.selectedIndex = button.tag;
}





@end
