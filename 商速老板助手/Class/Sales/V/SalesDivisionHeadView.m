//
//  SalesDivisionHeadView.m
//  商速老板助手
//
//  Created by 今日 on 2018/5/4.
//  Copyright © 2018年 luyonghao. All rights reserved.
//

#import "SalesDivisionHeadView.h"
#import "NSBundle+Language.h"

@implementation SalesDivisionHeadView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self salesMoneyLabel];
        [self salesNumLabel];
    }
    return self;
}
- (void)setType:(NSInteger)type{
    _type = type;
    switch (type) {
        case 0:
            _salesMoneyLabel.text = NSLocalized(@"Sale", nil);
            _salesNumLabel.text = NSLocalized(@"Sales volume", nil);
            break;
        case 1:
            _salesMoneyLabel.text = NSLocalized(@"Sale", nil);
            _salesNumLabel.text = NSLocalized(@"Sales volume", nil);
            break;
        case 2:
            _salesMoneyLabel.text = NSLocalized(@"Sale", nil);
            _salesNumLabel.text = NSLocalized(@"Sales volume", nil);
            break;
        case 3:
            _salesMoneyLabel.text = NSLocalized(@"Receipt amount", nil);
            _salesNumLabel.text = NSLocalized(@"Receipt time", nil);
            break;
        default:
            _salesMoneyLabel.text = @"";
            _salesNumLabel.text = @"";
            break;
    }
}

-(UILabel *)salesMoneyLabel{
    if (_salesMoneyLabel == nil) {
        _salesMoneyLabel = [[UILabel alloc] init];
        _salesMoneyLabel.text = NSLocalized(@"Receipt amount", nil);
        [self addSubview:_salesMoneyLabel];
        [_salesMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(60 * 0.5);
            make.left.mas_equalTo(SCREEN_WIDTH * 0.33);
        }];
        _salesMoneyLabel.textColor = [UIColor colorWithRed:76.0/255.0 green:76.0/255.0 blue:76.0/255.0 alpha:1];
        _salesMoneyLabel.font = [UIFont systemFontOfSize:15];
    }
    return _salesMoneyLabel;
}

-(UILabel *)salesNumLabel{
    if (_salesNumLabel == nil) {
        _salesNumLabel = [[UILabel alloc] init];
        _salesNumLabel.text = NSLocalized(@"Sales volume", nil);
        [self addSubview:_salesNumLabel];
        [_salesNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(60 * 0.5);
            make.left.mas_equalTo(SCREEN_WIDTH * 0.63);
        }];
        _salesNumLabel.textColor = [UIColor colorWithRed:76.0/255.0 green:76.0/255.0 blue:76.0/255.0 alpha:1];
        _salesNumLabel.font = [UIFont systemFontOfSize:15];
    }
    return _salesNumLabel;
}
@end
