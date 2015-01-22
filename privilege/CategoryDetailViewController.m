//
//  NowViewController.m
//  privilege
//
//  Created by 吴佰清 on 14-10-16.
//  Copyright (c) 2014年 吴佰清. All rights reserved.
//

#import "CategoryDetailViewController.h"
#import "AFNetworking.h"
#import "Goods.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"
#import "RenderTabBarViewController.h"
#import "DetailViewController.h"


#define LIMIT 20

// cellId
static NSString *cellIdentifier = @"categoryDetailCellIdentifier";

// 首页URL
static NSString *HttpIndexUrl = @"http://www.jtzdm.com/api/iphone/page/";


@interface CategoryDetailViewController ()
{
    UICollectionViewCell *cell;
}

@property (nonatomic, strong) NSMutableArray *goodsLists;
@property (nonatomic, assign) NSInteger page;

@end


@implementation CategoryDetailViewController

- (id) realId
{
    NSDictionary *dics = [NSDictionary dictionaryWithObjectsAndKeys:@"4", @"100", @"1", @"101", @"5", @"102", @"9", @"103", @"11", @"104", @"6", @"105", @"8", @"106", @"10", @"107", @"12", @"108", @"7", @"109", nil];
    
    return [dics objectForKey:[NSString stringWithFormat:@"%d", [_type intValue]]];
}



- (void)viewDidLoad
{
    [super loadView];
    
    RenderTabBarViewController *tabBarController= (RenderTabBarViewController *)self.tabBarController;
    [tabBarController hideTabBar];
    
    NSDictionary *dics = [NSDictionary dictionaryWithObjectsAndKeys:@"男装", @"100", @"女装", @"101", @"居家", @"102", @"美食", @"103", @"化妆品", @"104", @"母婴", @"105", @"配饰", @"106", @"数码周边", @"107", @"文体", @"108", @"鞋包", @"109", nil];
    
    self.title = [dics objectForKey:[NSString stringWithFormat:@"%d", _catId]];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [backButton setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backButton setFrame:CGRectMake(0, 0, 20, 20)];
    [backButton addTarget:self action:@selector(returnRootView) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = barButton;
    
    [self setupCollectionView];
    
    _page = (int)1;
    
    // 获取数据
    [self getIndexData:(int)_page isRefreing:0];
    
    
    // 刷新控件
    [self headerRefresh];
    
    [self footerRedresh];
    
    
}

- (void) returnRootView
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (id) init
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(152.5, 200);
    layout.sectionInset = UIEdgeInsetsMake(5.0, 5.0, 5.0, 5.0);
    layout.minimumInteritemSpacing = 5.0;
    layout.minimumLineSpacing = 5.0;
    return [self initWithCollectionViewLayout:layout];
}

- (void) setupCollectionView
{
    self.collectionView.backgroundColor = [UIColor colorWithRed:232/255.0 green:232/255.0 blue:232/255.0 alpha:1];
    self.collectionView.alwaysBounceHorizontal = NO;
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellIdentifier];
    [self.collectionView registerNib:[UINib nibWithNibName:@"Goods" bundle:nil] forCellWithReuseIdentifier:cellIdentifier];
}


/**
 * 有多少个数据
 */
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _goodsLists.count;
}

/**
 * 每行数据展示
 */
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    cell.contentView.layer.borderColor = [UIColor whiteColor].CGColor;
    cell.contentView.layer.borderWidth = 0.5;
    cell.contentView.backgroundColor = [UIColor whiteColor];
    
    UIImageView *images = (UIImageView *)[cell viewWithTag:10001];
    UILabel *nowpriceLabel = (UILabel *)[cell viewWithTag:10002];
    UILabel *originpriceLabel = (UILabel *)[cell viewWithTag:10003];
    UILabel *titleLabel = (UILabel *)[cell viewWithTag:10004];
    
    //设置图片边
    images.layer.borderColor = [UIColor colorWithRed:197.0/255.0 green:197.0/255.0 blue:197.0/255.0 alpha:1.0].CGColor;
    images.layer.borderWidth = 0.5;
    
    
    Goods *tmp = [_goodsLists objectAtIndex:indexPath.row];
    [images sd_setImageWithURL:[NSURL URLWithString:tmp.imageUrl] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    nowpriceLabel.text = tmp.price;
    originpriceLabel.text = [NSString stringWithFormat:@"￥%@", tmp.originPrice];
    titleLabel.text = tmp.title;
    
    return cell;
}

/**
 * 每行数据点击
 */
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    Goods *goods = [_goodsLists objectAtIndex:indexPath.row];
    DetailViewController *detail = [[DetailViewController alloc] init];
    detail.goodsUrl = goods.clickUrl;
    [self.navigationController pushViewController:detail animated:NO];
}


/**
 * 获取网络数据
 */
- (void) getIndexData:(int) page isRefreing:(int) isRefre
{
   
    NSString *catId = [self realId];
    
    // 设置URL
    NSString *url = [NSString stringWithFormat:@"%@%d/catId/%d", HttpIndexUrl, page, [catId intValue]];
    
    // 请求网络
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *jsonData = responseObject[@"data"];
        _goodsLists = [[NSMutableArray alloc] init];
        
        if (jsonData.count > 0) {
            for (int i = 0; i < jsonData.count; i++) {
                NSDictionary *listDic = [jsonData objectAtIndex:i];
                // 设置Model
                Goods *goods = [[Goods alloc] init];
                goods.tbId = listDic[@"tbId"];
                goods.title = listDic[@"title"];
                goods.catId = listDic[@"catId"];
                goods.clickUrl = listDic[@"click_url"];
                goods.price = listDic[@"price"];
                goods.originPrice = listDic[@"originPrice"];
                goods.imageUrl = listDic[@"image"];
                [_goodsLists addObject:goods];
            }
            
            [self.collectionView reloadData];
            if (isRefre > 0) {
                if (isRefre == 1) {
                    [self.collectionView headerEndRefreshing];
                } else {
                    [self.collectionView footerEndRefreshing];
                }
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        NSLog(@"错了");
    }];
}


/**
 * 上拉刷新
 */
- (void)headerRefresh
{
    __unsafe_unretained typeof(self) vc = self;
    
    [self.collectionView addHeaderWithCallback:^{
        if (vc.page < LIMIT) {
            [vc getIndexData:(int)vc.page isRefreing:1];
            vc.page++;
        } else {
            [vc.collectionView headerEndRefreshing];
        }
    } dateKey:@"collection"];
}

/**
 * 下拉刷新
 */
- (void)footerRedresh
{
    __unsafe_unretained typeof(self) vc = self;
    
    // 添加上拉刷新尾部控件
    [self.collectionView addFooterWithCallback:^{
        if (vc.page < LIMIT) {
            [vc getIndexData:(int)vc.page isRefreing:2];
            vc.page++;
        } else {
            [vc.collectionView footerEndRefreshing];
        }
    }];
}

- (void) viewWillAppear:(BOOL)animated
{
    RenderTabBarViewController *tabBarController= (RenderTabBarViewController *)self.tabBarController;
    [tabBarController hideTabBar];
}

@end
