//
//  LoginViewController.m
//  商速老板助手
//
//  Created by 赵宁 on 2018/4/27.
//  Copyright © 2018年 luyonghao. All rights reserved.
//

#import "LoginViewController.h"
#import "ForgetViewController.h"
#import "CoverView.h"
#import "TabController.h"
#import "HistoryViewController.h"
#import "SalesViewController.h"

@interface LoginViewController ()
@property (nonatomic,weak)CoverView *cover;
@property (nonatomic,weak)UIImageView *logoView;
@property (nonatomic,weak)UILabel *duoLabel;
@property (nonatomic,weak)UILabel *bossLabel;
@property (nonatomic,weak)UIView *nameView;
@property (nonatomic,weak)UIView *pswView;
@property (nonatomic,weak)UIButton *forgetBtn;
@property (nonatomic,weak)UIButton *loginBtn;

@property (nonatomic,weak)UITextField *nameTF;
@property (nonatomic,weak)UITextField *pwsTF;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    //键盘动画
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didClickKeyboard:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didKboardDisappear:) name:UIKeyboardWillHideNotification object:nil];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupCover];
    
    [self setupLogoView];
    
    [self setupLabel];
    
    [self setupNameView];
    
    [self setupPswView];
    
    [self setupForgetBtn];
    
    [self setupLoginBtn];
}

- (void)setupCover{
    CoverView *cover = [[CoverView alloc]init];
    [self.view addSubview:cover];
    [cover mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view);
    }];
    self.cover = cover;
    cover.backgroundColor = [UIColor whiteColor];
    __weak typeof(self) ws = self;
    [self.cover setTouchBegin:^{
        //x
        [ws.cover endEditing:true];
    }];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = true;
}


- (void)didClickKeyboard:(NSNotification *)noti{
    [self.cover mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.mas_offset(-88);
    }];
    [self.view layoutIfNeeded];
}

- (void)didKboardDisappear:(NSNotification *)noti{
    [self.cover mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view);
    }];
    [self.view layoutIfNeeded];
}
- (void)setupLogoView{
    UIImageView *logo = [[UIImageView alloc] init];
    [self.cover addSubview:logo];
    [logo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.cover);
        make.width.mas_equalTo(80);
        make.top.mas_equalTo(68);
        make.height.mas_equalTo(120);
    }];
    logo.image = [UIImage imageNamed:@"老板助手"];
    self.logoView = logo;
}

- (void)setupLabel{
    UILabel *duo = [[UILabel alloc] init];
    [self.cover addSubview:duo];
    [duo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.cover);
        make.top.mas_equalTo(self.logoView.mas_bottom).offset(15);
    }];
    duo.text = @"收多多";
    duo.font = [UIFont systemFontOfSize:19.0f];
    duo.textColor = DefineRedColor;
    self.duoLabel = duo;
    
    UILabel *boss = [[UILabel alloc] init];
    [self.cover addSubview:boss];
    [boss mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.cover);
        make.top.mas_equalTo(self.duoLabel.mas_bottom).offset(15);
    }];
    boss.text = @"老板助手";
    boss.font = [UIFont systemFontOfSize:25.0f];
    boss.textColor = DefineRedColor;
    self.bossLabel = boss;
    
}

- (void)setupNameView{
    UIView *name = [[UIView alloc] init];
    [self.cover addSubview:name];
    [name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(8);
        make.right.mas_equalTo(-8);
        make.top.equalTo(self.bossLabel.mas_bottom).mas_offset(30);
        make.height.mas_equalTo(44);
    }];
    self.nameView = name;
    
    UIImageView *tip = [[UIImageView alloc]init];
    [self.nameView addSubview:tip];
    [tip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(5);
        make.centerY.equalTo(self.nameView);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(30);
    }];
//    tip.backgroundColor = DefineRedColor;
    tip.image = [UIImage imageNamed:@"20180503老板助手手机"];
    
    UITextField *tf = [[UITextField alloc]init];
    [self.nameView addSubview:tf];
    [tf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(tip.mas_right).mas_offset(8);
        make.centerY.equalTo(self.nameView);
        make.right.equalTo(self.nameView).mas_offset(-8);
        make.height.mas_equalTo(30);
    }];
    tf.placeholder = @" 请输入用户名";
    tf.textAlignment = 0;
    self.nameTF = tf;
}

