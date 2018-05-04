//
//  SalesCell.m
//  商速老板助手
//
//  Created by 今日 on 2018/5/4.
//  Copyright © 2018年 luyonghao. All rights reserved.
//

#import "SalesCell.h"

@implementation SalesCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self titleLabel];
        [self salesMoney];
        [self salesNum];
    }
    return self;
}

-(UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_titleLabel];
        _titleLabel.text = @"日用品:";
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
            make.left.mas_equalTo(SCREEN_WIDTH * 0.15);
        }];
    }
    return _titleLabel;
}

-(UILabel *)salesMoney{
    if (_salesMoney == nil) {
        _salesMoney = [[UILabel alloc] init];
        [self.contentView addSubview:_salesMoney];
        _salesMoney.text = @"3579";
        [_salesMoney mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
            make.left.mas_equalTo(SCREEN_WIDTH * 0.35);
        }];
    }
    return _salesMoney;
}

-(UILabel *)salesNum{
    if (_salesNum == nil) {
        _salesNum = [[UILabel alloc] init];
        [self.contentView addSubview:_salesNum];
        _salesNum.text = @"1888";
        [_salesNum mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
            make.left.mas_equalTo(SCREEN_WIDTH * 0.65);
        }];
    }
    return _salesNum;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
