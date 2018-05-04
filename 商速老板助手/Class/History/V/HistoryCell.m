//
//  HistoryCell.m
//  商速老板助手
//
//  Created by 今日 on 2018/5/3.
//  Copyright © 2018年 luyonghao. All rights reserved.
//

#import "HistoryCell.h"
#import "HistoryModel.h"

@implementation HistoryCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self turnoverLabel];
        [self turnoverNum];
        [self numLabel];
        [self num];
    }
    return self;
}

-(UILabel *)turnoverLabel{
    if (_turnoverLabel == nil) {
        _turnoverLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_turnoverLabel];
        _turnoverLabel.text = @"营业额";
        _turnoverLabel.font = [UIFont systemFontOfSize:15];
        [_turnoverLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(SCREEN_WIDTH * 0.25);
            make.top.mas_equalTo(10);
        }];
    }
    return _turnoverLabel;
}

-(UILabel *)turnoverNum{
    if (_turnoverNum == nil) {
        _turnoverNum = [[UILabel alloc] init];
        [self.contentView addSubview:_turnoverNum];
        _turnoverNum.text = @"8888";
        _turnoverNum.font = [UIFont systemFontOfSize:19];
        [_turnoverNum mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(SCREEN_WIDTH * 0.25);
            make.top.mas_equalTo(self.turnoverLabel.mas_bottom).offset(5);
        }];
    }
    return _turnoverNum;
}

-(UILabel *)numLabel{
    if (_numLabel == nil) {
        _numLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_numLabel];
        _numLabel.text = @"笔数";
        _numLabel.font = [UIFont systemFontOfSize:15];
        [_numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(SCREEN_WIDTH * 0.65);
            make.top.mas_equalTo(10);
        }];
    }
    return _numLabel;
}

-(UILabel *)num{
    if (_num == nil) {
        _num = [[UILabel alloc] init];
        [self.contentView addSubview:_num];
        _num.text = @"8888";
        _num.font = [UIFont systemFontOfSize:19];
        [_num mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(SCREEN_WIDTH * 0.65);
            make.top.mas_equalTo(self.numLabel.mas_bottom).offset(5);
        }];
    }
    return _num;
}

-(void)setData:(HistoryModel *)model{
    self.turnoverNum.text = model.turnoverNum;
    self.num.text = model.num;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
