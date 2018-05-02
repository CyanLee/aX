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
@interface LoginViewController ()
@property (nonatomic,weak)CoverView *cover;
@property (nonatomic,weak)UIView *logoView;
@property (nonatomic,weak)UIView *nameView;
@property (nonatomic,weak)UIView *pswView;
@property (nonatomic,weak)UIButton *forgetBtn;
@property (nonatomic,weak)UIButton *loginBtn;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didClickKeyboard:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didKboardDisappear:) name:UIKeyboardWillHideNotification object:nil];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupCover];
    
    [self setupLogoView];
    
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
    UIView *logo = [[UIView alloc] init];
    [self.cover addSubview:logo];
    logo.backgroundColor = DefineRedColor;
    [logo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.cover);
        make.width.mas_equalTo(120);
        make.top.mas_equalTo(68);
        make.height.mas_equalTo(160);
    }];
    self.logoView = logo;
}

- (void)setupNameView{
    UIView *name = [[UIView alloc] init];
    [self.cover addSubview:name];
    [name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(8);
        make.right.mas_equalTo(-8);
        make.top.equalTo(self.logoView.mas_bottom).mas_offset(30);
        make.height.mas_equalTo(44);
    }];
    self.nameView = name;
    
    UIImageView *tip = [[UIImageView alloc]init];
    [self.nameView addSubview:tip];
    [tip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(5);
        make.centerY.equalTo(self.nameView);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(30);
    }];
    tip.backgroundColor = DefineRedColor;
    
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
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(30);
    }];
    tip.backgroundColor = DefineRedColor;
    
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
    
    //!!!!!
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:@"866955030036774" forKey:@"deviceID"];
    [dic setObject:@"bkl1321809lmk" forKey:@"userPwd"];
    [dic setObject:@"13922190717" forKey:@"userId"];
    [NetTools POST:ip parameters:dic success:^(id responseObject) {
        TabController *tab = [[TabController alloc]init];
        UIWindow *key = [[UIApplication sharedApplication] keyWindow];
        key.rootViewController = tab;
    } failure:^(NSString *errStr) {
        DLog(@"errStr == %@",errStr);
    }];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}












- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
