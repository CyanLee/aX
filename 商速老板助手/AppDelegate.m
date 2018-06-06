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
#import "NSBundle+Language.h"
#import "WelcomeViewController.h"
#import "NavViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate

- (UIWindow *)welcomeWindow{
    if (!_welcomeWindow) {
        //显示欢迎页的窗口. 后初始化的窗口显示在最上方. 被用户可见.
        //注意此写法对于storyboard不好用, 因为生命周期的问题.
        _welcomeWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        //window初始化之后, 默认是隐藏的
        _welcomeWindow.hidden = NO;
        _welcomeWindow.rootViewController = [WelcomeViewController new];
        //窗口的层级关系, 数值越大, 则显示在上层 默认是0
        _welcomeWindow.windowLevel = 1;
    }
    return _welcomeWindow;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //获取设备码
    NSString *deviceUUID = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    //用keyChain保存设备码
    [GSKeyChainDataManager saveUUID:deviceUUID key:@"deviceId"];
    
    NSString *languageStr = UD_GET_OBJ(@"LanguageKey");
    if (languageStr != nil) {
        if ([languageStr isEqualToString:@"base"]) {
            [NSBundle setLanguage:nil];
        }else{
            [NSBundle setLanguage:languageStr];
        }
    }else{
        [NSBundle setLanguage:nil];
    }
    
    
    if (UD_GET_OBJ(@"logoKey")) {
        [self welcomeWindow];
        UIWindow *key = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        key.rootViewController = [self setupRootViewController];
        key.backgroundColor = [UIColor whiteColor];
        [key makeKeyAndVisible];
        self.window = key;
    }else{
        UIWindow *key = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        key.rootViewController = [self setupRootViewController];
        key.backgroundColor = [UIColor whiteColor];
        [key makeKeyAndVisible];
        self.window = key;
    }
    
    [self getStartImg];
    
//    _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    [_window makeKeyAndVisible];
//    _window.rootViewController = [self setupRootViewController];
    
//    [self getStartImg];
    
    return YES;
}


- (void)getStartImg{
    // @"http://www.shopspeed.cn:80/shopspeed_points/BossAssistant/getOpenScreen.do"
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[GSKeyChainDataManager readUUIDkey:@"deviceId"] forKey:@"deviceID"];
    [NetTools POST:APP_START_IMG_URL parameters:dic success:^(id responseObject) {
        DLog(@"启动页 responseObject == %@",responseObject);
        NSString *url = [NSString stringWithFormat:@"http://www.shopspeed.cn:80/shopspeed_points/%@",responseObject[@"logoImgUrl"]];
        NSData *data = [NSData dataWithContentsOfURL:[NSURL  URLWithString:url]];
        UD_SET_OBJ(data, @"logoKey");
        UD_SET_OBJ(responseObject[@"skipTime"], @"countKey");
    } failure:^(NSString *errStr) {
        DLog(@"启动页 errStr == %@",errStr);
    }];
}


- (UIViewController *)setupRootViewController{
    return [UserModel getUserModel] == nil ? [[NavViewController alloc] initWithRootViewController
                                           : [[LoginViewController alloc]init]] :[[TabController alloc] init];
//    return [[UINavigationController alloc] initWithRootViewController:[TabController new]];

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
