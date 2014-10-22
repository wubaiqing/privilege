//
//  CategoryViewController.m
//  privilege
//
//  Created by 吴佰清 on 14-10-13.
//  Copyright (c) 2014年 吴佰清. All rights reserved.
//

#import "GuangViewController.h"

@interface GuangViewController ()

@end

@implementation GuangViewController

+ (void) init
{
    
}

- (void) loadView
{
    // 设置标题
    self.title = @"值得逛";
    
    // 创建视图
    UIView *guangView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    guangView.backgroundColor = [UIColor colorWithRed:232/255.0 green:232/255.0 blue:232/255.0 alpha:1];
    
    // 设置tabBar按钮样式
    UITabBarItem *tabBar = [[UITabBarItem alloc] initWithTitle:@"值得逛" image:[UIImage imageNamed:@"shop-red"] tag:2];
    self.tabBarItem = tabBar;

    
    // 载入视图
    self.view = guangView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
