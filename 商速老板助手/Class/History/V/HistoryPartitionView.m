//
//  HistoryPartitionView.m
//  商速老板助手
//
//  Created by 今日 on 2018/5/3.
//  Copyright © 2018年 luyonghao. All rights reserved.
//

#import "HistoryPartitionView.h"
#import "HistoryModel.h"

@implementation HistoryPartitionView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithRed:243/255.0 green:239/255.0 blue:236/255.0 alpha:1];  
        [self timeLabel];
    }
    return self;
}

-(UILabel *)timeLabel{
    if (_timeLabel == nil) {
        _timeLabel = [[UILabel alloc] init];
        [self addSubview:_timeLabel];
        _timeLabel.text = @"2018/08/07";
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
            make.left.mas_equalTo(10);
        }];
    }
    return _timeLabel;
}

-(void)setData:(HistoryModel *)model{
    self.timeLabel.text = model.time;
}

@end
