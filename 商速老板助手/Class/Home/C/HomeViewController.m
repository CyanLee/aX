//
//  HomeViewController.m
//  商速老板助手
//
//  Created by 赵宁 on 2018/4/26.
//  Copyright © 2018年 luyonghao. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@property (nonatomic,weak)UIView *headerView;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setupNav];
    
    [self setupHeaderView];
}

- (void)setupNav{
    self.navigationController.navigationBarHidden = true;
}

- (void)setupHeaderView{
    UIView *headerView = [[UIView alloc]init];
    headerView.backgroundColor = DefineRedColor;
    [self.view addSubview:headerView];
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(468.0/2937.0*kHeight);
    }];
    self.headerView = headerView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
