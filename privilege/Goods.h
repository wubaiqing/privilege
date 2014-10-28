//
//  goodInfo.h
//  dianshang
//
//  Created by zhangyajun on 14-6-23.
//  Copyright (c) 2014年 Mis.zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Goods : NSObject

@property (nonatomic, copy) NSString *tbId;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *catId;
@property (nonatomic, copy) NSString *imageUrl;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *originPrice;
@property (nonatomic, copy) NSString *clickUrl;

@end
