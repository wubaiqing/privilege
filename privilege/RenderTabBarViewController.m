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

# pragma mark 所有导航控制器
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

# pragma mark 自定义Tabbar文字和位置
- (void) loadCustomTabBarViewControllers
{
    // 隐藏系统自带tabBar
    self.tabBar.hidden = YES;
    
    UIView *customTabBarImageView;
    
    // 自定义TabBar位置，兼容iphone5，不兼容通话模式
    if (iPhone5) {
        customTabBarImageView = [[UIView alloc] initWithFrame:CGRectMake(0, 519, 320, 49)];
    } else {
        customTabBarImageView = [[UIView alloc] initWithFrame:CGRectMake(0, 431, 320, 49)];
    }
    
    // 添加可点击的事件
    [customTabBarImageView setBackgroundColor:[UIColor whiteColor]];
    customTabBarImageView.userInteractionEnabled = YES;
    
    // 按钮偏移
    CGFloat tabBarViewCoordinate= 0;
    
    // tabBar名称
    tabBarNames = @[@"首页", @"值得逛", @"最新", @"个人中心"];
    
    // 添加四个TabBar
    for (int i = 0; i < tabBarNames.count; i++) {
        
        // 添加外边框视图，为了让文字和图片居中，宽度80，高度49，Tabbar高度
        UIView *tabBarView = [[UIView alloc] initWithFrame:CGRectMake(tabBarViewCoordinate, 0, 80, 49)];
        [tabBarView setBackgroundColor:[UIColor whiteColor]]; // 背景颜色
        tabBarViewCoordinate += 80; // 每次偏移80
        
        
        // 添加TabBar图片，默认图片，高亮后的图片
        // 设置图片大小30*30
        NSString *buttonImage = [NSString stringWithFormat:@"tabbar_button_%d", i];
        NSString *buttonHightlightImage = [NSString stringWithFormat:@"tabbar_button_hightlight_%d", i];
        UIImageView *buttonView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:buttonImage] highlightedImage:[UIImage imageNamed:buttonHightlightImage]];
        [buttonView setFrame:CGRectMake(0, 0, 30, 30)];
        
        // 设置图片位置，以及图片大小
        // 添加自定义tabBar按钮，并加上点击事件
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [button setTag:i];
        [button setFrame:CGRectMake(80/2 -  30/2, 3, 30, 30)];
        [button addTarget:self action:@selector(clickTabBar:) forControlEvents:UIControlEventTouchUpInside];
        [button addSubview:buttonView];
        [tabBarView addSubview:button];
        
        // 添加TabBar底部按钮
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 35 , 80, 8)];
        [label setFont:[UIFont fontWithName:@"Helvetica" size:11.0]];
        [label setText:[tabBarNames objectAtIndex:i]];
        [label setTextAlignment:NSTextAlignmentCenter];
        [label setTextColor:[UIColor grayColor]];
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
    
    for (int i = 0; i < tabBarNames.count; i++) {
        UIButton *currentButton = ((UIButton *)[self.view viewWithTag:i]);
        
        NSLog(@"%@", (UIImageView *)currentButton.subviews[0]);
    }
    
    
    
}





@end
