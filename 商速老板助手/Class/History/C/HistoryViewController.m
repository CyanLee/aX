//
//  HistoryViewController.m
//  商速老板助手
//
//  Created by hiby001 on 2018/5/2.
//  Copyright © 2018年 luyonghao. All rights reserved.
//

#import "HistoryViewController.h"
#import "HistoryHeaderView.h"
#import "HistoryCell.h"

@interface HistoryViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;

@end

@implementation HistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setHeaderView];
    [self setTableView];
}

-(void)setHeaderView{
    HistoryHeaderView *headerView = [[HistoryHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 468.0/2937.0*kHeight)];
    [self.view addSubview:headerView];
}

-(void)setTableView{
    CGFloat h = 468.0/2937.0*kHeight;
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 468.0/2937.0*kHeight, SCREEN_WIDTH, SCREEN_HEIGHT - h) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[HistoryCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableView];
}

#pragma mark ------ tableView代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
