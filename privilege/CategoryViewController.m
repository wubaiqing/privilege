//
//  CategoryViewController.m
//  privilege
//
//  Created by 吴佰清 on 14-10-17.
//  Copyright (c) 2014年 吴佰清. All rights reserved.
//

#import "CategoryViewController.h"
#import "IndexController.h"
#import "RenderTabBarViewController.h"
#import "CategoryDetailViewController.h"

@interface CategoryViewController ()

@end

@implementation CategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 自定义标题
    [self customTitle];
    
    RenderTabBarViewController *tabBarController= (RenderTabBarViewController *)self.tabBarController;
    [tabBarController hideTabBar];
    
    
    self.listArray = @[@"男装", @"女装", @"居家", @"美食", @"化妆品", @"母婴", @"配饰", @"数码周边", @"文体", @"鞋包"];
    _tableView = [[UITableView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame] style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    self.view = _tableView;
}



#pragma mark - TableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.listArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    NSString *fontName = _listArray[indexPath.row];
    cell.textLabel.text = fontName;
    cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:14];
    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"cat_%d", (int)indexPath.row]];
    return cell;
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

- (void) viewWillAppear:(BOOL)animated
{
    RenderTabBarViewController *tabBarController= (RenderTabBarViewController *)self.tabBarController;
    [tabBarController hideTabBar];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CategoryDetailViewController *categoryDetail = [[CategoryDetailViewController alloc] init];
    NSString *catId = [NSString stringWithFormat:@"10%d", (int) indexPath.row];
    categoryDetail.type = [NSString stringWithFormat:@"%d", [catId intValue]];
    categoryDetail.catId = [catId intValue];
    [self.navigationController pushViewController:categoryDetail animated:NO];
    
}

@end
