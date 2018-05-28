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
#import "UserModel.h"
@interface HistoryViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,weak) UITableView *tableView;
@property (nonatomic,weak)HistoryHeaderView *headerView;
@property (nonatomic,strong) NSMutableArray *dataArr;
@property (nonatomic,assign)NSInteger maxPage;
@property (nonatomic, strong)SelectPhotoManager *photoManager;

@end

@implementation HistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tongzhi:)name:@"tongzhi" object:nil];
    self.maxPage = MaxPage;
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupHeaderView];
    [self setupTableView];
    [self getDatas];
}

- (void)getDatas{
    UserModel *user = [UserModel getUserModel];
    NSString *numsPage = [NSString stringWithFormat:@"%ld",(long)self.maxPage];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:@"4" forKey:@"countType"];
    [dic setObject:user.userId forKey:@"userId"];
    [dic setObject:@"139221907171001" forKey:@"merchantCode"];
    [dic setObject:@"2018-01-05" forKey:@"startDate"];
    [dic setObject:@"2018-03-31" forKey:@"endDate"];
    [dic setObject:@"1" forKey:@"curPageNo"];
    [dic setObject:numsPage forKey:@"numsPage"];
    [NetTools POST:APP_HISTORY_URL parameters:dic success:^(id responseObject) {
        DLog(@"responseObject == %@",responseObject);
        NSArray *resultList = [responseObject objectForKey:@"resultList"];
        [self.dataArr removeAllObjects];
        self.dataArr = [HistoryModel mj_objectArrayWithKeyValuesArray:resultList];
        if (self.tableView.mj_header.refreshing) [self.tableView.mj_header endRefreshing];
        if (self.tableView.mj_footer.refreshing) [self.tableView.mj_footer endRefreshing];
        if (self.dataArr.count < MaxPage)          [self.tableView.mj_footer endRefreshingWithNoMoreData];
        [self.tableView reloadData];
    } failure:^(NSString *errStr) {
        if (self.tableView.mj_header.refreshing) {
            [self.tableView.mj_header endRefreshing];
        }
        if (self.tableView.mj_footer.refreshing) {
            [self.tableView.mj_footer endRefreshing];
        }
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
    [headerView.headerView addTarget:self action:@selector(actionClick) forControlEvents:UIControlEventTouchUpInside];
}
- (void)jump2ChooseStore{
    ChooseStoreViewController *choose = [[ChooseStoreViewController alloc]init];
    [self.navigationController pushViewController:choose animated:true];
}
- (void)back{
    [self.navigationController popViewControllerAnimated:true];
}

-(void)setupTableView{
    UITableView *tab = [[UITableView alloc] init];
    tab.delegate = self;
    tab.dataSource = self;
    [self.view addSubview:tab];
    [tab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.headerView.mas_bottom);
    }];
    WS(ws);
    tab.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [ws mj_headerGetDatas];
    }];
    tab.mj_footer  = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [ws tabFooterRefresh];
    }];
    
    self.tableView = tab;
}

- (void)mj_headerGetDatas{
    if (self.tableView.mj_footer.refreshing) {
        [self.tableView.mj_footer endRefreshing];
        return;
    }
    self.maxPage = MaxPage;
    [self getDatas];
}

- (void)tabFooterRefresh{
    if (self.tableView.mj_header.refreshing) {
        [self.tableView.mj_header endRefreshing];
        return;
    }
    self.maxPage += MaxPage;
    [self getDatas];
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

- (void)actionClick{
    if (!_photoManager) {
        _photoManager =[[SelectPhotoManager alloc]init];
    }
    [_photoManager startSelectPhotoWithImageName:@"选择头像"];
    __weak typeof(self)mySelf=self;
    //选取照片成功
    _photoManager.successHandle=^(SelectPhotoManager *manager,UIImage *image){
        [mySelf.headerView.headerView setImage:image forState:UIControlStateNormal];
        //保存到本地
        NSData *data = UIImagePNGRepresentation(image);
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"headerImage"];
    };
}

- (void)tongzhi:(NSNotification *)text{
    [self.headerView.chooseBtn setTitle:text.object[@"merchantName"] forState:UIControlStateNormal];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
