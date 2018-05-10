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
#import "HistoryPartitionView.h"
#import "HistoryModel.h"
#import "APP_IPS.h"
#import "ChooseStoreViewController.h"
@interface HistoryViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,weak) UITableView *tableView;
@property (nonatomic,weak)HistoryHeaderView *headerView;
@property (nonatomic,strong) NSMutableArray *dataArr;

@end

@implementation HistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupHeaderView];
    [self setupTableView];
    [self getDatas];
}

- (void)getDatas{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:@"4" forKey:@"countType"];
    [dic setObject:@"13922190717" forKey:@"userId"];
    [dic setObject:@"139221907171001" forKey:@"merchantCode"];
    [dic setObject:@"2018-01-05" forKey:@"startDate"];
    [dic setObject:@"2018-03-31" forKey:@"endDate"];
    [dic setObject:@"1" forKey:@"curPageNo"];
    [dic setObject:@"100" forKey:@"numsPage"];
    [NetTools POST:APP_HISTORY_URL parameters:dic success:^(id responseObject) {
        DLog(@"responseObject == %@",responseObject);
        NSArray *resultList = [responseObject objectForKey:@"resultList"];
        self.dataArr = [HistoryModel mj_objectArrayWithKeyValuesArray:resultList];
        [self.tableView reloadData];
    } failure:^(NSString *errStr) {
        [SVProgressHUD showErrorWithStatus:errStr];
    }];
}


-(void)setupHeaderView{
    HistoryHeaderView *headerView = [[HistoryHeaderView alloc] init];
    __weak typeof(self) ws = self;
    [self.view addSubview:headerView];
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.mas_equalTo(488.0/2937.0*kHeight);
    }];
    self.headerView = headerView;
    headerView.backBlock = ^{
        [ws.navigationController popViewControllerAnimated:YES];
    };
    [headerView.chooseBtn addTarget:self action:@selector(jump2ChooseStore) forControlEvents:1<<6];
}
- (void)jump2ChooseStore{
    ChooseStoreViewController *choose = [[ChooseStoreViewController alloc]init];
    [self.navigationController pushViewController:choose animated:true];
}
- (void)back{
    [self.navigationController popViewControllerAnimated:true];
}

-(void)setupTableView{
    CGFloat h = 468.0/2937.0*kHeight;
    UITableView *tab = [[UITableView alloc] init];
    tab.delegate = self;
    tab.dataSource = self;
    [self.view addSubview:tab];
    [tab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.headerView.mas_bottom);
    }];
    self.tableView = tab;
}

#pragma mark ------ tableView代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[HistoryCell alloc] initWithStyle:0 reuseIdentifier:@"cell"];
    }
    cell.model = self.dataArr[indexPath.row];
    cell.selectionStyle = 0;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
