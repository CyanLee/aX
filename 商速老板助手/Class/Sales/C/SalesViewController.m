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

@interface SalesViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,weak)TimeView *timeView;
@property (nonatomic,strong) UITableView *tableView;

@end

@implementation SalesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setHeaderView];
    [self setupTimeView];
    [self setDivisionHeaderView];
    [self setTableView];
    [self setDivisionFootView];
    
}

-(void)setHeaderView{
    SalesHeaderView *headerView = [[SalesHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 488.0/2937.0*kHeight)];
    [self.view addSubview:headerView];
    headerView.backBlock = ^{
        [self.navigationController popViewControllerAnimated:YES];
    };
}

-(void)setDivisionHeaderView{
    SalesDivisionHeadView *divisionView = [[SalesDivisionHeadView alloc] initWithFrame:CGRectMake(0, 488.0/2937.0*kHeight, SCREEN_WIDTH, 60)];
    [self.view addSubview:divisionView];
}

-(void)setDivisionFootView{
    CGFloat h = 488.0/2937.0*kHeight;
    CGFloat timeH = kWidth == 320 ? 20 : 30;
    CGFloat switchTimeH = kWidth == 320 ? 90 : 120;
    SalesDivisionFootView *divisionView = [[SalesDivisionFootView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - h - timeH - switchTimeH, SCREEN_WIDTH, 60)];
    [self.view addSubview:divisionView];
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

-(void)setTableView{
    CGFloat h = 488.0/2937.0*kHeight;
    CGFloat timeH = kWidth == 320 ? 20 : 30;
    CGFloat switchTimeH = kWidth == 320 ? 90 : 120;
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 488.0/2937.0*kHeight + 60, SCREEN_WIDTH, SCREEN_HEIGHT - h - timeH - switchTimeH - 49 - 60 - 60) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[SalesCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableView];
}

#pragma mark - 点击事件
- (void)timeViewChooseTimeBlock:(UIButton *)btn{
    DLog(@"btn == %@",btn);
}
- (void)timeViewBtnDidClickedBlock:(UIButton *)btn{
    DLog(@"btn == %@",btn);
}

#pragma mark - tableView 代理
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SalesCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
