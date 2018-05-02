//
//  HistoryViewController.m
//  商速老板助手
//
//  Created by hiby001 on 2018/5/2.
//  Copyright © 2018年 luyonghao. All rights reserved.
//

#import "HistoryViewController.h"
#import "HistoryHeaderView.h"

@interface HistoryViewController ()

@end

@implementation HistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setHeaderView];
}

-(void)setHeaderView{
    HistoryHeaderView *headerView = [[HistoryHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 468.0/2937.0*kHeight)];
    [self.view addSubview:headerView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
