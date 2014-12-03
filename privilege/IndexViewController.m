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
#import "DetailViewController.h"
#import "RenderTabBarViewController.h"
#import "BannerViewController.h"
#import "CategoryDetailViewController.h"


#define LIMIT 20

// 设置cell唯一标示
static NSString *headerIdentifier = @"HeaderCellIdentifier";
static NSString *cellIdentifier = @"CellIdentifier";

// 首页URL
static NSString *HttpIndexUrl = @"http://www.meipin.com/api/iphone/page/";

/**
 * 全局属性
 */
@interface IndexViewController ()
{
    UICollectionReusableView *HEAD;
    UICollectionViewCell *cell;
}

@property (nonatomic, strong) NSMutableArray *goodsLists;
@property (nonatomic, assign) NSInteger page;


@end


#pragma mark 设置私有方法
@implementation IndexViewController

/**
 *  初始化Layout
 */
- (id)init
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(152.5, 155);
    layout.sectionInset = UIEdgeInsetsMake(5.0, 5.0, 5.0, 5.0);
    layout.minimumInteritemSpacing = 5.0;
    layout.minimumLineSpacing = 5.0;
    return [self initWithCollectionViewLayout:layout];
}


/**
 * 初始化视图调用
 */
- (void) viewDidLoad
{
    [super viewDidLoad];
    
    _page = (int)1;
    
    // 获取数据
    [self getIndexData:(int)_page isRefreing:0];
    
    // 加载头部
    [self customTitle];
    
    // 初始化collectionView
    [self setupCollectionView];
    
    // 刷新控件
    [self headerRefresh];
    [self footerRedresh];
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
 * 自定义标题
 */
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
    [category addTarget:self action:@selector(clickCategory) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:category];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    // 从NavgationBar开始算坐标
    self.edgesForExtendedLayout = UIRectEdgeNone;
}

/**
 * 点击分类
 */
- (void) clickCategory
{
    CategoryViewController *category = [[CategoryViewController alloc] init];
    [self.navigationController pushViewController:category animated:YES];
}


/**
 * 初始化collectionView
 */
- (void) setupCollectionView
{
    self.collectionView.backgroundColor = [UIColor colorWithRed:232/255.0 green:232/255.0 blue:232/255.0 alpha:1];
    self.collectionView.alwaysBounceHorizontal = NO;
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellIdentifier];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerIdentifier];
    [self.collectionView registerNib:[UINib nibWithNibName:@"Goods" bundle:nil] forCellWithReuseIdentifier:cellIdentifier];
}

/**
 * 头部区域宽度高度
 */
-(CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(320, 260);
}

/**
 * 设置首页头部区域
 */
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    HEAD = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerIdentifier forIndexPath:indexPath];
    
    // 载入头部部分
    [self loadHeadCategoryView];
    
    // 载入Banenr部分
    [self loadHeadBanner];
    
    return HEAD;
}

/**
 * 加载头部分类选项卡
 */
- (void) loadHeadCategoryView
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
        button.tag = 100 + i;
        [button setFrame:CGRectMake(77.5/2 - 40 / 2, 5, 40, 40)];
        [button setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"root_top_button_%d", i]] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(clickTopCategory:) forControlEvents:UIControlEventTouchUpInside];
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

/**
 * 点击标题
 */
- (void) clickTopCategory:(UIButton *) button
{
    int more = (int) button.tag;
    if (more == 103) {
        [self clickCategory];
    } else {
        CategoryDetailViewController *categoryDetail = [[CategoryDetailViewController alloc] init];
        categoryDetail.type = [NSString stringWithFormat:@"%d", more];
        [self.navigationController pushViewController:categoryDetail animated:NO];
    }
}

/**
 * 载入头部Banner部分
 */
- (void) loadHeadBanner
{
    UIView *buttonView = [[UIView alloc] initWithFrame:CGRectMake(320 / 2 - 310 /2, 75, 310, 185)];
    
    CGFloat doordinateWidth = 0;
    CGFloat doordinateHeight = 0;
    CGFloat width = 153;
    
    for (int i = 0; i < 4; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        button.tag = 50 + i;
        [button setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"top_banner_%d", i]] forState:UIControlStateNormal];
        [button setBackgroundColor:[UIColor whiteColor]];
        
        
        [button setFrame:CGRectMake(doordinateWidth, doordinateHeight, width, 90)];
        if (i % 2 == 0) {
            doordinateWidth += width + 3;
        } else {
            doordinateWidth = 0;
            doordinateHeight += 90 + 2;
        }
        
        [button addTarget:self action:@selector(clickTopBanner:) forControlEvents:UIControlEventTouchUpInside];
        
        [buttonView addSubview:button];
    }
    
    [HEAD addSubview:buttonView];
}

/**
 * 点击Banner
 */
- (void) clickTopBanner:(UIButton *)button
{
    BannerViewController *banner = [[BannerViewController alloc] init];
    banner.bannerId = [NSString stringWithFormat:@"%d", (int) button.tag];
    NSLog(@"%@", banner.bannerId);
    [self.navigationController pushViewController:banner animated:NO];
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
    
    //取到某一个商品
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
    [tabBarController showTabBar];
}

@end