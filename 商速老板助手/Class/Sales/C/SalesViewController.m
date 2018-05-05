//
//  SalesViewController.m
//  商速老板助手
//
//  Created by 今日 on 2018/5/4.
//  Copyright © 2018年 luyonghao. All rights reserved.
//

#import "SalesViewController.h"
#import "SalesHeaderView.h"
#import "TimeView.h"
#import "SalesCell.h"
#import "SalesDivisionHeadView.h"
#import "SalesDivisionFootView.h"
#import "APP_IPS.h"
#import "SalesModel.h"
typedef enum : NSUInteger {
    Type_APP_SALE_SORT_10_URL = 0,
    Type_APP_SALE_MONEY_10_URL,
    Type_APP_SALE_GOODS_URL,
    Type_APP_SALE_BACK_URL
} GetDataType;
@interface SalesViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,weak)TimeView *timeView;
@property (nonatomic,weak) UITableView *tableView;
@property (nonatomic,weak)SalesDivisionFootView *tabFooter;
@property (nonatomic,weak)SalesHeaderView *headerView;
@property (nonatomic,weak)SalesDivisionHeadView *tabHeader;
/// 目前只有收银情况汇总有数据，所以待定
@property (nonatomic,strong)NSMutableArray *datas;
@end

@implementation SalesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupHeaderView];
    [self setupTimeView];
    [self setupTableView];
    [self setupDivisionHeaderView];
    [self setupDivisionFootView];
    
    [self getDatasWithType:Type_APP_SALE_SORT_10_URL];
}

- (void)getDatasWithType:(GetDataType)type{
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSString *postUrl = @"";
    switch (type) {
        /// 商店销量前10
        case Type_APP_SALE_SORT_10_URL:
            dic[@"countType"] = @"1";
            dic[@"userId"] = @"13922190717";
            dic[@"merchantCode"] = @"10001";
            dic[@"startDate"] = @"2018-02-15";
            dic[@"endDate"] = @"2018-03-15";
            postUrl = APP_SALE_SORT_10_URL;
            break;
        /// 销售金额前10
        case Type_APP_SALE_MONEY_10_URL:
            dic[@"countType"] = @"1";
            dic[@"userId"] = @"13922190717";
            dic[@"merchantCode"] = @"10001";
            dic[@"startDate"] = @"2018-02-15";
            dic[@"endDate"] = @"2018-03-15";
            postUrl = APP_SALE_MONEY_10_URL;
            break;
        /// 商店类别销售情况
        case Type_APP_SALE_GOODS_URL:
            dic[@"countType"] = @"1";
            dic[@"userId"] = @"13922190717";
            dic[@"merchantCode"] = @"10001";
            dic[@"startDate"] = @"2018-02-15";
            dic[@"endDate"] = @"2018-03-15";
            dic[@"curPageNo"] = @"1";
            dic[@"numsPage"] = @"5";
            postUrl = APP_SALE_GOODS_URL;
            break;
        /// 收银情况汇总
        case Type_APP_SALE_BACK_URL:
            dic[@"countType"] = @"1";
            dic[@"userId"] = @"13922190717";
            dic[@"merchantCode"] = @"10001";
            dic[@"startDate"] = @"2018-02-15";
            dic[@"endDate"] = @"2018-03-15";
            dic[@"curPageNo"] = @"1";
            dic[@"numsPage"] = @"5";
            postUrl = APP_SALE_BACK_URL;
            break;
        default:
            break;
    }
    
    [NetTools POST:postUrl parameters:dic success:^(id responseObject) {
        DLog(@"responseObject == %@",responseObject);
        if ([responseObject objectForKey:@"totalAmount"]) {
            self.tabFooter.salesMoney.text = [NSString stringWithFormat:@"%@",responseObject[@"totalAmount"]];
        }
        if ([responseObject objectForKey:@"totalTxNums"]) {
            self.tabFooter.salesNumLabel.text = [NSString stringWithFormat:@"%@",responseObject[@"totalTxNums"]];
        }
        if ([responseObject objectForKey:@"resultList"]) {
            self.datas = [SalesModel mj_objectArrayWithKeyValuesArray:responseObject[@"resultList"]];
        }
        [self.tableView reloadData];
    } failure:^(NSString *errStr) {
        [SVProgressHUD showErrorWithStatus:errStr];
    }];
}

