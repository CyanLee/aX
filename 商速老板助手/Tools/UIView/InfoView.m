//
//  InfoView.m
//  商速老板助手
//
//  Created by 赵宁 on 2018/5/3.
//  Copyright © 2018年 luyonghao. All rights reserved.
//

#import "InfoView.h"
#import "GraphView.h"
#import "HistoryModel.h"
@interface InfoView ()

@property (nonatomic,weak)GraphView *graphView;
@property (nonatomic,weak)UILabel *turnover;
@property (nonatomic,weak)UILabel *receipt;
@end

@implementation InfoView

- (instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = DefineRedColor;
        /// 今日营业额
        UILabel *turnoverTip = [[UILabel alloc]init];
        [self addSubview:turnoverTip];
        turnoverTip.text = [NSString stringWithFormat:@"%@ :",NSLocalized(@"Today's turnover", nil)];
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
        self.turnover = turnover;
        
        /// 今日收单数
        UILabel *receiptTip = [[UILabel alloc]init];
        [self addSubview:receiptTip];
        receiptTip.text = [NSString stringWithFormat:@"%@ :",NSLocalized(@"Today's receipt", nil)];
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
        self.receipt = receipt;
        
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
        [reportBtn setTitle:NSLocalized(@"Merchant report", nil) forState:0];
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
        [historyBtn setTitle:NSLocalized(@"History report", nil) forState:0];
        [historyBtn setTitleColor:DefineRedColor forState:0];
        historyBtn.titleLabel.font = [UIFont systemFontOfSize:11];
        [historyBtn addTarget:self action:@selector(historyBtnDidClicked) forControlEvents:1<<6];
        
        
        /// 营业额 && 收单数
        UISegmentedControl *segmentedC = [[UISegmentedControl alloc] initWithItems:@[NSLocalized(@"Turnover", nil), NSLocalized(@"Order number", nil)]];
        [self addSubview:segmentedC];
        [segmentedC addTarget:self action:@selector(selectItem:) forControlEvents:UIControlEventValueChanged];
        segmentedC.tintColor = [UIColor whiteColor];
        segmentedC.selectedSegmentIndex = 0;
        segmentedC.layer.cornerRadius = 12;
        segmentedC.layer.borderWidth = 1;
        segmentedC.layer.masksToBounds = true;
        segmentedC.layer.borderColor = [UIColor whiteColor].CGColor;
        [segmentedC mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(receiptTip);
//            make.right.equalTo(self.mas_centerX).mas_offset(-12);
            make.centerX.mas_equalTo(0);
            make.width.equalTo(self).multipliedBy(0.8);
            make.height.mas_equalTo(35);
            make.top.mas_equalTo(65+100);
        }];
        
        /// 曲线图
        GraphView *graph = [[GraphView alloc]init];
        [self addSubview:graph];
        graph.backgroundColor = self.backgroundColor;
        [graph mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.left.right.equalTo(self);
            make.height.equalTo(self).multipliedBy(0.42);
        }];
        self.graphView = graph;
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

- (void)selectItem:(UISegmentedControl *)sender {
    if (self.segmentedCBlock) {
        self.segmentedCBlock(sender.selectedSegmentIndex);
    }
    self.graphView.showType = sender.selectedSegmentIndex;
}

- (void)setGraphViewModels:(NSMutableArray *)graphViewModels{
    _graphViewModels = graphViewModels;
    self.graphView.models = graphViewModels;
    HistoryModel *today = [graphViewModels lastObject];
    if (!today) {
        self.turnover.text = @"0";
        self.receipt.text = @"0";
    }else{ // 判断日期是否今天
        if ([[AppDelegate getNow] isEqualToString:today.dealDate]) {
            CGFloat money = today.txAmt.floatValue;
            self.turnover.text = [NSString stringWithFormat:@"%.2f",money];
            self.receipt.text = today.saleNums;
        }else{
            self.turnover.text = @"0";
            self.receipt.text = @"0";
        }
    }
}

@end
