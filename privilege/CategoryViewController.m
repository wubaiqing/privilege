//
//  CategoryViewController.m
//  privilege
//
//  Created by 吴佰清 on 14-10-17.
//  Copyright (c) 2014年 吴佰清. All rights reserved.
//

#import "CategoryViewController.h"
#import "IndexViewController.h"

@interface CategoryViewController ()

@end

@implementation CategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self customTitle];
    
    
    
    // 创建视图
    UIView *indexView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    indexView.backgroundColor = [UIColor colorWithRed:232/255.0 green:232/255.0 blue:232/255.0 alpha:1];
    
    self.view = indexView;
}

- (void) customTitle
{
    self.tabBarController.hidesBottomBarWhenPushed = YES;
    self.title = @"类别";
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [backButton setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backButton setFrame:CGRectMake(0, 0, 20, 20)];
    [backButton addTarget:self action:@selector(returnRootView) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = barButton;
}


- (void) returnRootView
{
    [self.navigationController popToRootViewControllerAnimated:YES];
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
