//
//  AppDelegate.m
//  JWBleDemo
//
//  Created by Bo 黄 on 2019/3/20.
//  Copyright © 2019 wosmart. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    RootViewController *controllerA = [[RootViewController alloc]init];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:controllerA];
    
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    if (self.window) {
        if (url) {
            NSString *fileName = url.lastPathComponent; // 从路径中获得完整的文件名（带后缀）
            // path 类似这种格式：file:///private/var/mobile/Containers/Data/Application/83643509-E90E-40A6-92EA-47A44B40CBBF/Documents/Inbox/jfkdfj123a.pdf
            NSString *path = url.absoluteString; // 完整的url字符串
            
            NSMutableString *string = [[NSMutableString alloc] initWithString:path];
            
            if ([path hasPrefix:@"file://"]) { // 通过前缀来判断是文件
                // 去除前缀：/private/var/mobile/Containers/Data/Application/83643509-E90E-40A6-92EA-47A44B40CBBF/Documents/Inbox/jfkdfj123a.pdf
                [string replaceOccurrencesOfString:@"file://" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, path.length)];
                
                // 此时获取到文件存储在本地的路径，就可以在自己需要使用的页面使用了
                NSDictionary *dict = @{@"fileName":fileName,
                                       @"filePath":string};
                [[NSNotificationCenter defaultCenter] postNotificationName:@"FileNotification" object:nil userInfo:dict];
                
                return YES;
            }
        }
    }
    return YES;
}



@end
