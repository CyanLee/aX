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
#import "APP_IPS.h"
#import "UserModel.h"
#import "NSBundle+Language.h"

@interface ForgetViewController ()
@property (nonatomic,weak)CoverView *cover;
@property (nonatomic,weak)UIView *tfView;
@property (nonatomic,weak)UIButton *confirmBtn;
@property (nonatomic,weak)UIButton *getCode;
@property (nonatomic,weak)UITextField *phoneTf;
@property (nonatomic,weak)UITextField *codeTf;
@property (nonatomic,weak)UITextField *pwsTf;
@property (nonatomic,weak)UITextField *againTf;
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
    self.navigationController.navigationBarHidden = false;
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
    phone.text = NSLocalized(@"Mobile phone number", nil);
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
    phoneTf.placeholder = NSLocalized(@"enter your ID", nil);
    phoneTf.textAlignment = 0;
    phoneTf.font = [UIFont systemFontOfSize:13];
    phoneTf.keyboardType = UIKeyboardTypeNumberPad;
    self.phoneTf = phoneTf;
    
    
    //<
    UILabel *code = [[UILabel alloc]init];
    [self.tfView addSubview:code];
    [code mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(5);
        make.top.equalTo(phoneTf.mas_bottom).mas_equalTo(15);
    }];
    code.text = NSLocalized(@"Verification Code", nil);
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
    codeTf.keyboardType = UIKeyboardTypeNumberPad;
    self.codeTf = codeTf;
    
    UIButton *getCode = [[UIButton alloc]init];
    [self.tfView addSubview:getCode];
    [getCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(codeTf);
        make.right.equalTo(self.tfView).mas_offset(-20);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(80);
    }];
    [getCode setTitle:NSLocalized(@"get Identify code", nil) forState:0];
    getCode.titleLabel.font = [UIFont systemFontOfSize:10];
    getCode.backgroundColor = [UIColor colorWithRed:155.0/255.0 green:155.0/255.0 blue:155.0/255.0 alpha:1];
    [getCode setTitleColor:[UIColor whiteColor] forState:0];
    [getCode addTarget:self action:@selector(getCodeDidClicked) forControlEvents:1<<6];
    self.getCode = getCode;
    
    //<
    UILabel *pws = [[UILabel alloc]init];
    [self.tfView addSubview:pws];
    [pws mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(5);
        make.top.equalTo(codeTf.mas_bottom).mas_equalTo(15);
    }];
    pws.text = NSLocalized(@"new password", nil);
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
    pwsTf.secureTextEntry = true;
    //pwsTf.keyboardType = UIKeyboardTypeNumberPad;
    self.pwsTf = pwsTf;
    
    //<
    UILabel *pwsAgain = [[UILabel alloc]init];
    [self.tfView addSubview:pwsAgain];
    [pwsAgain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(5);
        make.top.equalTo(pwsTf.mas_bottom).mas_equalTo(15);
    }];
    pwsAgain.text = NSLocalized(@"confirm password", nil);
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
    againTf.secureTextEntry = true;
    //againTf.keyboardType = UIKeyboardTypeNumberPad;
    self.againTf = againTf;
    
    //<
    UIButton *btn = [[UIButton alloc]init];
    [self.tfView addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.tfView);
        make.bottom.equalTo(self.tfView);
        make.height.mas_equalTo(40);
    }];
    [btn setTitle:NSLocalized(@"confirm", nil) forState:0];
    btn.layer.cornerRadius = 12;
    btn.layer.masksToBounds = true;
    btn.backgroundColor = DefineRedColor;
    [btn setTitleColor:[UIColor whiteColor] forState:0];
    btn.titleLabel.font = [UIFont systemFontOfSize:17];
    [btn addTarget:self action:@selector(confirmBtnDidClicked) forControlEvents:1<<6];
    self.confirmBtn = btn;
}

- (void)getCodeDidClicked{
    DLog(@"%s",__func__);
    NSString *phone = self.phoneTf.text;
    if (phone.length == 0 || [phone isEqualToString:@""]){
        [SVProgressHUD showErrorWithStatus:NSLocalized(@"enter your ID", nil)];
        return;
    }
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:phone forKey:@"TelNo"];
    [dic setObject:@"86" forKey:@"AreaCode"];
    [NetTools POST:APP_CODE_URL parameters:dic success:^(id responseObject) {
        [SVProgressHUD showSuccessWithStatus:@"验证码已发送"];
        DLog(@"responseObject == %@",responseObject);
    } failure:^(NSString *errStr) {
        [SVProgressHUD showErrorWithStatus:errStr];
    }];
}

- (void)confirmBtnDidClicked{
    DLog(@"%s",__func__);
    
    NSString *phone = self.phoneTf.text;
    if (phone.length == 0 || [phone isEqualToString:@""]){
        [SVProgressHUD showErrorWithStatus:NSLocalized(@"enter your ID", nil)];
        return;
    }
    
    NSString *code = self.codeTf.text;
    if (code.length == 0 || [code isEqualToString:@""]){
        [SVProgressHUD showErrorWithStatus:@"请输入验证码"];
        return;
    }
    
    NSString *pws = self.pwsTf.text;
    if (pws.length == 0 || [pws isEqualToString:@""]){
        [SVProgressHUD showErrorWithStatus:@"请输入新密码"];
        return;
    }
    
    NSString *pwsAgain = self.againTf.text;
    if (pwsAgain.length == 0 || [pwsAgain isEqualToString:@""]){
        [SVProgressHUD showErrorWithStatus:@"请确认新密码"];
        return;
    }
    
    if (![pws isEqualToString:pwsAgain]) {
        [SVProgressHUD showErrorWithStatus:@"请确认密码是否一致"];
        return;
    }
    
   // UserModel *userModel = [UserModel getUserModel];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:phone forKey:@"userId"];
    [dic setObject:phone forKey:@"telNo"];
    [dic setObject:code forKey:@"identCode"];
    [dic setObject:pws forKey:@"newPwd"];
    [SVProgressHUD showWithStatus:NSLocalized(@"", nil)];
//    13922190717
    [NetTools POST:APP_FORGET_PWS_URLF parameters:dic success:^(id responseObject) {
        NSLog(@"responseObject====%@",responseObject);
        [SVProgressHUD dismiss];
        [SVProgressHUD showSuccessWithStatus:@"修改成功"];
        [self.navigationController popViewControllerAnimated:true];
    } failure:^(NSString *errStr) {
        DLog(@"errStr == %@",errStr);
        [SVProgressHUD showErrorWithStatus:errStr];
    }];

    
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
