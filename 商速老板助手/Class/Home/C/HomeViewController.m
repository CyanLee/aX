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
#import "ChooseStoreViewController.h"

#import "HistoryModel.h"
@interface HomeViewController ()
@property (nonatomic,weak)UIView *headerView;
@property (nonatomic,weak)UIButton *storeBtn;
@property (nonatomic,weak)UIButton *languageBtn;
@property (nonatomic,weak)UIButton *chooseBtn;
@property (nonatomic,weak)TimeView *timeView;
@property (nonatomic,weak)InfoView *infoView;
@property (nonatomic, strong)SelectPhotoManager *photoManager;

@property (nonatomic,assign)BOOL gettingGraphViewDatas;
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
    /// 获得曲线图数据
    self.gettingGraphViewDatas = true;
    [self getGraphViewDatas:4];
}
/*
 byType
 日 = 1
 周 = 1
 月 = 1
 年 = 1
 */
/// 获得曲线图数据
- (void)getGraphViewDatas:(NSInteger)byType{
    UserModel *user = [UserModel getUserModel];
   // NSString *numsPage = [NSString stringWithFormat:@"%ld",(long)self.maxPage];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[NSString stringWithFormat:@"%ld",byType] forKey:@"countType"];
    [dic setObject:user.userId forKey:@"userId"];
    [dic setObject:@"139221907171001" forKey:@"merchantCode"];
    [dic setObject:@"2018-01-05" forKey:@"startDate"];
    [dic setObject:@"2018-03-31" forKey:@"endDate"];
    [dic setObject:@"1" forKey:@"curPageNo"];
    [dic setObject:@"1000000000" forKey:@"numsPage"];
    [NetTools POST:APP_HISTORY_URL parameters:dic success:^(id responseObject) {
        /// 取最新的7个
        self.gettingGraphViewDatas = false;
        NSArray *resultList = [responseObject objectForKey:@"resultList"];
        NSMutableArray *models = [HistoryModel mj_objectArrayWithKeyValuesArray:resultList];
        NSInteger len = 7;
        NSInteger form = models.count - 7;
        if (models.count < 7) {
            len = models.count;
            form = 0;
        }
        NSArray *smallArray = [models subarrayWithRange:NSMakeRange(form, len)];
        self.infoView.graphViewModels = [NSMutableArray arrayWithArray:smallArray];
        self.timeView.models = [NSMutableArray arrayWithArray:smallArray];
    } failure:^(NSString *errStr) {
        self.gettingGraphViewDatas = false;
        [SVProgressHUD showErrorWithStatus:errStr];
    }];
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
    [btn setTitle:NSLocalized(@"choose Merchant",nil) forState:0];
    [btn setTitleColor:[UIColor whiteColor] forState:0];
    btn.titleLabel.font = [UIFont systemFontOfSize:10];
    btn.layer.cornerRadius = 4;
    btn.layer.masksToBounds = true;
    btn.layer.borderWidth = 1;
    btn.layer.borderColor = [[UIColor whiteColor] CGColor];
    [btn addTarget:self action:@selector(jump2ChooseStore) forControlEvents:1<<6];
    self.chooseBtn = btn;
}

- (void)jump2ChooseStore{
    ChooseStoreViewController *choose = [[ChooseStoreViewController alloc]init];
    choose.hidesBottomBarWhenPushed = true;
    [self.navigationController pushViewController:choose animated:true];
}

-(void)setupStoreBtn{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor whiteColor];
    if (UD_GET_OBJ(@"headerImage") == nil) {
        [btn setImage:[UIImage imageNamed:@"老板助手"] forState:UIControlStateNormal];
    }else{
        [btn setImage:[UIImage imageWithData:UD_GET_OBJ(@"headerImage")] forState:UIControlStateNormal];
    }
    [self.headerView addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.left.mas_equalTo(self.headerView).offset(13);
        make.height.mas_equalTo(35);
        make.width.mas_equalTo(35);
    }];
    btn.layer.cornerRadius = 17.5;
    btn.layer.masksToBounds = true;
    [btn addTarget:self action:@selector(storeBtnDidClicked) forControlEvents:1<<6];
    self.storeBtn = btn;
    
    UILabel *label = [[UILabel alloc]init];
    [self.headerView addSubview:label];
    label.text = NSLocalized(@"change logo",nil);
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
    [btn setTitle:NSLocalized(@"language",nil) forState:0];
    [btn setTitleColor:DefineRedColor forState:0];
    btn.titleLabel.font = [UIFont systemFontOfSize:10];
    btn.layer.cornerRadius = 17.5;
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
    if (!_photoManager) {
        _photoManager =[[SelectPhotoManager alloc]init];
    }
    [_photoManager startSelectPhotoWithImageName:@"选择头像"];
    __weak typeof(self)mySelf=self;
    //选取照片成功
    _photoManager.successHandle=^(SelectPhotoManager *manager,UIImage *image){
        [mySelf.storeBtn setImage:image forState:UIControlStateNormal];
        //保存到本地
        NSData *data = UIImagePNGRepresentation(image);
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"headerImage"];
        
        //使用MD5对设备码进行加密
        UserModel *userModel = [UserModel getUserModel];
        NSString *result = [MD5Tools md5:[GSKeyChainDataManager readUUIDkey:@"deviceId"]];
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setValue:result forKey:@"deviceId"];
        [dic setValue:@"open" forKey:@"imgflag"];
        [dic setValue:@"" forKey:@"nickName"];
        [dic setValue:userModel.userId forKey:@"userId"];
        
        NSString *str = [NetTools dictionaryToJson:dic];
        NSString *utf = [APP_UPLOAD_THE_PICTURE_URL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [NetTools POST:utf parameters:dic imageData:data constructingBodyWithBlocksuccess:^(id responseObject) {
            NSLog(@"responseObject = %@",responseObject);
        } failure:^(NSString *errStr) {
            NSLog(@"errStr = %@",errStr);
        }];
        
    };
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
    if (self.gettingGraphViewDatas)return;
    [self getGraphViewDatas:btn.tag+1];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
