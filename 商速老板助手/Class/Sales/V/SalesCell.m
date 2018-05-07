//
//  SalesCell.m
//  商速老板助手
//
//  Created by 今日 on 2018/5/4.
//  Copyright © 2018年 luyonghao. All rights reserved.
//

#import "SalesCell.h"

@interface SalesCell ()

@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *salesMoney;
@property (nonatomic,strong) UILabel *salesNum;

@end

@implementation SalesCell

- (void)setType:(NSInteger)type{
    _type = type;
}

- (void)setModel:(SalesModel *)model{
    _model = model;
    switch (self.type) {
        case 0:
            self.titleLabel.text = model.itemName;
            self.salesMoney.text = model.txAmt;
            self.salesNum.text = model.saleNums;
            break;
        case 1:
            self.titleLabel.text = model.itemName;
            self.salesMoney.text = model.txAmt;
            self.salesNum.text = model.saleNums;
            break;
        case 2:
            self.titleLabel.text = @"";
            self.salesMoney.text = @"";
            self.salesNum.text = @"";
            break;
        case 3:
            self.titleLabel.text = model.payType;
            self.salesMoney.text = model.payAmt;
            self.salesNum.text = model.payTimes;
            break;
        default:
            self.titleLabel.text = @"";
            self.salesMoney.text = @"";
            self.salesNum.text = @"";
            break;
    }
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupTitleLabel];
        [self setupSalesMoney];
        [self setupSalesNum];
    }
    return self;
}

-(void)setupTitleLabel{
    UILabel * titleLabel = [[UILabel alloc] init];
    [self.contentView addSubview:titleLabel];
    titleLabel.text = @"日用品:";
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.mas_equalTo(30);
    }];
    titleLabel.font = [UIFont systemFontOfSize:13];
    titleLabel.textColor = [UIColor colorWithRed:76.0/255.0 green:76.0/255.0 blue:76.0/255.0 alpha:1];
    self.titleLabel = titleLabel;
}

-(void)setupSalesMoney{
    UILabel * salesMoney = [[UILabel alloc] init];
    [self.contentView addSubview:salesMoney];
    salesMoney.text = @"3579";
    [salesMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.mas_equalTo(SCREEN_WIDTH * 0.35);
    }];
    salesMoney.font = [UIFont systemFontOfSize:13];
    salesMoney.textColor = [UIColor colorWithRed:76.0/255.0 green:76.0/255.0 blue:76.0/255.0 alpha:1];
    self.salesMoney = salesMoney;
}

-(void)setupSalesNum{
    UILabel *salesNum = [[UILabel alloc] init];
    [self.contentView addSubview:salesNum];
    salesNum.text = @"1888";
    [salesNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.mas_equalTo(SCREEN_WIDTH * 0.65);
    }];
    salesNum.font = [UIFont systemFontOfSize:13];
    salesNum.textColor = [UIColor colorWithRed:76.0/255.0 green:76.0/255.0 blue:76.0/255.0 alpha:1];
    self.salesNum = salesNum;
}

@end
