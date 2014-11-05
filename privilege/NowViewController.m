//
//  NowViewController.m
//  privilege
//
//  Created by 吴佰清 on 14-10-16.
//  Copyright (c) 2014年 吴佰清. All rights reserved.
//

#import "NowViewController.h"
#import "AFNetworking.h"
#import "Goods.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"

// cellId
static NSString *cellIdentifier = @"newCellIdentifier";

// 首页URL
static NSString *HttpIndexUrl = @"http://www.meipin.com/api/iphonenew/page/";




@interface NowViewController ()
{
    UICollectionViewCell *cell;
}

@property (nonatomic, strong) NSMutableArray *goodsLists;
@property (nonatomic, assign) NSInteger page;

@end


@implementation NowViewController

- (void)viewDidLoad
{
    [super loadView];
    
    // 设置标题
    self.title = @"最新";
    
    [self setupCollectionView];
    
    _page = (int)1;
    
    // 获取数据
    [self getIndexData:(int)_page isRefreing:0];
    
    
}

- (id) init
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(140, 180);
    layout.sectionInset = UIEdgeInsetsMake(10.0, 10.0, 10.0, 10.0);
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
    
    UIImageView *images = (UIImageView *)[cell viewWithTag:10010];
    NSLog(@"%@", images);
    
    //设置图片边
    images.layer.borderColor = [UIColor colorWithRed:197.0/255.0 green:197.0/255.0 blue:197.0/255.0 alpha:1.0].CGColor;
    images.layer.borderWidth = 0.5;
    
    //取到某一个商品
    //    [images setImage:[UIImage imageNamed:[NSString stringWithFormat:@"guang_%d", (int)indexPath.row]]];
    [images setImage:[UIImage imageNamed:@"test"]];
    
    return cell;
}

/**
 * 每行数据点击
 */
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"click");
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


@end
