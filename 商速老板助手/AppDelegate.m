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
#import "NetTools.h"
#import "APP_IPS.h"
#import "UserModel.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    UIWindow *key = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    key.rootViewController = [self setupRootViewController];
    key.backgroundColor = [UIColor whiteColor];
    [key makeKeyAndVisible];
    self.window = key;
    
    [self getStartImg];
    return YES;
}


- (void)getStartImg{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:@"999999999" forKey:@"deviceID"];
    [NetTools POST:APP_START_IMG_URL parameters:dic success:^(id responseObject) {
        DLog(@"启动页 responseObject == %@",responseObject);
    } failure:^(NSString *errStr) {
        DLog(@"启动页 errStr == %@",errStr);
    }];
}


- (UIViewController *)setupRootViewController{
//    return [UserModel getUserModel] == nil ? [[UINavigationController alloc] initWithRootViewController
//                                           : [[LoginViewController alloc]init]] :[[TabController alloc] init];
    return [[UINavigationController alloc] initWithRootViewController:[LoginViewController new]];

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
