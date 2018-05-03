//
//  HistoryCell.h
//  商速老板助手
//
//  Created by 今日 on 2018/5/3.
//  Copyright © 2018年 luyonghao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HistoryCell : UITableViewCell

//营业额
@property (nonatomic,strong) UILabel *turnoverLabel;
//营业额数量
@property (nonatomic,strong) UILabel *turnoverNum;
//笔数
@property (nonatomic,strong) UILabel *numLabel;
//笔数数量
@property (nonatomic,strong) UILabel *num;

@end
