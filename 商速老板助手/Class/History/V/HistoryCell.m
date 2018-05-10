//
//  HistoryCell.m
//  商速老板助手
//
//  Created by 今日 on 2018/5/3.
//  Copyright © 2018年 luyonghao. All rights reserved.
//

#import "HistoryCell.h"
#import "HistoryModel.h"

#import "HistoryPartitionView.h"
@interface HistoryCell ()

////营业额
@property (nonatomic,strong) UILabel *turnoverLabel;
////营业额数量
@property (nonatomic,strong) UILabel *turnoverNum;
////笔数
@property (nonatomic,strong) UILabel *numLabel;
////笔数数量
@property (nonatomic,strong) UILabel *num;

@property (nonatomic,weak)HistoryPartitionView *sectionView;
@end


@implementation HistoryCell

- (void)setModel:(HistoryModel *)model{
    _model = model;
    self.num.text = model.saleNums;
    self.turnoverNum.text = model.txAmt;
    self.sectionView.model = model;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        HistoryPartitionView *sectionView = [[HistoryPartitionView alloc] init];
        [self addSubview:sectionView];
        [sectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self);
            make.height.mas_equalTo(30);
        }];
        self.sectionView = sectionView;
        
        [self setupTurnoverLabel];
        [self setupTurnoverNum];
        [self setupNumLabel];
        [self setupNum];
    }
    return self;
}

-(void)setupTurnoverLabel{
    UILabel *label = [[UILabel alloc] init];
    [self addSubview:label];
    label.text = @"营业额";
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SCREEN_WIDTH * 0.25);
        //make.top.mas_equalTo(10);
        make.top.equalTo(self.sectionView.mas_bottom);
    }];
    label.font = [UIFont systemFontOfSize:12];
    label.textColor = [UIColor colorWithRed:106.0/255.0 green:106.0/255.0 blue:106.0/255.0 alpha:1];
    self.turnoverLabel = label;
}

-(void)setupTurnoverNum{
    UILabel *label = [[UILabel alloc] init];
    [self addSubview:label];
    label.text = @"8888";
    label.font = [UIFont systemFontOfSize:19];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SCREEN_WIDTH * 0.25);
        make.top.mas_equalTo(self.turnoverLabel.mas_bottom).offset(5);
    }];
    label.font = [UIFont systemFontOfSize:12];
    label.textColor = [UIColor colorWithRed:106.0/255.0 green:106.0/255.0 blue:106.0/255.0 alpha:1];
    self.turnoverNum = label;
}

-(void)setupNumLabel{
    UILabel *label = [[UILabel alloc] init];
    [self addSubview:label];
    label.text = @"笔数";
    label.font = [UIFont systemFontOfSize:15];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SCREEN_WIDTH * 0.65);
        make.top.mas_equalTo(self.turnoverLabel);
    }];
    label.font = [UIFont systemFontOfSize:12];
    label.textColor = [UIColor colorWithRed:106.0/255.0 green:106.0/255.0 blue:106.0/255.0 alpha:1];
    self.numLabel = label;
}

-(void)setupNum{
    UILabel *num = [[UILabel alloc] init];
    [self addSubview:num];
    num.text = @"8888";
    [num mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SCREEN_WIDTH * 0.65);
        make.top.mas_equalTo(self.numLabel.mas_bottom).offset(5);
    }];
    num.font = [UIFont systemFontOfSize:12];
    num.textColor = [UIColor colorWithRed:106.0/255.0 green:106.0/255.0 blue:106.0/255.0 alpha:1];
    self.num = num;
}


@end
