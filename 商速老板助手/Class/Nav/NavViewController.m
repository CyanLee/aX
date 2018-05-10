//
//  NavViewController.m
//  商速老板助手
//
//  Created by 赵宁 on 2018/4/26.
//  Copyright © 2018年 luyonghao. All rights reserved.
//

#import "NavViewController.h"

@interface NavViewController ()

@end

@implementation NavViewController


- (instancetype)initWithRootViewController:(UIViewController *)rootViewController{
    if (self = [super initWithRootViewController:rootViewController]) {
        /**! title富文本 !**/
        self.navigationBar.titleTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor whiteColor]
                                                   };
        self.navigationBar.tintColor = [UIColor whiteColor];
        
        /**! 适配不合理的一条线 !**/
        //self.fd_interactivePopMaxAllowedInitialDistanceToLeftEdge = -1;
        //self.fd_interactivePopDisabled = true;
        //[self setValue:rootViewController forKey:@"rootVC"];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置导航栏通用色
    [[UINavigationBar appearance] setBarTintColor:DefineRedColor];
    
    
    [self preferredStatusBarStyle];
    self.navigationBar.translucent = NO;
    // 设置返回的颜色
    self.navigationBar.tintColor = [UIColor whiteColor];
    
    //去掉黑线
    [[UINavigationBar appearance]  setBackgroundImage:[[UIImage alloc] init] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
