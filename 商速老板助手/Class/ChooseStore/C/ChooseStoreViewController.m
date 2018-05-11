//
//  ChooseStoreViewController.m
//  商速老板助手
//
//  Created by 赵宁 on 2018/5/7.
//  Copyright © 2018年 luyonghao. All rights reserved.
//

#import "ChooseStoreViewController.h"

#import "APP_IPS.h"

#import "ChooseStoreModel.h"
@interface ChooseStoreViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,weak)UITableView *tab;

@property (nonatomic,assign)NSInteger maxPage;

@property (nonatomic,strong)NSMutableArray *datas;
@end

@implementation ChooseStoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"选择店铺";
    
    self.maxPage = MaxPage;
    
    [self setupTab];
    
    [self getDatas];
}

- (void)getDatas{
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"userId"] = @"13922190717";
    [NetTools POST:APP_STORE_INFO_URL parameters:dic success:^(id responseObject) {
        DLog(@"responseObject == %@",responseObject);
        if ([responseObject objectForKey:@"resultList"]) {
            self.datas = [ChooseStoreModel mj_objectArrayWithKeyValuesArray:responseObject[@"resultList"]];
        }
        if (self.tab.mj_footer.refreshing) [self.tab.mj_footer endRefreshing];
        if (self.tab.mj_header.refreshing) [self.tab.mj_header endRefreshing];
        if (self.datas.count < MaxPage) [self.tab.mj_footer endRefreshingWithNoMoreData];
        [self.tab reloadData];
    } failure:^(NSString *errStr) {
        if (self.tab.mj_footer.refreshing) [self.tab.mj_footer endRefreshing];
        if (self.tab.mj_header.refreshing) [self.tab.mj_header endRefreshing];
        [SVProgressHUD showErrorWithStatus:errStr];
    }];
    
}

- (void)setupTab{
    UITableView *tab = [[UITableView alloc] init];
    tab.delegate = self;
    tab.dataSource = self;
    tab.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tab];
    [tab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    WS(ws);
    tab.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [ws mj_headerGetDatas];
    }];
    tab.mj_footer  = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [ws tabFooterRefresh];
    }];
    
    self.tab = tab;
}

- (void)mj_headerGetDatas{
    if (self.tab.mj_footer.refreshing) {
        [self.tab.mj_footer endRefreshing];
        return;
    }
    self.maxPage = MaxPage;
    [self getDatas];
}

- (void)tabFooterRefresh{
    if (self.tab.mj_header.refreshing) {
        [self.tab.mj_header endRefreshing];
        return;
    }
    self.maxPage += MaxPage;
    [self getDatas];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChooseStoreViewController"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:0 reuseIdentifier:@"ChooseStoreViewController"];
    }
    ChooseStoreModel *model = self.datas[indexPath.row];
    cell.textLabel.text = model.merchantName;
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.textLabel.textColor = [UIColor colorWithRed:56.0/255.0 green:56.0/255.0 blue:56.0/255.0 alpha:1];
    cell.selectionStyle = 0;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = false;
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBarHidden = true;
    [super viewWillDisappear:animated];
}


- (NSMutableArray *)datas{
    if (!_datas) {
        _datas = [NSMutableArray array];
    }
    return _datas;
}

@end
