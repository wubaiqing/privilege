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


// 设置cell唯一标示
static NSString *headerIdentifier = @"HeaderCellIdentifier";
static NSString *cellIdentifier = @"CellIdentifier";

// 首页URL
static NSString *HttpIndexUrl = @"http://www.meipin.com/api/iphone";

/**
 * 全局属性
 */
@interface IndexViewController ()
{
    UICollectionReusableView *HEAD;
}

@property (nonatomic, strong) NSMutableArray *goodsLists;

@end


#pragma mark 设置私有方法
@implementation IndexViewController

/**
 *  初始化Layout
 */
- (id)init
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(150, 150);
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
    
    // 获取数据
    [self getData];
    
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
- (void) getData
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:HttpIndexUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSArray *listArray = responseObject[@"data"];
        
        for (int i = 0; i < listArray.count; i++) {
            NSDictionary *listDic = [listArray objectAtIndex:i];
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
    NSLog(@"click category");
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
    NSLog(@"test");
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
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    cell.contentView.layer.borderColor = [UIColor whiteColor].CGColor;
    cell.contentView.layer.borderWidth = 0.5;
    cell.contentView.layer.cornerRadius = 3.0f;
    cell.contentView.backgroundColor = [UIColor colorWithRed:232/255.0 green:232/255.0 blue:232/255.0 alpha:1];
    
//    UIImageView *images = (UIImageView *)[cell viewWithTag:10001];
//    UILabel *titleLabel = (UILabel *)[cell viewWithTag:10002];
//    UILabel *nowpriceLabel = (UILabel *)[cell viewWithTag:10003];
//    UILabel *originpriceLabel = (UILabel *)[cell viewWithTag:10004];
    
    //设置图片边
//    images.layer.borderColor = [UIColor colorWithRed:197.0/255.0 green:197.0/255.0 blue:197.0/255.0 alpha:1.0].CGColor;
//    images.layer.borderWidth = 0.5;
    
    //取到某一个商品
//    [images setImageWithURL:[NSURL URLWithString:@"http://www.baidu.com"]];
//    titleLabel.text = @"test";
//    nowpriceLabel.text = @"20.0";
//    originpriceLabel.text = [NSString stringWithFormat:@"￥%@", @"wubaiqing"];
    
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
 * 上拉刷新
 */
- (void)headerRefresh
{
    __unsafe_unretained typeof(self) vc = self;
    // 添加下拉刷新头部控件
    [self.collectionView addHeaderWithCallback:^{
        // 进入刷新状态就会回调这个Block
        
        // 增加5条假数据
        for (int i = 0; i<5; i++) {
        }
        
        // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [vc.collectionView reloadData];
            // 结束刷新
            [vc.collectionView headerEndRefreshing];
        });
    } dateKey:@"collection"];
    // dateKey用于存储刷新时间，也可以不传值，可以保证不同界面拥有不同的刷新时间
    
    [self.collectionView headerBeginRefreshing];
}

/**
 * 下拉刷新
 */
- (void)footerRedresh
{
    __unsafe_unretained typeof(self) vc = self;
    // 添加上拉刷新尾部控件
    [self.collectionView addFooterWithCallback:^{
        // 进入刷新状态就会回调这个Block
        
        // 增加5条假数据
        for (int i = 0; i<5; i++) {
        }
        
        // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [vc.collectionView reloadData];
            // 结束刷新
            [vc.collectionView footerEndRefreshing];
        });
    }];
}

@end