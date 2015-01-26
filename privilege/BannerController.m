//
//  NowViewController.m
//  privilege
//
//  Created by 吴佰清 on 14-10-16.
//  Copyright (c) 2014年 吴佰清. All rights reserved.
//

#import "BannerController.h"
#import "AFNetworking.h"
#import "Goods.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"
#import "ToolsController.h"
#import "DetailController.h"


#define LIMIT 20

// cellId
static NSString *cellIdentifier = @"bannerCellIdentifier";

// 首页URL
static NSString *HttpIndexUrl;


@interface BannerController ()
{
    UICollectionViewCell *cell;
}

@property (nonatomic, strong) NSMutableArray *goodsLists;
@property (nonatomic, assign) NSInteger page;

@end


@implementation BannerController

- (void)viewDidLoad
{
    [super loadView];
    
    // 设置标题
    if ([_bannerId intValue] == 50) {
        self.title = @"9.9包邮专区";
        HttpIndexUrl = @"http://www.jtzdm.com/api/Iphone/type/9/page/";
    } else if ([_bannerId intValue] == 51) {
        self.title = @"20元封顶";
        HttpIndexUrl = @"http://www.jtzdm.com/api/Iphone/type/20/page/";
    } else if ([_bannerId intValue] == 52) {
        self.title = @"达人精选";
        HttpIndexUrl = @"http://www.jtzdm.com/api/Iphone/page/";
    } else {
        self.title = @"最新更新";
        HttpIndexUrl = @"http://www.jtzdm.com/api/Iphone/search/new/page/";
    }
    
    ToolsController *tabBarController= (ToolsController *)self.tabBarController;
    [tabBarController hiddenTools];
    
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
    [self.navigationController popToRootViewControllerAnimated:YES];
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
    DetailController *detail = [[DetailController alloc] init];
    detail.goodsUrl = goods.clickUrl;
    [self.navigationController pushViewController:detail animated:NO];
}


/**
 * 获取网络数据
 */
- (void) getIndexData:(int) page isRefreing:(int) isRefre
{
    // 设置URL
    NSString *url = [NSString stringWithFormat:@"%@%d", HttpIndexUrl, page];
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

@end
