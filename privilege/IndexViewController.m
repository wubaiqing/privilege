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

//下拉刷新
#import "MJRefresh.h"


#pragma mark 生命私有属性
@interface IndexViewController ()
{
}
@end


#pragma mark 设置私有方法
@implementation IndexViewController

// 设置cell唯一标示
static NSString *cellIdentifier = @"CellIdentifier";


#pragma mark 载入视图
- (void) loadView
{
    // 载入内容
    [self loadIndex];
}



#pragma mark 主题内容
- (void) loadIndex
{
    // 创建视图
    UIView *indexView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    
    // 设置Laytous
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(150, 150);
    layout.sectionInset = UIEdgeInsetsMake(5.0, 5.0, 5.0, 5.0);
    layout.minimumInteritemSpacing = 5.0;
    layout.minimumLineSpacing = 5.0;
    
    // 设置商品
    collectionView = [[UICollectionView alloc] initWithFrame:indexView.frame collectionViewLayout:layout];
    UINib *cellNib = [UINib nibWithNibName:@"Goods" bundle:nil];
    [collectionView registerNib:cellNib forCellWithReuseIdentifier:cellIdentifier];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = [UIColor colorWithRed:243.0/255.0 green:243.0/255.0 blue:243.0/255.0 alpha:1.0];
    
    // 添加下拉刷新头部控件
    [collectionView addHeaderWithCallback:^{
            [collectionView reloadData];
            // 结束刷新
            [collectionView headerEndRefreshing];
    } dateKey:nil];
    
    // 添加下拉刷新头部控件
    [collectionView addFooterWithCallback:^{
            [collectionView reloadData];
            // 结束刷新
            [collectionView footerEndRefreshing];
    }];
    
    networkfileImage = [[UIImageView alloc] initWithFrame:CGRectMake(85.5, 110, 149, 101)];
    [networkfileImage setImage:[UIImage imageNamed:@"net_error.png"]];
    networkfileImage.hidden = YES;
    [indexView addSubview:networkfileImage];
    
    
    [indexView addSubview:collectionView];
    self.view = indexView;
    
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    cell.contentView.layer.borderColor = [UIColor colorWithRed:197.0/255.0 green:197.0/255.0 blue:197.0/255.0 alpha:1.0].CGColor;
    cell.contentView.layer.borderWidth = 0.5;
    cell.contentView.layer.cornerRadius = 3.0f;
    cell.contentView.clipsToBounds = YES;//父视图clipsToBounds设置为YES，则子视图超过父视图范围则子视图超出范围部分不能显示。
    cell.contentView.backgroundColor = [UIColor whiteColor];
    
    
    UIImageView *images = (UIImageView *)[cell viewWithTag:10001];
    UILabel *titleLabel = (UILabel *)[cell viewWithTag:10002];
    UILabel *nowpriceLabel = (UILabel *)[cell viewWithTag:10003];
    UILabel *originpriceLabel = (UILabel *)[cell viewWithTag:10004];
    
    //设置图片边
    images.layer.borderColor = [UIColor colorWithRed:197.0/255.0 green:197.0/255.0 blue:197.0/255.0 alpha:1.0].CGColor;
    images.layer.borderWidth = 0.5;
    
    //取到某一个商品
//    [images setImageWithURL:[NSURL URLWithString:@"http://www.baidu.com"]];
    titleLabel.text = @"test";
    nowpriceLabel.text = @"20.0";
    originpriceLabel.text = [NSString stringWithFormat:@"￥%@", @"wubaiqing"];
    
    return cell;
}

# pragma mark 有多少个Cell
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 20;
}

@end
