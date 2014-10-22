//
//  RootViewController.m
//  privilege
//
//  Created by 吴佰清 on 14-10-13.
//  Copyright (c) 2014年 吴佰清. All rights reserved.
//

#import "IndexViewController.h"
#import "CategoryViewController.h"
#import "AFNetworking.h"

@interface IndexViewController ()
{
    @private
    UIScrollView *scrollView;
    
    // 整体布局的头部
    UIView *HEAD;
    
    // 整体布局的内容
    UIView *BODY;
}

@end

@implementation IndexViewController

- (void) loadView
{
    // 设置Title
    [self customTitle];
    
    // 创建基本视图
    [self createScrollView];
    
    [self loadHEAD];
    
    [self loadBody];
    
    // 载入视图
    self.view = scrollView;
}

- (void) loadBody
{
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    [manager GET:@"http://www.meipin.com/api/iphone" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        
//                NSString *JSONString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//                        NSLog(@"success:%@", JSONString);
//        NSLog(@"%@", JSONString);
//        
////        NSLog(@"JSON: %@", responseObject);
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"Error: %@", error);
//    }];

}

- (void) loadHEAD
{
    HEAD = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 260)];
    
    [self loadCategory];
    [self loadBanner];
    
    [scrollView addSubview:HEAD];
}



- (void) loadBanner
{
    UIView *buttonView = [[UIView alloc] initWithFrame:CGRectMake(320 / 2 - 310 /2, 75, 310, 185)];
    
    CGFloat doordinateWidth = 0;
    CGFloat doordinateHeight = 0;
    CGFloat width = 153;
    
    
    for (int i = 0; i < 4; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        button.tag = i;
        [button setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"top_banner_%d", i]] forState:UIControlStateNormal];
        [button setBackgroundColor:[UIColor whiteColor]];
        
        
        [button setFrame:CGRectMake(doordinateWidth, doordinateHeight, width, 90)];
        if (i % 2 == 0) {
            doordinateWidth += width + 3;
        } else {
            doordinateWidth = 0;
            doordinateHeight += 90 + 2;
            
        }
        
        
        
        [button addTarget:self action:@selector(clickBanner:) forControlEvents:UIControlEventTouchUpInside];
        
        [buttonView addSubview:button];
    }
    
    [scrollView addSubview:buttonView];
}


- (void) clickBanner:(UIButton *)button
{
    
}


- (void) loadCategory
{
    UIView *buttonView = [[UIView alloc] initWithFrame:CGRectMake(320 / 2-310 /2, 5, 310, 65)];
    
    CGFloat doordinate = 0;
    NSArray *array = @[@"女装", @"居家", @"母婴", @"更多"];
    
    // 分类
    for (int i = 0; i < 4; i++) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(doordinate , 0, 77, 65)];
        [view setBackgroundColor:[UIColor whiteColor]];
        doordinate += 77.5;
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [button setFrame:CGRectMake(77.5/2 - 40 / 2, 5, 40, 40)];
        [button setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"root_top_button_%d", i]] forState:UIControlStateNormal];
        [view addSubview:button];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, 77, 10)];
        label.text = [array objectAtIndex:i];
        label.textAlignment = NSTextAlignmentCenter;
        [label setFont:[UIFont fontWithName:@"Helvetica" size:12.0]];
        [view addSubview:label];
        
        [buttonView addSubview:view];
    }
    
    
    [HEAD addSubview:buttonView];
    
}

// 设置视图大小，以及背景颜色
- (void) createScrollView
{
    // 创建视图
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 400)];
    scrollView.backgroundColor = [UIColor colorWithRed:232/255.0 green:232/255.0 blue:232/255.0 alpha:1];
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    scrollView.contentSize = CGSizeMake(320, 1000);
}



- (void) customTitle
{
    // 设置NavigationBar的透明度
    self.navigationController.navigationBar.translucent = YES;
    
    // 设置标题
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo"]];
    [imageView setFrame:CGRectMake(0, 0, 100, 35)];
    
    self.navigationItem.titleView = imageView;
    
    // 导航右侧切换分类
    UIButton *category = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [category setBackgroundImage:[UIImage imageNamed:@"category"] forState:UIControlStateNormal];
    [category setFrame:CGRectMake(0, 0, 20, 20)];
    [category addTarget:self action:@selector(changeCategory) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:category];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    // 从NavgationBar开始算坐标
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
}

- (void) changeCategory
{
    CategoryViewController *category = [[CategoryViewController alloc] init];
    [self.navigationController pushViewController:category animated:YES];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}


@end
