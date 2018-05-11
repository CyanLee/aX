//
//  TabController.m
//  商速老板助手
//
//  Created by 赵宁 on 2018/4/26.
//  Copyright © 2018年 luyonghao. All rights reserved.
//

#import "TabController.h"
#import "NavViewController.h"
#import "PromoteViewController.h"
#import "MineViewController.h"
#import "HomeViewController.h"
#import "NSBundle+Language.h"

#define btnW 40
#define btnTop 8
#define btnBottom -8

@interface TabController ()

@property (nonatomic,strong)NSMutableArray *btns;
@property (nonatomic,weak)UIView *tabView;

@end

@implementation TabController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabBar.tintColor = [UIColor whiteColor];
    
    [self setupTabView];
    
    [self setupSubViewControllers];
    
    [self setupBtns];
    
}

- (void)setupTabView{
    UIView *tabView = [[UIView alloc] initWithFrame:self.view.bounds];
    [self.tabBar addSubview:tabView];
    tabView.backgroundColor = TabbarColor;
    self.tabView = tabView;
}

- (void)setupBtns{
    CGFloat margin = (kWidth - btnW * self.viewControllers.count) / self.viewControllers.count;
    CGFloat firstX = margin / 2.0;
    
    for (NSInteger i = 0; i < self.viewControllers.count; i ++) {
        UIButton *btn = [[UIButton alloc]init];
        [self.tabView addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(btnW);
            make.top.mas_offset(btnTop);
            make.bottom.mas_offset(btnBottom);
            make.left.mas_offset(firstX + (btnW + margin) * i);
        }];
        btn.tag = i;
        [btn addTarget:self action:@selector(btnDidClicked:) forControlEvents:UIControlEventTouchDown];
        [self.btns addObject:btn];
    }
}

- (void)btnDidClicked:(UIButton *)btn{
    self.selectedIndex = btn.tag;
}

- (void)setupSubViewControllers{
    MineViewController *mine = [[MineViewController alloc] init];
    mine.title = NSLocalized(@"My", nil);
    UIImage *image = [UIImage imageNamed:@"老板助手50X65"];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    mine.tabBarItem.image = image ;
    NavViewController *mineNav = [[NavViewController alloc] initWithRootViewController:mine];
    
    HomeViewController *home = [[HomeViewController alloc] init];
    home.title = NSLocalized(@"home", nil);
    UIImage *image1 = [UIImage imageNamed:@"老板助手首页50X50"];
    image1 = [image1 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    home.tabBarItem.image = image1 ;
    NavViewController *homeNav = [[NavViewController alloc] initWithRootViewController:home];
    
    PromoteViewController *promote = [[PromoteViewController alloc] init];
    promote.title = NSLocalized(@"Extension", nil);
    UIImage *image2 = [UIImage imageNamed:@"老板助手推广50X50"];
    image2 = [image2 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    promote.tabBarItem.image = image2 ;
    NavViewController *promoteNav = [[NavViewController alloc] initWithRootViewController:promote];
    
    self.viewControllers = @[homeNav,promoteNav,mineNav];
}

- (NSMutableArray *)btns{
    if (!_btns) {
        _btns = [NSMutableArray array];
    }
    return _btns;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
