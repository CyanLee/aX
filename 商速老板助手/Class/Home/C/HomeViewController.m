//
//  HomeViewController.m
//  商速老板助手
//
//  Created by 赵宁 on 2018/4/26.
//  Copyright © 2018年 luyonghao. All rights reserved.
//

#import "HomeViewController.h"
#import "TimeView.h"
#import "InfoView.h"
#import "ReportViewController.h"
#import "HistoryViewController.h"
#import "LanguageViewController.h"
#import "SalesViewController.h"

#import "APP_IPS.h"
#import "UserModel.h"
@interface HomeViewController ()

@property (nonatomic,weak)UIView *headerView;
@property (nonatomic,weak)UIButton *storeBtn;
@property (nonatomic,weak)UIButton *languageBtn;
@property (nonatomic,weak)UIButton *chooseBtn;
@property (nonatomic,weak)TimeView *timeView;
@property (nonatomic,weak)InfoView *infoView;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setupNav];
    
    [self setupHeaderView];
    
    [self setupTimeView];
    
    [self setupInfoView];
    
    if (![UserModel getUserModel]) {
        [self autoLogin];
    }
}

- (void)autoLogin{
    UserModel *model = [UserModel getUserModel];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:@"866955030036774" forKey:@"deviceID"];
    [dic setObject:@"12345678" forKey:@"userPwd"];
    [dic setObject:model.userId forKey:@"userId"];
    
    [NetTools POST:APP_LOGON_URL parameters:dic success:^(id responseObject) {
        DLog(@"");
    } failure:^(NSString *errStr) {
        DLog(@"");
        [SVProgressHUD showErrorWithStatus:errStr];
    }];
}

#pragma mark
#pragma mark -- header
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
    
    [self setupStoreBtn];
    
    [self setupLanguageBtn];
    
    [self setupChooseBtn];
}

-(void)setupChooseBtn{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = DefineRedColor;
    [self.headerView addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.headerView);
        make.height.mas_equalTo(24);
        make.width.mas_equalTo(100);
        make.centerY.equalTo(self.storeBtn).mas_offset(-4);
    }];
    [btn setTitle:@"选择店铺" forState:0];
    [btn setTitleColor:[UIColor whiteColor] forState:0];
    btn.titleLabel.font = [UIFont systemFontOfSize:10];
    btn.layer.cornerRadius = 4;
    btn.layer.masksToBounds = true;
    btn.layer.borderWidth = 1;
    btn.layer.borderColor = [[UIColor whiteColor] CGColor];
    [btn addTarget:self action:@selector(languageBtnDidClicked) forControlEvents:1<<6];
    self.chooseBtn = btn;
}

-(void)setupStoreBtn{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor whiteColor];
    [self.headerView addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.left.mas_equalTo(self.headerView).offset(13);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(40);
    }];
    btn.layer.cornerRadius = 20;
    btn.layer.masksToBounds = true;
    [btn addTarget:self action:@selector(storeBtnDidClicked) forControlEvents:1<<6];
    self.storeBtn = btn;
    
    UILabel *label = [[UILabel alloc]init];
    [self.headerView addSubview:label];
    label.text = @"改店标";
    label.textAlignment = 0;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:12];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.storeBtn);
        make.left.equalTo(self.storeBtn.mas_right).mas_offset(5);
    }];
}

-(void )setupLanguageBtn{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor whiteColor];
    [self.headerView addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.height.width.equalTo(self.storeBtn);
        make.right.equalTo(self.headerView).mas_offset(-13);
    }];
    [btn setTitle:@"语言" forState:0];
    [btn setTitleColor:DefineRedColor forState:0];
    btn.titleLabel.font = [UIFont systemFontOfSize:10];
    btn.layer.cornerRadius = 20;
    btn.layer.masksToBounds = true;
    [btn addTarget:self action:@selector(languageBtnDidClicked) forControlEvents:1<<6];
    self.languageBtn = btn;
    
}

- (void)languageBtnDidClicked{
    DLog(@"%s",__func__);
    LanguageViewController *language = [[LanguageViewController alloc] init];
    language.hidesBottomBarWhenPushed = true;
    [self.navigationController pushViewController:language animated:true];
}

- (void)storeBtnDidClicked{
    DLog(@"%s",__func__);
}

#pragma mark
#pragma mark -- center
- (void)setupInfoView{
    InfoView *info = [[InfoView alloc]init];
    [self.view addSubview:info];
    [info mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.headerView.mas_bottom).mas_offset(-20);
        make.bottom.equalTo(self.timeView.mas_top);
    }];
    self.infoView = info;
    __weak typeof(self) ws = self;
    [self.infoView setReportBtnBlock:^{
        [ws jump2Report];
    }];
    [self.infoView setHistoryBtnBlock:^{
        [ws jump2History];
    }];
    [self.infoView setSegmentedCBlock:^(NSInteger index) {
        NSLog(@"index = %ld",(long)index);
    }];
}

- (void)jump2Report{
    /*
    ReportViewController *report = [[ReportViewController alloc] init];
    report.hidesBottomBarWhenPushed = true;
    [self.navigationController pushViewController:report animated:true];
     */
    SalesViewController *sales = [[SalesViewController alloc] init];
//    sales.hidesBottomBarWhenPushed = true;
    [self.navigationController pushViewController:sales animated:true];
}

- (void)jump2History{
    HistoryViewController *history = [[HistoryViewController alloc] init];
    history.hidesBottomBarWhenPushed = true;
    [self.navigationController pushViewController:history animated:true];
}
#pragma mark
#pragma mark -- bottom
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

- (void)timeViewChooseTimeBlock:(UIButton *)btn{
    DLog(@"btn == %@",btn);
}
- (void)timeViewBtnDidClickedBlock:(UIButton *)btn{
    DLog(@"btn == %@",btn);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
