/**
 * 工具栏菜单
 * Copyright (c) 2014年 吴佰清. All rights reserved.
 */
#import "ToolsController.h"

// 首页
#import "IndexController.h"

// 值得逛
#import "GuangController.h"

// 最新
#import "NewController.h"

// 关于我们
#import "AboutController.h"

@interface ToolsController ()
{
    // 底部工具栏区域
    UIView *customTabBarImageView;
}

@end

@implementation ToolsController

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
    [UINavigationBar appearance].tintColor = [UIColor whiteColor];
    
    IndexController *index = [[IndexController alloc] init];
    UINavigationController *indexNav = [[UINavigationController alloc] initWithRootViewController:index];
    
    GuangController *guang = [[GuangController alloc] init];
    UINavigationController *guangNav = [[UINavigationController alloc] initWithRootViewController:guang];
    
    NewController *new = [[NewController alloc] init];
    UINavigationController *newNav = [[UINavigationController alloc] initWithRootViewController:new];
    
    AboutController *about = [[AboutController alloc] init];
    UINavigationController *aboutNav = [[UINavigationController alloc] initWithRootViewController:about];
    
    // 添加视图
    _customTabBarArrays = @[indexNav, guangNav, newNav, aboutNav];
    [self setViewControllers:_customTabBarArrays animated:YES];
}


# pragma mark 自定义Tabbar文字和位置
- (void) loadCustomTabBarViewControllers
{
    // 隐藏系统自带tabBar
    self.tabBar.hidden = YES;
    
    // 自定义TabBar位置，兼容iphone5，不兼容通话模式
    if (iPhone5) {
        customTabBarImageView = [[UIView alloc] initWithFrame:CGRectMake(0, 519, 320, customTabBarViewHeight)];
    } else {
        customTabBarImageView = [[UIView alloc] initWithFrame:CGRectMake(0, 431, 320, customTabBarViewHeight)];
    }
    
    // 添加可点击的事件
    [customTabBarImageView setBackgroundColor:[UIColor whiteColor]];
    customTabBarImageView.userInteractionEnabled = YES;
    
    // 按钮偏移
    CGFloat tabBarViewCoordinate= 0;
    
    // tabBar名称
    tabBarItems = @[@"首页", @"值得逛", @"最新", @"关于我们"];
    
    // 添加四个TabBar
    int tag = 1;
    for (int i = 0; i < tabBarItems.count; i++) {
        // 添加外边框视图，为了让文字和图片居中，宽度80，高度49，Tabbar高度
        UIView *tabBarView = [[UIView alloc] initWithFrame:CGRectMake(tabBarViewCoordinate, 0, customTabBarViewWidth, customTabBarViewHeight)];
        [tabBarView setBackgroundColor:[UIColor whiteColor]]; // 背景颜色
        tabBarViewCoordinate += customTabBarViewWidth; // 每次偏移80
        
        // 设置图片位置，以及图片大小
        // 添加自定义tabBar按钮，并加上点击事件
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [button setTag:tag];
        [button setFrame:CGRectMake(customTabBarViewWidth/2 -  30/2, 3, 30, 30)];
        [button addTarget:self action:@selector(clickTabBar:) forControlEvents:UIControlEventTouchUpInside];
        
        // 添加TabBar图片，默认图片，高亮后的图片
        // 设置图片大小30*30
        NSString *buttonImage = [NSString stringWithFormat:@"tabbar_button_%d", i];
        NSString *buttonHightlightImage = [NSString stringWithFormat:@"tabbar_button_hightlight_%d", i];
        UIImageView *buttonView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:buttonImage] highlightedImage:[UIImage imageNamed:buttonHightlightImage]];
        [buttonView setTag:1001 + tag];
        [buttonView setFrame:CGRectMake(0, 0, 30, 30)];
        
        // 给tabBar添加文字介绍
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 35 , customTabBarViewWidth, 8)];
        [label setTag:2001 + tag];
        [label setFont:[UIFont fontWithName:@"Helvetica" size:11.0]];
        [label setText:[tabBarItems objectAtIndex:i]];
        [label setTextAlignment:NSTextAlignmentCenter];
        [label setTextColor:[UIColor grayColor]];
        
        // 添加到UITabBarController中
        [button addSubview:buttonView];
        [tabBarView addSubview:button];
        [tabBarView addSubview:label];
        [customTabBarImageView addSubview:tabBarView];
        
        // tag增加
        tag += 1;
    }
    
    
    
    [self.view addSubview:customTabBarImageView];
    [self setHightlightTabbar];
}


- (void) setHightlightTabbar
{
    int tag = 1;
    // 清空图片
    UIImageView *image = ((UIImageView *)[self.view viewWithTag:1001 + tag]);
    [image setHighlighted:YES];
    
    // 修改文字颜色
    UILabel *label = ((UILabel *)[self.view viewWithTag:2001 + tag]);
    [label setTextColor:[UIColor redColor]];
    
}


- (void) showTabBar
{
    customTabBarImageView.hidden = NO;
}


- (void) hideTabBar
{
    customTabBarImageView.hidden = YES;
}


# pragma mark 点击TabBar效果
- (void) clickTabBar:(UIButton *)button
{
    // 选中选项卡
    self.selectedIndex = button.tag - 1;
    
    // 清空所有选项
    int tag = 1;
    for (int i = 0; i < tabBarItems.count; i++) {
        // 清空图片
        UIImageView *image = ((UIImageView *)[self.view viewWithTag:1001 + tag]);
        [image setHighlighted:NO];
        
        // 清空label
        UILabel *label = ((UILabel *)[self.view viewWithTag:2001 + tag]);
        [label setTextColor:[UIColor grayColor]];
        
        // Tag增加
        tag += 1;
    }
    
    // 清空图片
    UIImageView *image = ((UIImageView *)[self.view viewWithTag:1001 + button.tag]);
    [image setHighlighted:YES];
    
    // 修改文字颜色
    UILabel *label = ((UILabel *)[self.view viewWithTag:2001 + button.tag]);
    [label setTextColor:[UIColor redColor]];
}





@end
