//
//  DetailViewController.h
//  privilege
//
//  Created by 吴佰清 on 14/11/18.
//  Copyright (c) 2014年 吴佰清. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailController : UIViewController<UIWebViewDelegate>
{
    UIWebView *webView;
    UIToolbar *toolBar;
}

@property (nonatomic, retain) NSString *goodsUrl;

@end
