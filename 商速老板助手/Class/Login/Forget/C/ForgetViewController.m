//
//  ForgetViewController.m
//  商速老板助手
//
//  Created by 赵宁 on 2018/4/28.
//  Copyright © 2018年 luyonghao. All rights reserved.
//

#import "ForgetViewController.h"
#import "CoverView.h"
#import "TabController.h"
@interface ForgetViewController ()
@property (nonatomic,weak)CoverView *cover;
@property (nonatomic,weak)UIView *tfView;
@property (nonatomic,weak)UIButton *confirmBtn;
@end

@implementation ForgetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didClickKeyboard:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didKboardDisappear:) name:UIKeyboardWillHideNotification object:nil];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupCover];
    
    [self setupTFView];
    
    [self tfViewAddSubView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = true;
}

- (void)setupTFView{
    UIView *tf = [[UIView alloc]init];
    [self.cover addSubview:tf];
    [tf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(68);
        make.centerX.equalTo(self.cover);
        make.left.mas_offset(8);
        make.height.mas_equalTo(180);
    }];
    self.tfView = tf;
}

- (void)tfViewAddSubView{
    //<
    UILabel *phone = [[UILabel alloc]init];
    [self.tfView addSubview:phone];
    [phone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(5);
        make.top.mas_equalTo(8);
    }];
    phone.text = @"手机号码";
    phone.textAlignment = 0;
    phone.font = [UIFont systemFontOfSize:13];
    phone.textColor = [UIColor colorWithRed:76.0/255 green:76.0/255 blue:76.0/255 alpha:1];
    
    UITextField *phoneTf = [[UITextField alloc]init];
    [self.tfView addSubview:phoneTf];
    [phoneTf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(80);
        make.bottom.centerY.equalTo(phone);
        make.right.equalTo(self.tfView).mas_offset(-5);
    }];
    phoneTf.placeholder = @"请输入手机号码";
    phoneTf.textAlignment = 0;
    phoneTf.font = [UIFont systemFontOfSize:13];
    
    //<
    UILabel *code = [[UILabel alloc]init];
    [self.tfView addSubview:code];
    [code mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(5);
        make.top.equalTo(phoneTf.mas_bottom).mas_equalTo(15);
    }];
    code.text = @"验证码";
    code.textAlignment = 0;
    code.font = [UIFont systemFontOfSize:13];
    code.textColor = [UIColor colorWithRed:76.0/255 green:76.0/255 blue:76.0/255 alpha:1];
    
    UITextField *codeTf = [[UITextField alloc]init];
    [self.tfView addSubview:codeTf];
    [codeTf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(80);
        make.bottom.centerY.equalTo(code);
        make.right.equalTo(self.tfView).mas_offset(-5);
    }];
    codeTf.placeholder = @"请输入验证码";
    codeTf.textAlignment = 0;
    codeTf.font = [UIFont systemFontOfSize:13];
    
    //<
    UILabel *pws = [[UILabel alloc]init];
    [self.tfView addSubview:pws];
    [pws mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(5);
        make.top.equalTo(codeTf.mas_bottom).mas_equalTo(15);
    }];
    pws.text = @"新密码";
    pws.textAlignment = 0;
    pws.font = [UIFont systemFontOfSize:13];
    pws.textColor = [UIColor colorWithRed:76.0/255 green:76.0/255 blue:76.0/255 alpha:1];
    
    UITextField *pwsTf = [[UITextField alloc]init];
    [self.tfView addSubview:pwsTf];
    [pwsTf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(80);
        make.bottom.centerY.equalTo(pws);
        make.right.equalTo(self.tfView).mas_offset(-5);
    }];
    pwsTf.placeholder = @"请输入新密码";
    pwsTf.textAlignment = 0;
    pwsTf.font = [UIFont systemFontOfSize:13];
    
    
    //<
    UILabel *pwsAgain = [[UILabel alloc]init];
    [self.tfView addSubview:pwsAgain];
    [pwsAgain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(5);
        make.top.equalTo(pwsTf.mas_bottom).mas_equalTo(15);
    }];
    pwsAgain.text = @"确认密码";
    pwsAgain.textAlignment = 0;
    pwsAgain.font = [UIFont systemFontOfSize:13];
    pwsAgain.textColor = [UIColor colorWithRed:76.0/255 green:76.0/255 blue:76.0/255 alpha:1];
    
    UITextField *againTf = [[UITextField alloc]init];
    [self.tfView addSubview:againTf];
    [againTf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(80);
        make.bottom.centerY.equalTo(pwsAgain);
        make.right.equalTo(self.tfView).mas_offset(-5);
    }];
    againTf.placeholder = @"请确认新密码";
    againTf.textAlignment = 0;
    againTf.font = [UIFont systemFontOfSize:13];
    
    //<
    UIButton *btn = [[UIButton alloc]init];
    [self.tfView addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.tfView);
        make.bottom.equalTo(self.tfView);
        make.height.mas_equalTo(40);
    }];
    [btn setTitle:@"确 定" forState:0];
    btn.layer.cornerRadius = 12;
    btn.layer.masksToBounds = true;
    btn.backgroundColor = DefineRedColor;
    [btn setTitleColor:[UIColor whiteColor] forState:0];
    btn.titleLabel.font = [UIFont systemFontOfSize:17];
    [btn addTarget:self action:@selector(confirmBtnDidClicked) forControlEvents:1<<6];
    self.confirmBtn = btn;
}

- (void)confirmBtnDidClicked{
    DLog(@"%s",__func__);
    TabController *tab = [[TabController alloc]init];
    UIWindow *key = [[UIApplication sharedApplication] keyWindow];
    key.rootViewController = tab;
}

- (void)didClickKeyboard:(NSNotification *)noti{
//    [self.cover mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.bottom.equalTo(self.view);
//        make.top.mas_offset(-88);
//    }];
//    [self.view layoutIfNeeded];
}

- (void)didKboardDisappear:(NSNotification *)noti{
//    [self.cover mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.top.bottom.equalTo(self.view);
//    }];
//    [self.view layoutIfNeeded];
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
        [ws.cover endEditing:true];
    }];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
