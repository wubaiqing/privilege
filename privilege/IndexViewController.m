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
#import "Goods.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"


#pragma mark 生命私有属性
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


#pragma mark 设置私有方法
@implementation IndexViewController

#pragma mark 载入视图
- (void) loadView
{
    // 设置Title
    [self customTitle];
    
    // 创建基本视图
    [self createScrollView];
    
    // 载入头部
    [self loadHEAD];
    
    // 载入内容
    [self loadBody];
    
    // 载入视图
    self.view = scrollView;
}

- (void) loadBody
{
    
    BODY = [[UIView alloc] init];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager GET:@"http://www.meipin.com/api/iphone" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSArray *listArray = responseObject[@"data"];
        
        int bodyHeight = ((listArray.count / 2) * 220);
        
        CGFloat coordinateX = 0;
        CGFloat coordinateY = 0;
        NSLog(@"test");
        
        for (int i = 1; i <= listArray.count; i++) {
            NSDictionary *listDic = [listArray objectAtIndex:i - 1];
            // 设置Model
            Goods *goods = [[Goods alloc] init];
            goods.tbId = listDic[@"tbId"];
            goods.title = listDic[@"title"];
            goods.catId = listDic[@"catId"];
            goods.clickUrl = listDic[@"click_url"];
            goods.price = listDic[@"price"];
            goods.originPrice = listDic[@"originPrice"];
            goods.imageUrl = listDic[@"image"];
            
            
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(coordinateX, coordinateY, 152.50, 150)];
            [view setBackgroundColor:[UIColor whiteColor]];
            [view.layer setBorderColor:[[UIColor blueColor] CGColor]];
            
            // 一行
            if (i % 2 == 0) {
                coordinateX += 152.50 + 5;
            } else {
                coordinateX = 0;
            }
            
            if (i % 3 == 0) {
                coordinateY += 150 + 5;
            }
            
            // 添加图片
            UIImageView *imageView = [[UIImageView alloc] init];
            [imageView sd_setImageWithURL:[NSURL URLWithString:goods.imageUrl] placeholderImage:[UIImage imageNamed:@"avatar-placeholder.png"] options:SDWebImageRefreshCached];
            [imageView setFrame:CGRectMake(0, 0, 152.50, 99.50)];
            [view addSubview:imageView];
            
            // 价格
            UILabel *price = [[UILabel alloc] initWithFrame:CGRectMake(8, 111, 54, 19)];
            price.text = [NSString stringWithFormat:@"￥%@", goods.price];
            price.textColor = [UIColor redColor];
            [price setFont:[UIFont fontWithName:@"Helvetica" size:14.0]];
            [view addSubview:price];
            
            // 原始价格
            UILabel *originPrice = [[UILabel alloc] initWithFrame:CGRectMake(120, 111, 32, 19)];
            originPrice.text = [NSString stringWithFormat:@"%@", goods.price];
            originPrice.textColor = [UIColor grayColor];
            [originPrice setFont:[UIFont fontWithName:@"Helvetica" size:11.0]];
            [view addSubview:originPrice];
            
            // 原始价格
            UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(8, 131, 140, 19)];
            title.text = [NSString stringWithFormat:@"%@", goods.title];
            title.textColor = [UIColor blackColor];
            [title setFont:[UIFont fontWithName:@"Helvetica" size:11.0]];
            [view addSubview:title];
            
            
            [BODY addSubview:view];
        }
        
        scrollView.contentSize = CGSizeMake(320, bodyHeight);
        [BODY setFrame:CGRectMake(320/2 - 310 /2, 265, 310, bodyHeight)];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
    [scrollView addSubview:BODY];
    
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


# pragma mark 点击banner
- (void) clickBanner:(UIButton *)button
{
    
}


# pragma mark 载入分类
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
    scrollView.pagingEnabled=NO;//是否自己动适应
    scrollView.delegate = self;
//    scrollView.maximumZoomScale=2.0;
//    scrollView.minimumZoomScale=0.5;
    scrollView.canCancelContentTouches=NO;
}


# pragma mark 设置自定义标题
- (void) customTitle
{
    // 设置NavigationBar的透明度
    self.navigationController.navigationBar.translucent = YES;
    
    // 设置标题
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo"]];
    [imageView setFrame:CGRectMake(0, 0, 100, 35)];
    
    // 添加logo
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

# pragma mark 切换分类
- (void) changeCategory
{
    CategoryViewController *category = [[CategoryViewController alloc] init];
    [self.navigationController pushViewController:category animated:YES];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
}


@end
