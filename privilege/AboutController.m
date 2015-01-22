//
//  UserViewController.m
//  privilege
//
//  Created by 吴佰清 on 14-10-16.
//  Copyright (c) 2014年 吴佰清. All rights reserved.
//

#import "AboutController.h"

@interface AboutController ()

@end

@implementation AboutController


- (void)loadView
{
    [super loadView];
    
    // 设置标题
    self.title = @"关于我们";
    
    // 创建视图
    UIView *userCenter = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    userCenter.backgroundColor = [UIColor colorWithRed:243/255.0 green:243/255.0 blue:243/255.0 alpha:1];
    
    // 从navigationBar开始计算坐标
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    // 添加头部图片以及文字
    UIView *top = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 400)];
    
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(320 / 2 - 120 /2, 30, 120, 120)];
    [image setImage:[UIImage imageNamed:@"180-180.png"]];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(320/2 - 180/2 , 160, 180, 50)];
    [label setFont:[UIFont fontWithName:@"Helvetica-bold" size:18.0]];
    [label setText:@"省钱帮手"];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setTextColor:[UIColor blackColor]];
    
    UILabel *version = [[UILabel alloc] initWithFrame:CGRectMake(320/2 - 180/2 , 180, 180, 50)];
    [version setFont:[UIFont fontWithName:@"Helvetica" size:12.0]];
    [version setText:@"V0.0.1 (build 0.0.1)"];
    [version setTextAlignment:NSTextAlignmentCenter];
    [version setTextColor:[UIColor blackColor]];
    [top addSubview:version];
    
    [top addSubview:image];
    
    [top addSubview:label];
    
    
    UIView *button = [[UIView alloc] initWithFrame:CGRectMake(0, 140, 320, 80)];
    UILabel *qqLabel = [[UILabel alloc] initWithFrame:CGRectMake(320/2 - 160/2, 190, 160, 40)];
    [qqLabel setText:@"联系qq：534095228"];
    [qqLabel setFont:[UIFont fontWithName:@"Helvetica-blod" size:14.0]];
    [qqLabel setTextAlignment:NSTextAlignmentRight];
    
    [button addSubview:qqLabel];
    
    [userCenter addSubview:top];
    [userCenter addSubview:button];;

    // 载入视图
    self.view = userCenter;
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
