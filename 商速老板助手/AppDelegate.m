//
//  AppDelegate.m
//  商速老板助手
//
//  Created by 赵宁 on 2018/4/26.
//  Copyright © 2018年 luyonghao. All rights reserved.
//

#import "AppDelegate.h"
#import "TabController.h"
#import "LoginViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    UIWindow *key = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    key.rootViewController = [self setupRootViewController];
    key.backgroundColor = [UIColor whiteColor];
    [key makeKeyAndVisible];
    self.window = key;
    return YES;
}

- (UIViewController *)setupRootViewController{
    return [[UINavigationController alloc] initWithRootViewController:[[LoginViewController alloc]init]];
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
