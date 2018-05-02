//
//  HistoryHeaderView.m
//  商速老板助手
//
//  Created by hiby001 on 2018/5/2.
//  Copyright © 2018年 luyonghao. All rights reserved.
//

#import "HistoryHeaderView.h"

@implementation HistoryHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = DefineRedColor;
        [self headerBtn];
    }
    return self;
}

-(UIButton *)headerBtn{
    if (_headerBtn == nil) {
        _headerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_headerBtn];
        [_headerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(0);
            make.left.mas_offset(100);
            make.height.width.mas_equalTo(80);
        }];
    }
    return _headerBtn;
}

//- (void)setupHeaderView{
//    UIView *headerView = [[UIView alloc]init];
//    headerView.backgroundColor = DefineRedColor;
//    [self addSubview:headerView];
//    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.left.right.equalTo(self);
//        make.height.mas_equalTo(468.0/2937.0*kHeight);
//    }];
//}

@end
