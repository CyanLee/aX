//
//  HistoryPartitionView.h
//  商速老板助手
//
//  Created by 今日 on 2018/5/3.
//  Copyright © 2018年 luyonghao. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HistoryModel;

@interface HistoryPartitionView : UIView

//日期
@property (nonatomic,strong) UILabel *timeLabel;

-(void)setData:(HistoryModel *)model;

@end
