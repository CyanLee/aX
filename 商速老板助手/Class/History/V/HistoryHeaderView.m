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
        [self backBtn];
        [self headerView];
        [self titleLabel];
        [self historyBtn];
        [self chooseBtn];
        [self languageBtn];
    }
    return self;
}

-(UIButton *)backBtn{
    if (_backBtn == nil) {
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        _backBtn.backgroundColor = [UIColor whiteColor];
        [_backBtn setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
        [self addSubview:_backBtn];
        [_backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
            make.left.mas_equalTo(self).offset(15);
            make.height.mas_equalTo(25);
            make.width.mas_equalTo(15);
        }];
        [_backBtn addTarget:self action:@selector(clickBack:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
}

-(UIImageView *)headerView{
    if (_headerView == nil) {
        _headerView = [[UIImageView alloc] init];
        _headerView.backgroundColor = [UIColor whiteColor];
        _headerView.image = [UIImage imageNamed:@"老板助手"];
        [self addSubview:_headerView];
        [_headerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
            make.left.mas_equalTo(self.backBtn.mas_right).offset(8);
            make.height.mas_equalTo(35);
            make.width.mas_equalTo(35);
        }];
        _headerView.layer.cornerRadius = 35 / 2.0f;
        _headerView.layer.masksToBounds = true;
    }
    return _headerView;
}

-(UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.text = NSLocalized(@"change logo", nil);
        _titleLabel.font = [UIFont systemFontOfSize:14.f];
        [self addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
            make.left.mas_equalTo(self.headerView.mas_right).offset(3);
//            make.height.mas_equalTo(40);
//            make.width.mas_equalTo(40);
        }];
    }
    return _titleLabel;
}

-(UIButton *)historyBtn{
    if (_historyBtn == nil) {
        _historyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _historyBtn.backgroundColor = [UIColor whiteColor];
        [_historyBtn setTitle:NSLocalized(@"History report", nil) forState:UIControlStateNormal];
        _historyBtn.titleLabel.font = [UIFont systemFontOfSize:13.0f];
        [_historyBtn setTitleColor:DefineRedColor forState:UIControlStateNormal];
        [self addSubview:_historyBtn];
        [_historyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(0);
            make.top.mas_equalTo(22);
//            make.height.mas_equalTo(35);
            make.height.equalTo(self).multipliedBy(0.22);
            make.width.mas_equalTo(100);
        }];
        _historyBtn.layer.cornerRadius = 13;
        _historyBtn.layer.masksToBounds = true;
    }
    return _historyBtn;
}

-(UIButton *)chooseBtn{
    if (_chooseBtn == nil) {
        _chooseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _chooseBtn.backgroundColor = DefineRedColor;
        [_chooseBtn setTitle:NSLocalized(@"choose Merchant", nil) forState:UIControlStateNormal];
        _chooseBtn.titleLabel.font = [UIFont systemFontOfSize:10.0f];
        [_chooseBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self addSubview:_chooseBtn];
        [_chooseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(0);
            make.bottom.mas_equalTo(-20);
            make.height.equalTo(self).multipliedBy(0.22);
            make.width.mas_equalTo(100);
        }];
        _chooseBtn.layer.cornerRadius = 5;
        _chooseBtn.layer.masksToBounds = true;
        _chooseBtn.layer.borderColor = [UIColor whiteColor].CGColor;
        _chooseBtn.layer.borderWidth = 2;
    }
    return _chooseBtn;
}

-(UIButton *)languageBtn{
    if (_languageBtn == nil) {
        _languageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _languageBtn.backgroundColor = [UIColor whiteColor];
        [_languageBtn setTitle:NSLocalized(@"language", nil) forState:UIControlStateNormal];
         _languageBtn.titleLabel.font = [UIFont systemFontOfSize:13.0f];
        [_languageBtn setTitleColor:DefineRedColor forState:UIControlStateNormal];
        [self addSubview:_languageBtn];
        [_languageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
            make.right.mas_equalTo(self).offset(-15);
            make.height.mas_equalTo(35);
            make.width.mas_equalTo(35);
        }];
        _languageBtn.layer.cornerRadius = 35 / 2.0f;
        _languageBtn.layer.masksToBounds = true;
    }
    return _languageBtn;
}

-(void)clickBack:(UIButton *)sender{
    if (self.backBlock) {
        self.backBlock();
    }
}

@end
