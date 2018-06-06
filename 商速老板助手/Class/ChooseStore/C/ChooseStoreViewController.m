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

#import "UserModel.h"
#import "LanguageCell.h"

@interface ChooseStoreViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,weak)UITableView *tab;

@property (nonatomic,assign)NSInteger maxPage;

@property (nonatomic,strong)NSMutableArray *datas;

@property (nonatomic,strong) ChooseStoreModel *selectModel;

@end

@implementation ChooseStoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"选择店铺";
    
    self.maxPage = MaxPage;
    
    NSDictionary *Mdic = UD_GET_OBJ(@"merchant");
    if (Mdic) {
        self.selectModel = [ChooseStoreModel mj_objectWithKeyValues:Mdic];
    }
    
    [self setupTab];
    
    [self getDatas];
    
    [self addRightNavItemWithTitle:NSLocalized(@"save", nil) withSel:@selector(sett:)];
}


//添加导航右按键 与 点击事件 文字
-(UIButton *)addRightNavItemWithTitle:(NSString *)title withSel:(SEL)selectorAction{
    UIButton * rightBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 50, 20);
    [rightBtn setContentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -10)];
    rightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    rightBtn.titleLabel.font =[UIFont systemFontOfSize:17];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:0];
    [rightBtn setTitle:title forState:UIControlStateNormal];
    [rightBtn addTarget:self action:selectorAction forControlEvents:UIControlEventTouchUpInside];
    // [rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    //配置返回按钮距离屏幕边缘的距离
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spaceItem.width = 0;
    self.navigationItem.rightBarButtonItems = @[spaceItem, backItem];
    return rightBtn;
}

- (void)getDatas{
    
    UserModel *user = [UserModel getUserModel];
    if (!user) {
        // 没登录
        return;
    }
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    dic[@"userId"] = user.userId;
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
    self.selectModel = self.datas[indexPath.row];
    [self.tab reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LanguageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChooseStoreViewController"];
    if (!cell) {
        cell = [[LanguageCell alloc] initWithStyle:0 reuseIdentifier:@"ChooseStoreViewController"];
    }
    ChooseStoreModel *model = self.datas[indexPath.row];
    if (self.selectModel) {
        if (model.merchantCode.integerValue == self.selectModel.merchantCode.integerValue) {
            cell.clickBtn.hidden = NO;
        }else{
            cell.clickBtn.hidden = YES;
        }
    }else{
        cell.clickBtn.hidden = YES;
    }
    cell.titleLabel.text = model.merchantName;
    cell.titleLabel.font = [UIFont systemFontOfSize:15];
    cell.titleLabel.textColor = [UIColor colorWithRed:56.0/255.0 green:56.0/255.0 blue:56.0/255.0 alpha:1];
    cell.selectionStyle = 0;
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

-(void)sett:(UIButton *)sender{
    if (!self.selectModel)return;
    NSString *str = self.selectModel.merchantCode;
    NSString *str2 = self.selectModel.merchantName;
    NSDictionary *dic = @{@"merchantCode":str,@"merchantName":str2};
    UD_SET_OBJ(dic, @"merchant");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"tongzhi" object:dic];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
