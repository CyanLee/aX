//
//  TimeView.m
//  商速老板助手
//
//  Created by LusHo on 2018/5/1.
//  Copyright © 2018年 luyonghao. All rights reserved.
//

#import "TimeView.h"
#import "HistoryModel.h"
@interface TimeView ()

@property (nonatomic,weak)UIView *time;

@property (nonatomic,weak)UIView *switchTime;

@property (nonatomic,strong)NSMutableArray *times;

@property (nonatomic,strong)NSMutableArray *timeBtns;
@end

@implementation TimeView

- (instancetype)initWithTimeH:(CGFloat)timeH WithSwicthTimeH:(CGFloat)swicthTimeH{
    if (self = [super init]) {
        
        UIView *time = [[UIView alloc]init];
        [self addSubview:time];
        time.backgroundColor = [UIColor colorWithRed:238.0/255 green:238.0/255 blue:238.0/255 alpha:1];
        [time mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self);
            make.height.mas_equalTo(timeH);
        }];
        self.time = time;
        
        
        NSArray *times = @[@"",@"",@"",@"",@"",@"",@""/*NSLocalized(@"Today", nil)*/];
        for (int i = 0; i < 7; i++) {
            UIButton *btn = [[UIButton alloc]init];
            [self.time addSubview:btn];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.equalTo(self.time);
                make.width.mas_equalTo(kWidth/7.0);
                make.top.equalTo(self.time);
                make.left.mas_offset(kWidth/7.0*i);
            }];
            [btn setTitle:i<times.count?times[i]:@"" forState:0];
            btn.titleLabel.font = [UIFont systemFontOfSize:12];
            [btn setTitleColor:[UIColor colorWithRed:76.0/255.0 green:76.0/255.0 blue:76.0/255.0 alpha:1] forState:0];
            btn.tag = i;
            [self.times addObject:btn];
            [btn addTarget:self action:@selector(chooseTime:) forControlEvents:1<<6];
        }
        
        UIView *switchTime = [[UIView alloc]init];
        [self addSubview:switchTime];
        switchTime.backgroundColor = [UIColor whiteColor];
        [switchTime mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self);
            make.height.mas_equalTo(swicthTimeH);
        }];
        self.switchTime = switchTime;
        
        CGFloat btnW = kWidth == 320 ? 55 : 65;
        NSArray *arr = @[NSLocalized(@"day", nil),NSLocalized(@"week", nil),NSLocalized(@"month", nil),NSLocalized(@"year", nil)];
        CGFloat firstX = (kWidth-arr.count*btnW)/arr.count;
        for (int i = 0; i < arr.count; i++) {
            UIButton *btn = [[UIButton alloc]init];
            [btn setTitle:arr[i] forState:0];
            btn.tag = i;
            [btn setTitleColor:[UIColor whiteColor] forState:0];
            [btn setBackgroundColor:DefineRedColor];
            btn.titleLabel.font = [UIFont systemFontOfSize:20];
            [self.switchTime addSubview:btn];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.width.mas_equalTo(btnW);
                make.centerY.equalTo(switchTime);
                make.left.mas_offset(firstX/2.0+(btnW*i+firstX*i));
            }];
            btn.layer.cornerRadius = btnW/2;
            btn.layer.masksToBounds = true;
            [self.timeBtns addObject:btn];
            [btn addTarget:self action:@selector(btnDidClicked:) forControlEvents:1<<6];
        }
    }
    return self;
}

- (void)setModels:(NSMutableArray *)models{
    _models = models;
    NSInteger count = models.count;
    if (count == 0) {
        for (UIButton *btn in self.times) {
             [btn setTitle:@"" forState:0];
        }
    }
    for (int i = 0; i < count; i ++) {
        UIButton *time = self.times[i];
        HistoryModel *model = models[i];
        NSString *dealDate = [model.dealDate substringFromIndex:5];//截取掉下标3之后的字符串
        [time setTitle:dealDate forState:0];
    }
    if (count < self.times.count) {
        for (NSInteger i = count; i < self.times.count; i++) {
            UIButton *time = self.times[i];
            [time setTitle:@"" forState:0];
        }
    }
    
}
- (void)chooseTime:(UIButton *)btn{
    if (self.chooseTimeBlock) {
        self.chooseTimeBlock(btn);
    }
}
- (void)btnDidClicked:(UIButton *)btn{
    for (UIButton *b in self.timeBtns) {
        [b setTitleColor:[UIColor whiteColor] forState:0];
        [b setBackgroundColor:DefineRedColor];
    }
    [btn setTitleColor:DefineRedColor forState:0];
    [btn setBackgroundColor:[UIColor whiteColor]];
    
    if (self.btnDidClickedBlock) {
        self.btnDidClickedBlock(btn);
    }
}

- (NSMutableArray *)timeBtns{
    if (!_timeBtns) {
        _timeBtns = [NSMutableArray array];
    }
    return _timeBtns;
}

- (NSMutableArray *)times{
    if (!_times) {
        _times = [NSMutableArray array];
    }
    return _times;
}
@end
