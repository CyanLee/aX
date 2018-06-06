//
//  MineViewController.m
//  商速老板助手
//
//  Created by 赵宁 on 2018/4/26.
//  Copyright © 2018年 luyonghao. All rights reserved.
//

#import "MineViewController.h"
#import "LoginViewController.h"
#import "NavViewController.h"
@interface MineViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView *tableView;

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"个人中心";
    [self createTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createTableView{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight) style:UITableViewStylePlain];
    [self.view addSubview:tableView];
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    tableView.tableFooterView = [UIView new];
    self.tableView = tableView;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = @"退出登录";
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSUserDefaults *def =  [NSUserDefaults standardUserDefaults];
   // [def setObject:nil forKey:@"UserModel"];
   // [def synchronize];
    [def removeObjectForKey:@"UserModel"];
    //[def synchronize];
    [SVProgressHUD showSuccessWithStatus:@"退出成功"];
    [self presentViewController:[[NavViewController alloc] initWithRootViewController: [LoginViewController new]] animated:YES completion:nil];
}

@end
