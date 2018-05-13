//
//  HistoryHeaderView.h
//  商速老板助手
//
//  Created by hiby001 on 2018/5/2.
//  Copyright © 2018年 luyonghao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HistoryHeaderView : UIView

//返回
@property (nonatomic,strong) UIButton *backBtn;
//改店标
@property (nonatomic,strong) UIButton *headerView;
//店名
@property (nonatomic,strong) UILabel *titleLabel;
//历史数据
@property (nonatomic,strong) UIButton *historyBtn;
//选择店铺
@property (nonatomic,strong) UIButton *chooseBtn;
//语言
@property (nonatomic,strong) UIButton *languageBtn;

@property(nonatomic,copy)void(^backBlock)(void);

@end
