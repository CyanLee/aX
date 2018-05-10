//
//  SalesDivisionFootView.m
//  商速老板助手
//
//  Created by 今日 on 2018/5/4.
//  Copyright © 2018年 luyonghao. All rights reserved.
//

#import "SalesDivisionFootView.h"
#import "NSBundle+Language.h"

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
        _salesMoneyTotal.text = [NSString stringWithFormat:@"%@:",NSLocalized(@"total", nil)];
        [self addSubview:_salesMoneyTotal];
        [_salesMoneyTotal mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(60 * 0.5);
            make.left.mas_equalTo(SCREEN_WIDTH * 0.1);
        }];
        _salesMoneyTotal.font = [UIFont systemFontOfSize:15];
        _salesMoneyTotal.textColor = [UIColor colorWithRed:76.0/255.0 green:76.0/255.0 blue:76.0/255.0 alpha:1];
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
        _salesMoney.font = [UIFont systemFontOfSize:15];
        _salesMoney.textColor = [UIColor colorWithRed:76.0/255.0 green:76.0/255.0 blue:76.0/255.0 alpha:1];
    }
    return _salesMoney;
}

-(UILabel *)salesNumLabelTotal{
    if (_salesNumLabelTotal == nil) {
        _salesNumLabelTotal = [[UILabel alloc] init];
        _salesNumLabelTotal.text = [NSString stringWithFormat:@"%@:",NSLocalized(@"total", nil)];
        [self addSubview:_salesNumLabelTotal];
        [_salesNumLabelTotal mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(60 * 0.5);
            make.left.mas_equalTo(SCREEN_WIDTH * 0.63);
        }];
        _salesNumLabelTotal.font = [UIFont systemFontOfSize:15];
        _salesNumLabelTotal.textColor = [UIColor colorWithRed:76.0/255.0 green:76.0/255.0 blue:76.0/255.0 alpha:1];
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
        _salesNumLabel.font = [UIFont systemFontOfSize:15];
        _salesNumLabel.textColor = [UIColor colorWithRed:76.0/255.0 green:76.0/255.0 blue:76.0/255.0 alpha:1];
    }
    return _salesNumLabel;
}

@end
