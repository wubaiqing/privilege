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
    
    // 自定义标题
    [self customTitle];
    
    // 创建视图
    UIView *indexView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    indexView.backgroundColor = [UIColor colorWithRed:232/255.0 green:232/255.0 blue:232/255.0 alpha:1];
    
    
    self.listArray = @[@"女装", @"居家", @"美食", @"母婴", @"配饰", @"数码", @"男装", @"女鞋", @"文体"];
    
    
    _tableView = [[UITableView alloc] initWithFrame:indexView.frame style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 70;
    _tableView.separatorColor = [UIColor grayColor];
    
    _tableView.backgroundColor = [UIColor yellowColor];
    
//    [_tableView.tableHeaderView removeFromSuperview];
//    [_tableView.tableFooterView removeFromSuperview];
    
    
    
    [indexView addSubview:_tableView];
    
    self.view = indexView;
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
