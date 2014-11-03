//
//  AppDelegate.m
//  privilege
//
//  Created by 吴佰清 on 14-10-13.
//  Copyright (c) 2014年 吴佰清. All rights reserved.
//

#import "AppDelegate.h"
#import "RenderTabBarViewController.h"
#import "UIImageView+WebCache.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


# pragma mark 应用启动执行
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // 图片缓存
    SDWebImageManager.sharedManager.cacheKeyFilter = ^(NSURL *url) {
        url = [[NSURL alloc] initWithScheme:url.scheme host:url.host path:url.path];
        return [url absoluteString];
    };
    
    // 设置Window
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    // 渲染UITabBar基础页面
    RenderTabBarViewController *renderTabBar = [[RenderTabBarViewController alloc] init];
    self.window.rootViewController = renderTabBar;
    
    // 显示视图
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
}

- (void)applicationWillTerminate:(UIApplication *)application {
}

@end
