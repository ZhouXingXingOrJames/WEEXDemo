//
//  AppDelegate.m
//  weexDemo
//
//  Created by Mr.Zhang on 2017/2/6.
//  Copyright © 2017年 lei.Zhang. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import <WeexSDK/WXSDKEngine.h>
#import <WeexSDK/WXDebugTool.h>
#import <WeexSDK/WXLog.h>
#import <WeexSDK/WXAppConfiguration.h>
#import "ImageDownloadder.h"
#import <TBWXDevtool/WXDevtool.h>
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    NSString *url = [NSString stringWithFormat:@"file://%@/foo.js",[NSBundle mainBundle].bundlePath];
//    NSString *url = @"http://192.168.10.68:8087/dist/foo.js";
    ViewController *viewController = [[ViewController alloc] init];
    viewController.url = url;
    self.window = ({
        UINavigationController *navVC = [[UINavigationController alloc]initWithRootViewController:viewController];
        navVC.navigationBar.hidden = YES;
        UIWindow *window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
        window.rootViewController = navVC;
        window.backgroundColor = [UIColor whiteColor];
        window;
    });
    [self.window makeKeyAndVisible];
    [self weexSetting];
    return YES;
}

- (void)weexSetting{
    //业务配置，非必需
    [WXAppConfiguration setAppGroup:@"AliApp"];
    [WXAppConfiguration setAppName:@"WeexDemo"];
    [WXAppConfiguration setAppVersion:@"1.0.0"];
    
    //初始化SDK环境
    [WXSDKEngine initSDKEnviroment];
    
    //重写图片加载器
    [WXSDKEngine registerHandler:[ImageDownloadder new] withProtocol:@protocol(WXImgLoaderProtocol)];

    //设置Log输出等级：调试环境默认为Debug，正式发布会自动关闭。
    [WXLog setLogLevel:WXLogLevelAll];
    [WXDevTool setDebug:NO];
    [WXDevTool launchDevToolDebugWithUrl:@"ws://192.168.10.68:8088/debugProxy/native"];
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
