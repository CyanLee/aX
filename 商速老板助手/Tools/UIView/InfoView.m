//
//  InfoView.m
//  商速老板助手
//
//  Created by 赵宁 on 2018/5/3.
//  Copyright © 2018年 luyonghao. All rights reserved.
//

#import "InfoView.h"

@interface InfoView ()

@property (nonatomic,weak)UIView *graphView;
@end

@implementation InfoView

- (instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = DefineRedColor;
        
        /// 今日营业额
        UILabel *turnoverTip = [[UILabel alloc]init];
        [self addSubview:turnoverTip];
        turnoverTip.text = @"今日营业额 :";
        turnoverTip.font = [UIFont systemFontOfSize:10];
        turnoverTip.textAlignment = 0;
        turnoverTip.textColor = [UIColor whiteColor];
        [turnoverTip mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(40);
            make.top.mas_offset(20);
        }];
        
        UILabel *turnover = [[UILabel alloc]init];
        [self addSubview:turnover];
        turnover.text = @"168888";
        turnover.font = [UIFont systemFontOfSize:40];
        turnover.textAlignment = 0;
        turnover.textColor = [UIColor whiteColor];
        [turnover mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(turnoverTip.mas_right).mas_offset(3);
            make.centerY.equalTo(turnoverTip);
        }];
        
        
        /// 今日收单数
        UILabel *receiptTip = [[UILabel alloc]init];
        [self addSubview:receiptTip];
        receiptTip.text = @"今日收单数 :";
        receiptTip.font = [UIFont systemFontOfSize:10];
        receiptTip.textAlignment = 0;
        receiptTip.textColor = [UIColor whiteColor];
        [receiptTip mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(turnoverTip);
            make.top.mas_offset(65);
        }];

        UILabel *receipt = [[UILabel alloc]init];
        [self addSubview:receipt];
        receipt.text = @"168888";
        receipt.font = [UIFont systemFontOfSize:40];
        receipt.textAlignment = 0;
        receipt.textColor = [UIColor whiteColor];
        [receipt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(receiptTip.mas_right).mas_offset(3);
            make.centerY.equalTo(receiptTip);
        }];
        
        /// 店铺报告 && 历史数据
        UIButton *reportBtn = [[UIButton alloc]init];
        [self addSubview:reportBtn];
        [reportBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(receiptTip);
            make.right.equalTo(self.mas_centerX).mas_offset(-12);
            make.height.mas_equalTo(30);
            make.top.mas_equalTo(65+40);
        }];
        reportBtn.backgroundColor = [UIColor whiteColor];
        reportBtn.layer.cornerRadius = 15;
        reportBtn.layer.masksToBounds = true;
        [reportBtn setTitle:@"店铺报告" forState:0];
        [reportBtn setTitleColor:DefineRedColor forState:0];
        reportBtn.titleLabel.font = [UIFont systemFontOfSize:11];
        [reportBtn addTarget:self action:@selector(reportBtnDidClicked) forControlEvents:1<<6];
        
        
        UIButton *historyBtn = [[UIButton alloc]init];
        [self addSubview:historyBtn];
        [historyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_centerX).mas_offset(18);
            make.height.width.centerY.equalTo(reportBtn);
        }];
        historyBtn.backgroundColor = [UIColor whiteColor];
        historyBtn.layer.cornerRadius = 15;
        historyBtn.layer.masksToBounds = true;
        [historyBtn setTitle:@"历史数据" forState:0];
        [historyBtn setTitleColor:DefineRedColor forState:0];
        historyBtn.titleLabel.font = [UIFont systemFontOfSize:11];
        [historyBtn addTarget:self action:@selector(historyBtnDidClicked) forControlEvents:1<<6];
        
        
        /// 营业额 && 收单数
//        UIButton *repBtn = [[UIButton alloc]init];
//        [self addSubview:repBtn];
//        [repBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(receiptTip);
//            make.right.equalTo(self.mas_centerX).mas_offset(-12);
//            make.height.mas_equalTo(30);
//            make.top.mas_equalTo(65+40);
//        }];
//        repBtn.backgroundColor = [UIColor whiteColor];
//        repBtn.layer.cornerRadius = 15;
//        repBtn.layer.masksToBounds = true;
//        [repBtn setTitle:@"店铺报告" forState:0];
//        [repBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
//        repBtn.titleLabel.font = [UIFont systemFontOfSize:11];
//        [repBtn addTarget:self action:@selector(reportBtnDidClicked) forControlEvents:1<<6];
        
        /// 曲线图
        UIView *graph = [[UIView alloc]init];
        [self addSubview:graph];
        graph.backgroundColor = [UIColor whiteColor];
       // graph.backgroundColor = self.backgroundColor;
        [graph mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.left.right.equalTo(self);
            make.height.equalTo(self).multipliedBy(0.3);
        }];
    }
    return self;
}

- (void)reportBtnDidClicked{
    if (self.reportBtnBlock) {
        self.reportBtnBlock();
    }
}
- (void)historyBtnDidClicked{
    if (self.historyBtnBlock) {
        self.historyBtnBlock();
    }
}
@end
