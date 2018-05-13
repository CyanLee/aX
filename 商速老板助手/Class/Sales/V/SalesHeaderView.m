//
//  SalesHeaderView.m
//  商速老板助手
//
//  Created by 今日 on 2018/5/4.
//  Copyright © 2018年 luyonghao. All rights reserved.
//

#import "SalesHeaderView.h"

@interface SalesHeaderView()

@property (nonatomic,strong) UIButton *lastBtn;

@end

@implementation SalesHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = DefineRedColor;
        [self backBtn];
        [self headerView];
        [self titleLabel];
        [self reportBtn];
        [self chooseBtn];
        [self languageBtn];
        [self historyBtn];
        [self historyLabel];
        [self setClickBtn];
    }
    return self;
}

-(UIButton *)backBtn{
    if (_backBtn == nil) {
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backBtn setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
//        _backBtn.backgroundColor = [UIColor whiteColor];
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

-(UIButton *)headerView{
    if (_headerView == nil) {
        _headerView = [UIButton buttonWithType:UIButtonTypeCustom];
        _headerView.backgroundColor = [UIColor whiteColor];
        if (UD_GET_OBJ(@"headerImage") == nil) {
            [_headerView setImage:[UIImage imageNamed:@"老板助手"] forState:UIControlStateNormal];
        }else{
            [_headerView setImage:[UIImage imageWithData:UD_GET_OBJ(@"headerImage")] forState:UIControlStateNormal];
        }
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
        _titleLabel.font = [UIFont systemFontOfSize:12.f];
        [self addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
            make.left.mas_equalTo(self.headerView.mas_right).offset(3);
        }];
    }
    return _titleLabel;
}

-(UIButton *)reportBtn{
    if (_reportBtn == nil) {
        _reportBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _reportBtn.backgroundColor = DefineRedColor;
        [_reportBtn setTitle:NSLocalized(@"Merchant report", nil) forState:UIControlStateNormal];
        _reportBtn.titleLabel.font = [UIFont systemFontOfSize:13.0f];
        [_reportBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self addSubview:_reportBtn];
        [_reportBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(0);
            make.top.mas_equalTo(20);
            make.height.equalTo(self).multipliedBy(0.2);
            make.width.mas_equalTo(100);
        }];
        _reportBtn.layer.cornerRadius = 5;
        _reportBtn.layer.masksToBounds = true;
        _reportBtn.layer.borderColor = [UIColor whiteColor].CGColor;
        _reportBtn.layer.borderWidth = 2;
    }
    return _reportBtn;
}

-(UIButton *)chooseBtn{
    if (_chooseBtn == nil) {
        _chooseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _chooseBtn.backgroundColor = DefineRedColor;
        [_chooseBtn setTitle:NSLocalized(@"choose Merchant", nil) forState:UIControlStateNormal];
        _chooseBtn.titleLabel.font = [UIFont systemFontOfSize:13.0f];
        [_chooseBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self addSubview:_chooseBtn];
        [_chooseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(0);
            make.top.mas_equalTo(self.reportBtn.mas_bottom).offset(3);
            make.height.equalTo(self).multipliedBy(0.2);
            make.width.mas_equalTo(100);
        }];
        _chooseBtn.layer.cornerRadius = 5;
        _chooseBtn.layer.masksToBounds = true;
        _chooseBtn.layer.borderColor = [UIColor whiteColor].CGColor;
        _chooseBtn.layer.borderWidth = 2;
    }
    return _chooseBtn;
}

-(UIButton *)historyBtn{
    if (_historyBtn == nil) {
        _historyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        _historyBtn.backgroundColor = [UIColor whiteColor];
        [_historyBtn setTitleColor:DefineRedColor forState:UIControlStateNormal];
        [_historyBtn setImage:[UIImage imageNamed:@"20180503老板助手历史数据"] forState:UIControlStateNormal];
        [self addSubview:_historyBtn];
        [_historyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.titleLabel).offset(-10);
            make.right.mas_equalTo(self.languageBtn.mas_left).offset(-25);
            make.height.equalTo(self).multipliedBy(0.22);
            make.width.mas_equalTo(25);
        }];
    }
    return _historyBtn;
}

-(UILabel *)historyLabel{
    if (_historyLabel == nil) {
        _historyLabel = [[UILabel alloc] init];
        _historyLabel.textColor = [UIColor whiteColor];
        _historyLabel.text = NSLocalized(@"History report", nil);
        _historyLabel.font = [UIFont systemFontOfSize:12.f];
        [self addSubview:_historyLabel];
        [_historyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.historyBtn.mas_bottom).offset(3);
            make.right.mas_equalTo(self.languageBtn.mas_left).offset(-20);
        }];
    }
    return _historyLabel;
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

-(void)setClickBtn{
    CGFloat tx = (SCREEN_WIDTH / 4.1);
    CGFloat x = (SCREEN_WIDTH-4*tx) / 5;
    UIButton *last = nil;   //上一个按钮
    for (int i = 0; i < 4; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:btn];
        btn.tag = i;
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.chooseBtn.mas_bottom).offset(12);
            make.height.mas_equalTo(30);
            make.width.mas_equalTo(tx);
//            make.width.equalTo(self).multipliedBy(0.22);
            if (last == nil) {
                make.left.mas_equalTo(x);
            }else{
                make.left.mas_equalTo(last.mas_right).offset(x);
            }
        }];
        btn.layer.cornerRadius = 5;
        btn.layer.masksToBounds = true;
        btn.layer.borderColor = [UIColor whiteColor].CGColor;
        btn.layer.borderWidth = 2;
        btn.backgroundColor = DefineRedColor;
        btn.titleLabel.font = [UIFont systemFontOfSize:11.0f];
        last = btn;
        
        if (i == 0) {
            [btn setTitle:NSLocalized(@"Top number 10 sales", nil) forState:UIControlStateNormal];
            btn.backgroundColor = [UIColor whiteColor];
            [btn setTitleColor:DefineRedColor forState:UIControlStateNormal];
            self.numRankingBtn = btn;
            self.lastBtn = btn;
        } else if (i == 1) {
            [btn setTitle:NSLocalized(@"Top Amount 10 sales", nil) forState:UIControlStateNormal];
            self.moneyRankingBtn = btn;
        }else if (i == 2) {
            [btn setTitle:NSLocalized(@"categories sales", nil) forState:UIControlStateNormal];
            self.salesRankingBtn = btn;
        }else{
            [btn setTitle:NSLocalized(@"Cashier report", nil) forState:UIControlStateNormal];
            self.summaryBtn = btn;
        }
        [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    }
}

-(void)clickBack:(UIButton *)sender{
    if (self.backBlock) {
        self.backBlock();
    }
}

-(void)click:(UIButton *)sender{
    
    if (sender == self.lastBtn) {
        return;
    }
    
    sender.backgroundColor = [UIColor whiteColor];
    [sender setTitleColor:DefineRedColor forState:UIControlStateNormal];
    
    if (self.lastBtn) {
        self.lastBtn.backgroundColor = DefineRedColor;
        [self.lastBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    
    self.lastBtn = sender;
    if (self.click) {
        self.click(sender.tag);
    }
}



@end
