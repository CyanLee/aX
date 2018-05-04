//
//  SalesDivisionHeadView.m
//  商速老板助手
//
//  Created by 今日 on 2018/5/4.
//  Copyright © 2018年 luyonghao. All rights reserved.
//

#import "SalesDivisionHeadView.h"

@implementation SalesDivisionHeadView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self salesMoneyLabel];
        [self salesNumLabel];
    }
    return self;
}

-(UILabel *)salesMoneyLabel{
    if (_salesMoneyLabel == nil) {
        _salesMoneyLabel = [[UILabel alloc] init];
        _salesMoneyLabel.text = @"销售额";
        [self addSubview:_salesMoneyLabel];
        [_salesMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(60 * 0.5);
            make.left.mas_equalTo(SCREEN_WIDTH * 0.33);
        }];
    }
    return _salesMoneyLabel;
}

-(UILabel *)salesNumLabel{
    if (_salesNumLabel == nil) {
        _salesNumLabel = [[UILabel alloc] init];
        _salesNumLabel.text = @"销售数量";
        [self addSubview:_salesNumLabel];
        [_salesNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(60 * 0.5);
            make.left.mas_equalTo(SCREEN_WIDTH * 0.63);
        }];
    }
    return _salesNumLabel;
}
@end