-(void)setupHeaderView{
    //SalesHeaderView *headerView = [[SalesHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 488.0/2937.0*kHeight)];
    SalesHeaderView *headerView = [[SalesHeaderView alloc] init];
    [self.view addSubview:headerView];
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.mas_equalTo(488.0/2937.0*kHeight);
    }];
    __weak typeof(self) ws = self;
    headerView.backBlock = ^{
        [ws.navigationController popViewControllerAnimated:YES];
    };
    [headerView setClick:^(NSInteger idx) {
        [ws headerViewDidClickIndex:idx];
    }];
    self.headerView = headerView;
}

- (void)headerViewDidClickIndex:(NSInteger)idx{
    DLog(@"headerViewDidClickIndex  == %ld",idx);
    [self getDatasWithType:idx];
}

-(void)setupDivisionHeaderView{
    SalesDivisionHeadView *divisionView = [[SalesDivisionHeadView alloc] initWithFrame:CGRectMake(0, 488.0/2937.0*kHeight, SCREEN_WIDTH, 60)];
   // [self.view addSubview:divisionView];
    self.tableView.tableHeaderView = divisionView;
    self.tabHeader = divisionView;
}

-(void)setupDivisionFootView{
    CGFloat h = 488.0/2937.0*kHeight;
    CGFloat timeH = kWidth == 320 ? 20 : 30;
    CGFloat switchTimeH = kWidth == 320 ? 90 : 120;
    SalesDivisionFootView *divisionView = [[SalesDivisionFootView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - h - timeH - switchTimeH, SCREEN_WIDTH, 60)];
   // [self.view addSubview:divisionView];
    self.tabFooter = divisionView;
    self.tableView.tableFooterView = divisionView;
}

- (void)setupTimeView{
    CGFloat timeH = kWidth == 320 ? 20 : 30;
    CGFloat switchTimeH = kWidth == 320 ? 90 : 120;
    TimeView *timeView = [[TimeView alloc] initWithTimeH:timeH WithSwicthTimeH:switchTimeH];
    [self.view addSubview:timeView];
    [timeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(timeH+switchTimeH);
        make.bottom.mas_offset(-49);
    }];
    self.timeView = timeView;
    __weak typeof(self) ws = self;
    [self.timeView setChooseTimeBlock:^(UIButton *btn) {
        [ws timeViewChooseTimeBlock:btn];
    }];
    [self.timeView setBtnDidClickedBlock:^(UIButton *btn) {
        [ws timeViewBtnDidClickedBlock:btn];
    }];
}

-(void)setupTableView{
   // CGFloat h = 488.0/2937.0*kHeight;
   // CGFloat timeH = kWidth == 320 ? 20 : 30;
    //CGFloat switchTimeH = kWidth == 320 ? 90 : 120;
   // UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 488.0/2937.0*kHeight + 60, SCREEN_WIDTH, SCREEN_HEIGHT - h - timeH - switchTimeH - 49 - 60 - 60) style:UITableViewStylePlain];
    UITableView *tableView = [[UITableView alloc] init];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView registerClass:[SalesCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.headerView);
        make.top.equalTo(self.headerView.mas_bottom);
        make.bottom.equalTo(self.timeView.mas_top);
    }];
    [self setTableView:tableView];
}

#pragma mark - 点击事件
- (void)timeViewChooseTimeBlock:(UIButton *)btn{
    DLog(@"btn == %@",btn);
}
- (void)timeViewBtnDidClickedBlock:(UIButton *)btn{
    DLog(@"btn == %@",btn);
}

- (void)dealloc{
    DLog(@"dealloc");
}

#pragma mark - tableView 代理
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //return 5;
    return self.datas.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SalesCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (NSMutableArray *)datas{
    if (!_datas) {
        _datas = [NSMutableArray array];
    }
    return _datas;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
