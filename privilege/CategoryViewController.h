//
//  CategoryViewController.h
//  privilege
//
//  Created by 吴佰清 on 14-10-17.
//  Copyright (c) 2014年 吴佰清. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CategoryViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
{
    @private
    UITableView *_tableView;
}


@property (nonatomic) NSArray *listArray;

@end
