/**
 * App代理
 * Copyright (c) 2014年 吴佰清. All rights reserved.
 */

// 代理
#import "AppDelegate.h"

// 工具栏
#import "ToolsController.h"

// 图片缓存
#import "UIImageView+WebCache.h"

@interface AppDelegate ()
@end

@implementation AppDelegate

// 应用启动时执行
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // 图片缓存
    SDWebImageManager.sharedManager.cacheKeyFilter = ^(NSURL *url) {
        url = [[NSURL alloc] initWithScheme:url.scheme host:url.host path:url.path];
        return [url absoluteString];
    };
    
    // 设置窗口大小、背景颜色
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    // 渲染工具栏页面：首页、值得逛、最新，关于我们
    ToolsController *tools = [[ToolsController alloc] init];
    self.window.rootViewController = tools;
    
    // 显示视图
    [self.window makeKeyAndVisible];
    return YES;
}

@end
