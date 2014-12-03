//
//  BannerViewController.h
//  privilege
//
//  Created by 吴佰清 on 14/12/3.
//  Copyright (c) 2014年 吴佰清. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BannerViewController : UICollectionViewController<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, retain) NSString *bannerId;

@end
