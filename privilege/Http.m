//
//  Http.m
//  privilege
//
//  Created by 吴佰清 on 14/12/30.
//  Copyright (c) 2014年 吴佰清. All rights reserved.
//

#import "Http.h"

// 网络请求
#import "AFNetworking.h"

// 商品Model
#import "Goods.h"

// 下拉刷新
#import "MJRefresh.h"

// 每页显示商品数量
#define LIMIT 20

@implementation Http

+ (void) httpRequest:(NSString *)requestUrl collctionView:(UICollectionView *)collectionView currentPage:(int)page isRefreing:(int)isRefre
{
    // 设置URL
    NSString *url = [NSString stringWithFormat:@"%@%d", requestUrl, page];
    NSLog(@"%@", collectionView);
    
    // 请求网络
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *jsonData = responseObject[@"data"];
        NSMutableArray *goodsLists = [[NSMutableArray alloc] init];
        
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
                [goodsLists addObject:goods];
            }
            
            [collectionView reloadData];
            if (isRefre > 0) {
                if (isRefre == 1) {
                    [collectionView headerEndRefreshing];
                } else {
                    [collectionView footerEndRefreshing];
                }
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        NSLog(@"错了");
    }];
}


@end