- (void)setupPswView{
    UIView *psw = [[UIView alloc] init];
    [self.cover addSubview:psw];
    [psw mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(8);
        make.right.mas_equalTo(-8);
        make.top.equalTo(self.nameView.mas_bottom).mas_offset(10);
        make.height.mas_equalTo(44);
    }];
    self.pswView = psw;
    //wde
    UIImageView *tip = [[UIImageView alloc]init];
    [self.pswView addSubview:tip];
    [tip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(5);
        make.centerY.equalTo(self.pswView);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(30);
    }];
//    tip.backgroundColor = DefineRedColor;
    tip.image = [UIImage imageNamed:@"20180503老板助手锁"];
    
    UITextField *tf = [[UITextField alloc]init];
    [self.pswView addSubview:tf];
    [tf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(tip.mas_right).mas_offset(8);
        make.centerY.equalTo(self.pswView);
        make.right.equalTo(self.pswView).mas_offset(-8);
        make.height.mas_equalTo(30);
    }];
    tf.placeholder = @" 请输入密码";
    tf.textAlignment = 0;
    self.pwsTF = tf;
}

- (void)setupForgetBtn{
    UIButton *btn = [[UIButton alloc]init];
    [self.cover addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameView);
        make.top.equalTo(self.pswView.mas_bottom).mas_offset(5);
        make.height.mas_offset(24);
        make.width.mas_equalTo(80);
    }];
    [btn setTitle:@"忘记密码?" forState:0];
    [btn setTitleColor:[UIColor colorWithRed:155.0/255.0 green:155.0/255.0 blue:155.0/255.0 alpha:155.0/255.0] forState:0];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    [btn addTarget:self action:@selector(forgetDidClicked) forControlEvents:1<<6];
    self.forgetBtn = btn;
}

- (void)forgetDidClicked{
    DLog(@"%s",__func__);
    ForgetViewController *forget = [[ForgetViewController alloc] init];
    [self.navigationController pushViewController:forget animated:true];
    
}
- (void)setupLoginBtn{
    UIButton *btn = [[UIButton alloc]init];
    [self.cover addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.cover).mas_offset(8);
        make.top.equalTo(self.forgetBtn.mas_bottom).mas_offset(8);
        make.right.mas_offset(-8);
        make.height.mas_equalTo(40);
    }];
    [btn setTitle:@"登 录" forState:0];
    btn.layer.cornerRadius = 12;
    btn.layer.masksToBounds = true;
    btn.backgroundColor = DefineRedColor;
    [btn setTitleColor:[UIColor whiteColor] forState:0];
    btn.titleLabel.font = [UIFont systemFontOfSize:17];
    [btn addTarget:self action:@selector(loginDidClicked) forControlEvents:1<<6];
    self.loginBtn = btn;
}

- (void)loginDidClicked{
    DLog(@"%s",__func__);
    
    /*
    NSString *name = self.nameTF.text;
    if (name.length == 0 || [name isEqualToString:@""]){
        [SVProgressHUD showErrorWithStatus:@"请输入用户名"];
        return;
    }
    
    NSString *pws = self.pwsTF.text;
    if (pws.length == 0 || [pws isEqualToString:@""]){
        [SVProgressHUD showErrorWithStatus:@"请输入密码"];
     return;
     }
     */
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:@"866955030036774" forKey:@"deviceID"];
    [dic setObject:@"bkl1321809lmk" forKey:@"userPwd"];
    [dic setObject:@"13922190717" forKey:@"userId"];
    [SVProgressHUD showWithStatus:@"正在登录"];
    [NetTools POST:ip parameters:dic success:^(id responseObject) {
        [SVProgressHUD dismiss];
                TabController *tab = [[TabController alloc]init];
                UIWindow *key = [[UIApplication sharedApplication] keyWindow];
                key.rootViewController = tab;
//        UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:[HistoryViewController new]];
//        navi.navigationBarHidden = YES;
//        navi.navigationBar.shadowImage = [UIImage new];
//        UIWindow *key = [[UIApplication sharedApplication] keyWindow];
//        key.rootViewController = navi;
    } failure:^(NSString *errStr) {
        DLog(@"errStr == %@",errStr);
        [SVProgressHUD showErrorWithStatus:errStr];
    }];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
