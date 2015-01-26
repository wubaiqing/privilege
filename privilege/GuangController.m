//
//  CategoryViewController.m
//  privilege
//
//  Created by 吴佰清 on 14-10-13.
//  Copyright (c) 2014年 吴佰清. All rights reserved.
//

#import "GuangController.h"
#import "ToolsController.h"
#import "CatDetailController.h"

static NSString *cellIdentifier = @"guangCellIdentifier";

@interface GuangController ()

@property (nonatomic, strong) NSArray *categoryLists;

@end

@implementation GuangController

- (id) init
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(100, 130);
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
    [self.collectionView registerNib:[UINib nibWithNibName:@"Guang" bundle:nil] forCellWithReuseIdentifier:cellIdentifier];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置标题
    self.title = @"值得逛";
    
    // 设置tabBar按钮样式
    UITabBarItem *tabBar = [[UITabBarItem alloc] initWithTitle:@"值得逛" image:[UIImage imageNamed:@"shop-red"] tag:2];
    self.tabBarItem = tabBar;
    
    _categoryLists = @[@"男装", @"女装", @"居家", @"美食", @"化妆品", @"母婴", @"配饰", @"数码周边", @"文体", @"鞋包"];
    
    // 初始化collectionView
    [self setupCollectionView];
 
    
}

/**
 * 有多少个数据
 */
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _categoryLists.count;
}

/**
 * 每行数据展示
 */
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    cell.contentView.layer.borderColor = [UIColor whiteColor].CGColor;
    cell.contentView.layer.borderWidth = 0.5;
    cell.contentView.backgroundColor = [UIColor whiteColor];
    
    UIImageView *images = (UIImageView *)[cell viewWithTag:10010];
    
    //设置图片边
    images.layer.borderColor = [UIColor colorWithRed:197.0/255.0 green:197.0/255.0 blue:197.0/255.0 alpha:1.0].CGColor;
    images.layer.borderWidth = 0.5;
    
    //取到某一个商品
    [images setImage:[UIImage imageNamed:[NSString stringWithFormat:@"guang_%d", (int)indexPath.row]]];
    
    return cell;
}

/**
 * 每行数据点击
 */
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    CatDetailController *categoryDetail = [[CatDetailController alloc] init];
    NSString *catId = [NSString stringWithFormat:@"10%d", (int) indexPath.row];
    categoryDetail.type = [NSString stringWithFormat:@"%d", [catId intValue]];
    categoryDetail.catId = [catId intValue];
    [self.navigationController pushViewController:categoryDetail animated:NO];
    
}


- (void) viewWillAppear:(BOOL)animated
{
    ToolsController *tabBarController= (ToolsController *)self.tabBarController;
    [tabBarController showTools];
}


@end
