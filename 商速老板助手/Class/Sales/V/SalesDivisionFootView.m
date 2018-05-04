//
//  SalesDivisionFootView.m
//  商速老板助手
//
//  Created by 今日 on 2018/5/4.
//  Copyright © 2018年 luyonghao. All rights reserved.
//

#import "SalesDivisionFootView.h"

@implementation SalesDivisionFootView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self salesMoneyTotal];
        [self salesMoney];
        [self salesNumLabelTotal];
        [self salesNumLabel];
    }
    return self;
}

-(UILabel *)salesMoneyTotal{
    if (_salesMoneyTotal == nil) {
        _salesMoneyTotal = [[UILabel alloc] init];
        _salesMoneyTotal.text = @"合计:";
        [self addSubview:_salesMoneyTotal];
        [_salesMoneyTotal mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(60 * 0.5);
            make.left.mas_equalTo(SCREEN_WIDTH * 0.1);
        }];
    }
    return _salesMoneyTotal;
}

-(UILabel *)salesMoney{
    if (_salesMoney == nil) {
        _salesMoney = [[UILabel alloc] init];
        _salesMoney.text = @"6888";
        [self addSubview:_salesMoney];
        [_salesMoney mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(60 * 0.5);
            make.left.mas_equalTo(SCREEN_WIDTH * 0.27);
        }];
    }
    return _salesMoney;
}

-(UILabel *)salesNumLabelTotal{
    if (_salesNumLabelTotal == nil) {
        _salesNumLabelTotal = [[UILabel alloc] init];
        _salesNumLabelTotal.text = @"合计:";
        [self addSubview:_salesNumLabelTotal];
        [_salesNumLabelTotal mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(60 * 0.5);
            make.left.mas_equalTo(SCREEN_WIDTH * 0.63);
        }];
    }
    return _salesNumLabelTotal;
}

-(UILabel *)salesNumLabel{
    if (_salesNumLabel == nil) {
        _salesNumLabel = [[UILabel alloc] init];
        _salesNumLabel.text = @"5888";
        [self addSubview:_salesNumLabel];
        [_salesNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(60 * 0.5);
            make.left.mas_equalTo(SCREEN_WIDTH * 0.8);
        }];
    }
    return _salesNumLabel;
}

@end
