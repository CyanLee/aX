//
//  SalesHeaderView.h
//  商速老板助手
//
//  Created by 今日 on 2018/5/4.
//  Copyright © 2018年 luyonghao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SalesHeaderView : UIView

//返回
@property (nonatomic,strong) UIButton *backBtn;
//改店标
@property (nonatomic,strong) UIImageView *headerView;
//店名
@property (nonatomic,strong) UILabel *titleLabel;
//店铺报告
@property (nonatomic,strong) UIButton *reportBtn;
//选择店铺
@property (nonatomic,strong) UIButton *chooseBtn;
//历史数据
@property (nonatomic,strong) UIButton *historyBtn;
//历史数据文字
@property (nonatomic,strong) UILabel *historyLabel;
//语言
@property (nonatomic,strong) UIButton *languageBtn;
//数量排名
@property (nonatomic,strong) UIButton *numRankingBtn;
//金额排名
@property (nonatomic,strong) UIButton *moneyRankingBtn;
//销售情况
@property (nonatomic,strong) UIButton *salesRankingBtn;
//汇总
@property (nonatomic,strong) UIButton *summaryBtn;
@property(nonatomic,copy)void(^backBlock)(void);
@property(nonatomic,copy)void(^click)(NSInteger);
@end
