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

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArr;

@end

@implementation HistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
//    [self setData];
    [self setHeaderView];
    [self setTableView];
    [self getDatas];
}

- (void)getDatas{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:@"2" forKey:@"countType"];
    [dic setObject:@"13922190717" forKey:@"userId"];
    [dic setObject:@"139221907171001" forKey:@"merchantCode"];
    [dic setObject:@"2018-01-05" forKey:@"startDate"];
    [dic setObject:@"2018-03-31" forKey:@"endDate"];
    [dic setObject:@"1" forKey:@"curPageNo"];
    [dic setObject:@"5" forKey:@"numsPage"];
    [NetTools POST:APP_HISTORY_URL parameters:dic success:^(id responseObject) {
        DLog(@"responseObject == %@",responseObject);
        NSArray *resultList = [responseObject objectForKey:@"resultList"];
        self.dataArr = [HistoryModel mj_objectArrayWithKeyValuesArray:resultList];
        [self.tableView reloadData];
    } failure:^(NSString *errStr) {
        [SVProgressHUD showErrorWithStatus:errStr];
    }];
}

-(void)setData{
    NSDictionary *dic = @{@"time":@"2018/07/08",@"turnoverNum":@"8888",@"num":@"876"};
    NSDictionary *dic1 = @{@"time":@"2017/07/08",@"turnoverNum":@"7777",@"num":@"876"};
    NSDictionary *dic2 = @{@"time":@"2016/07/08",@"turnoverNum":@"6666",@"num":@"876"};
    NSMutableArray *arr = [NSMutableArray arrayWithObjects:dic,dic1,dic2, nil];
    self.dataArr = [NSMutableArray array];
    NSMutableArray *tempArr = [NSMutableArray array];
    for (NSDictionary *d in arr) {
        HistoryModel *model = [HistoryModel mj_objectWithKeyValues:d];
        [tempArr addObject:model];
    }
    [self.dataArr addObjectsFromArray:tempArr];
}

-(void)setHeaderView{
    HistoryHeaderView *headerView = [[HistoryHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 488.0/2937.0*kHeight)];

    [self.view addSubview:headerView];
    headerView.backBlock = ^{
        [self.navigationController popViewControllerAnimated:YES];
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

-(void)setTableView{
    CGFloat h = 468.0/2937.0*kHeight;
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 468.0/2937.0*kHeight, SCREEN_WIDTH, SCREEN_HEIGHT - h) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[HistoryCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableView];
}

#pragma mark ------ tableView代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArr.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    HistoryModel *model = [self.dataArr objectAtIndex:indexPath.section];
    [cell setData:model];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    HistoryPartitionView *sectionView = [[HistoryPartitionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
    HistoryModel *model = [self.dataArr objectAtIndex:section];
    [sectionView setData:model];
    return sectionView;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}

@end
