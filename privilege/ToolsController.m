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
    UIView *toolsView;
    
    // 工具栏数量
    NSArray *toolsItems;
}
@end

@implementation ToolsController

// 视图载入后执行
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 载入所有导航控制器
    [self loadNav];
    
    // 载入所有自定义tabBar
    [self loadTools];
}

// 设置：首页、值得逛、最新、关于我们页面
- (void) loadNav
{
    // 设置导航栏颜色
    [UINavigationBar appearance].tintColor = [UIColor whiteColor];
    
    // 首页
    IndexController *index = [[IndexController alloc] init];
    UINavigationController *indexNav = [[UINavigationController alloc] initWithRootViewController:index];
    
    // 值得逛
    GuangController *guang = [[GuangController alloc] init];
    UINavigationController *guangNav = [[UINavigationController alloc] initWithRootViewController:guang];
    
    // 最新
    NewController *new = [[NewController alloc] init];
    UINavigationController *newNav = [[UINavigationController alloc] initWithRootViewController:new];
    
    // 关于我们
    AboutController *about = [[AboutController alloc] init];
    UINavigationController *aboutNav = [[UINavigationController alloc] initWithRootViewController:about];
    
    // 添加视图
    _customTabBarArrays = @[indexNav, guangNav, newNav, aboutNav];
    [self setViewControllers:_customTabBarArrays animated:YES];
}


// 自定义工具栏
- (void) loadTools
{
    // 隐藏系统工具栏
    self.tabBar.hidden = YES;
    
    // 自定义TabBar位置，兼容iphone5，不兼容通话模式
    if (iPhone5) {
        toolsView = [[UIView alloc] initWithFrame:CGRectMake(0, 519, 320, toolsHeight)];
    } else {
        toolsView = [[UIView alloc] initWithFrame:CGRectMake(0, 431, 320, toolsHeight)];
    }
    
    [toolsView setBackgroundColor:[UIColor whiteColor]];
    
    // 可点击的事件
    toolsView.userInteractionEnabled = YES;
    
    // 按钮偏移
    CGFloat toolsCoordinate= 0;
    
    // 工具栏名称
    toolsItems = @[@"首页", @"值得逛", @"最新", @"关于我们"];
    
    // 添加四个工具栏
    int tag = 1;
    for (int i = 0; i < toolsItems.count; i++) {
        
        // 添加工具栏按钮
        UIButton *itemTools = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [itemTools setTag:tag];
        [itemTools setFrame:CGRectMake(toolsCoordinate, 0, toolsWidth, toolsHeight)];
        [itemTools addTarget:self action:@selector(clickTools:) forControlEvents:UIControlEventTouchUpInside];
        [itemTools setBackgroundColor:[UIColor whiteColor]];
        
        // 每次偏移80
        toolsCoordinate += toolsWidth;
        
        // 添加图片，默认图片，高亮后的图片
        NSString *image = [NSString stringWithFormat:@"tabbar_button_%d", i];
        NSString *HightlightImage = [NSString stringWithFormat:@"tabbar_button_hightlight_%d", i];
        UIImageView *toolsImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:image] highlightedImage:[UIImage imageNamed:HightlightImage]];
        [toolsImage setTag:1001 + tag];
        [toolsImage setFrame:CGRectMake(toolsWidth/2 - 30 / 2, 5, 30, 30)];
        
        // 给tabBar添加文字介绍
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 35 , toolsWidth, 10)];
        [label setTag:2001 + tag];
        [label setFont:[UIFont fontWithName:@"Helvetica" size:11.0]];
        [label setText:[toolsItems objectAtIndex:i]];
        [label setTextAlignment:NSTextAlignmentCenter];
        [label setTextColor:[UIColor grayColor]];
        
        // 添加到UITabBarController中
        [itemTools addSubview:toolsImage];
        [itemTools addSubview:label];
        [toolsView addSubview:itemTools];
        
        // tag增加
        tag += 1;
    }
    
    
    [self.view addSubview:toolsView];
    [self setHightlight];
}

// 默认第一个按钮为高亮
- (void) setHightlight
{
    int tag = 1;
    
    // 清空图片
    UIImageView *image = ((UIImageView *)[self.view viewWithTag:1001 + tag]);
    [image setHighlighted:YES];
    
    // 修改文字颜色
    UILabel *label = ((UILabel *)[self.view viewWithTag:2001 + tag]);
    [label setTextColor:[UIColor redColor]];
}

// 显示工具栏
- (void) showTools
{
    toolsView.hidden = NO;
}

// 显示工具栏
- (void) hiddenTools
{
    toolsView.hidden = YES;
}

// 点击工具栏
- (void) clickTools:(UIButton *)button
{
    // 选中选项卡
    self.selectedIndex = button.tag - 1;
    
    // 清空所有选项
    int tag = 1;
    for (int i = 0; i < toolsItems.count; i++) {
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
