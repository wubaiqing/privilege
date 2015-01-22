//
//  DetailViewController.m
//  privilege
//
//  Created by 吴佰清 on 14/11/18.
//  Copyright (c) 2014年 吴佰清. All rights reserved.
//

#import "DetailViewController.h"
#import "TabBarController.h"

@implementation DetailViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    RenderTabBarViewController *tabBarController= (RenderTabBarViewController *)self.tabBarController;
    [tabBarController hideTabBar];
    
    [self customTitle];
    self.hidesBottomBarWhenPushed = YES;
    
    webView = [[UIWebView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    webView.delegate = self;
    
    [self.view addSubview:webView];
    
    //加载数据
    [self loadWebPageWithString:self.goodsUrl];
    
}

- (void)loadWebPageWithString:(NSString *)goodsUrl
{
    NSURL *url = [NSURL URLWithString:goodsUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
}

- (void) customTitle
{
    self.tabBarController.hidesBottomBarWhenPushed = YES;
    self.title = @"手机淘宝网";
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [backButton setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backButton setFrame:CGRectMake(0, 0, 20, 20)];
    [backButton addTarget:self action:@selector(returnRootView) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = barButton;
}

- (void) returnRootView
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
