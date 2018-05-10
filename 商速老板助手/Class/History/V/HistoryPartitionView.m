//
//  HistoryPartitionView.m
//  商速老板助手
//
//  Created by 今日 on 2018/5/3.
//  Copyright © 2018年 luyonghao. All rights reserved.
//

#import "HistoryPartitionView.h"
#import "HistoryModel.h"


@interface HistoryPartitionView ()
//日期
@property (nonatomic,weak) UILabel *timeLabel;


@end
@implementation HistoryPartitionView

-(instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = [UIColor colorWithRed:243/255.0 green:239/255.0 blue:236/255.0 alpha:1];
        [self setupTimeLabel];
    }
    return self;
}

-(void)setupTimeLabel{
    UILabel *label= [[UILabel alloc] init];
    [self addSubview:label];
    label.text = @"2018/08/07";
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.left.mas_equalTo(10);
    }];
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = [UIColor colorWithRed:76.0/255.0 green:76.0/255.0 blue:76.0/255.0 alpha:1];
    self.timeLabel = label;
}
- (void)setModel:(HistoryModel *)model{
    _model = model;
    
    self.timeLabel.text = model.dealDate;
}

@end
