//
//  LanguageViewController.m
//  商速老板助手
//
//  Created by 赵宁 on 2018/5/4.
//  Copyright © 2018年 luyonghao. All rights reserved.
//

#import "LanguageViewController.h"
#import "LanguageCell.h"

@interface LanguageViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArr;


@end

@implementation LanguageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"语言";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupData];
    [self setupTableView];
    
}

-(void)setupData{
    self.dataArr = [[NSMutableArray alloc] initWithObjects:@"跟随系统",@"中文简体",@"中文繁体",@"英语",@"日语", nil];
}

-(void)setupTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[LanguageCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.sectionHeaderHeight = 0.01;
    self.tableView.sectionFooterHeight = 10;
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    [self.view addSubview:self.tableView];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArr.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LanguageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.titleLabel.text = [self.dataArr objectAtIndex:indexPath.section];
    return cell;
}

- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = false;
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBarHidden = true;
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
