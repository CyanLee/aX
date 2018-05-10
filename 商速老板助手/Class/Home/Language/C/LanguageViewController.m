//
//  LanguageViewController.m
//  商速老板助手
//
//  Created by 赵宁 on 2018/5/4.
//  Copyright © 2018年 luyonghao. All rights reserved.
//

#import "LanguageViewController.h"
#import "LanguageCell.h"
#import "NSBundle+Language.h"
#import "AppDelegate.h"
#import "TabController.h"

@interface LanguageViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArr;
@property (nonatomic,strong) NSMutableArray *languageArr;
@property (nonatomic,assign) NSInteger stateNum;
@property (nonatomic,copy) NSString *chooseStr;

@end

@implementation LanguageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = NSLocalized(@"language", nil);
    self.view.backgroundColor = [UIColor whiteColor];
    [self addRightNavItemWithTitle:NSLocalized(@"save", nil) withSel:@selector(sett:)];
    [self setupData];
    [self setupTableView];
}

-(void)setupData{
    self.dataArr = [[NSMutableArray alloc] initWithObjects:NSLocalized(@"Follow system", nil),@"中文简体",@"中文繁体",@"English",@" عربي",@"Portugal",@"Français",@"ภาษาไทย",@"Tiếng Việt",@"한국어.",@"España",@"Deutsch",@"русский",@"Melayu",@"日本語", nil];
    self.languageArr = [[NSMutableArray alloc] initWithObjects:@"base",@"zh-Hans",@"zh-Hant",@"en",@"ar",@"pt",@"fr",@"th",@"vi",@"ko",@"es",@"de",@"ru",@"ms",@"ja", nil];
    
    if (UD_GET_OBJ(@"LanguageKey") == nil) {
        self.stateNum = 0;
        self.chooseStr = @"base";
    }else{
        self.chooseStr = UD_GET_OBJ(@"LanguageKey");
        for (int i = 0; i < self.languageArr.count; i++) {
            if ([self.chooseStr isEqualToString:self.languageArr[i]]) {
                self.chooseStr = self.languageArr[i];
                self.stateNum = i;
            }
        }
    }
    
}

-(void)setupTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-49) style:UITableViewStyleGrouped];
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
    
    if (indexPath.section == self.stateNum) {
        cell.clickBtn.hidden = NO;
    }else{
        cell.clickBtn.hidden = YES;
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.stateNum = indexPath.section;
    self.chooseStr = [self.languageArr objectAtIndex:indexPath.section];
    [tableView reloadData];
}



//添加导航右按键 与 点击事件 文字
-(UIButton *)addRightNavItemWithTitle:(NSString *)title withSel:(SEL)selectorAction{
    UIButton * rightBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 50, 20);
    [rightBtn setContentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -10)];
    rightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    rightBtn.titleLabel.font =[UIFont systemFontOfSize:20];
    [rightBtn setTitle:title forState:UIControlStateNormal];
    [rightBtn addTarget:self action:selectorAction forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    //配置返回按钮距离屏幕边缘的距离
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spaceItem.width = 0;
    self.navigationItem.rightBarButtonItems = @[spaceItem, backItem];
    return rightBtn;
}

-(void)sett:(UIButton *)sender{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.chooseStr forKey:@"LanguageKey"];
    [defaults synchronize];
    NSLog(@"保存保存保存保存保存---%d------%@",[defaults synchronize],self.chooseStr);
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0/*延迟执行时间*/ * NSEC_PER_SEC));
    [SVProgressHUD showWithStatus:NSLocalized(@"Saving", nil)];
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
        [NSBundle setLanguage:self.chooseStr];
        AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
        app.window.rootViewController = [TabController new];
        [SVProgressHUD dismiss];
    });
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
