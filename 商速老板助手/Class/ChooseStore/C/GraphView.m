//
//  GraphView.m
//  商速老板助手
//
//  Created by 赵宁 on 2018/5/9.
//  Copyright © 2018年 luyonghao. All rights reserved.
//

#import "GraphView.h"
#import "HistoryModel.h"
@interface GraphView ()

/// label pionts
@property (nonatomic,strong)NSMutableArray *pionts;

/// label num
@property (nonatomic,strong)NSMutableArray *piontNums;

@end


@implementation GraphView

- (void)setShowType:(NSInteger)showType{
    _showType = showType;
    NSInteger count = self.models.count;
    if (count > 7) count = 7;
    for (int i = 0 ; i < count; i ++) {
        UILabel *num = self.piontNums[i];
        HistoryModel *model = self.models[i];
        CGFloat money = model.txAmt.floatValue;
        num.text = showType == 0 ? [NSString stringWithFormat:@"%.2f",money] : model.saleNums;
    }
}
- (instancetype)init{
    if (self = [super init]) {
        //243119110
        UIView *line0 = [[UIView alloc]init];
        [self addSubview:line0];
        line0.backgroundColor = [UIColor colorWithRed:243.0/255.0 green:119.0/255.0 blue:110.0/255.0 alpha:1];
        [line0 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.left.top.equalTo(self);
            make.height.mas_equalTo(0.5);
        }];
        
        UIView *line1 = [[UIView alloc]init];
        [self addSubview:line1];
        line1.backgroundColor = line0.backgroundColor;
        [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.left.equalTo(self);
            make.height.mas_equalTo(0.5);
            make.top.mas_offset(50);
        }];
        
        
        for (int i = 0; i < 200; i ++) {
            UIView *line = [[UIView alloc]init];
            [self addSubview:line];
            line.backgroundColor = [UIColor whiteColor];
            [line mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(line1.mas_bottom).mas_offset(30);
                make.height.width.mas_equalTo(1);
                make.left.mas_offset(i * 2.0);
            }];
        }
        
        for (int i = 0; i < 7; i ++) {
            UILabel *point = [[UILabel alloc] init];
            point.text = @"o";
            point.font = [UIFont systemFontOfSize:14];
            point.textAlignment = 1;
            point.textColor = [UIColor whiteColor];
            [self addSubview:point];
            point.backgroundColor = [UIColor clearColor];
            [point mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(kWidth/7.0*i);
                make.centerY.equalTo(self).mas_offset(7);
                make.width.mas_equalTo(kWidth/7.0);
                make.height.mas_equalTo(20);
            }];
            point.tag = i;
            point.hidden = true;
            [self.pionts addObject:point];
        }
        
        for (int i = 0; i < 7; i ++) {
            UILabel *num = [[UILabel alloc] init];
            num.text = @"33322";
            num.font = [UIFont systemFontOfSize:9];
            num.textAlignment = 1;
            num.textColor = [UIColor whiteColor];
            [self addSubview:num];
            num.backgroundColor = [UIColor clearColor];
            UILabel *piont = self.pionts[i];
            [num mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(piont).mas_offset(3);
                make.right.equalTo(piont).mas_offset(-3);
                make.bottom.equalTo(piont.mas_top);
            }];
            num.tag = i;
            num.hidden = true;
            num.layer.borderColor = [[UIColor whiteColor] CGColor];
            num.layer.borderWidth = 0.5;
            num.layer.cornerRadius = 3;
            num.layer.masksToBounds = true;
            [self.piontNums addObject:num];
        }
        
        UIView *line2 = [[UIView alloc]init];
        [self addSubview:line2];
        line2.backgroundColor = line0.backgroundColor;
        [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.left.equalTo(self);
            make.height.mas_equalTo(0.5);
            make.top.equalTo(line1.mas_bottom).mas_offset(60);
        }];
    }
    return self;
}

- (void)setModels:(NSMutableArray *)models{
    _models = models;
    
    [self showUI:models]; // 显示与隐藏数字，点
    
    [self contrastModel:models];// 找出最高点
    
    [self setNeedsDisplay];
}

- (void)contrastModel:(NSMutableArray *)models{
    if (models.count == 0) return;
    CGFloat maxNum = 0;
    CGFloat minNum = 9999999.0;
    for (HistoryModel *model in models) {
        if (model.txAmt.floatValue > maxNum) {
            maxNum = model.txAmt.floatValue ;
        }
        if (model.txAmt.floatValue < minNum) {
            minNum = model.txAmt.floatValue;
        }
    }
    DLog(@"maxNum == %f  minNum == %f",maxNum,minNum);
    /// update masory
    // 等分 
    NSInteger count = models.count;
    if (count > 7) count = 7;
    for (int i = 0; i < count; i++) {
        HistoryModel *model = models[i];
    }
}

- (void)showUI:(NSMutableArray *)models{
    NSInteger count = models.count;
    if (count == 0) {
        for ( UILabel *l in self.pionts) {
            l.hidden = true;
        }
        for ( UILabel *l in self.piontNums) {
            l.hidden = true;
        }
    }else{
        if (count > 7) count = 7;
        for (int i = 0; i < count;i++) {/// 显示label
            UILabel *num = self.piontNums[i];
            num.hidden = false;
            
            UILabel *piont = self.pionts[i];
            piont.hidden = false;
            
            HistoryModel *model = models[i];
            CGFloat money = model.txAmt.floatValue;
            num.text = [NSString stringWithFormat:@"%.2f",money];
        }
        for (NSInteger i = count; i < self.piontNums.count; i++) {
            UILabel *num = self.piontNums[i];
            UILabel *piont = self.pionts[i];
            num.hidden = true;
            piont.hidden = true;
        }
    }
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
    if (self.models.count == 0 || !self.models) return;
    CGFloat count = self.models.count;
    //定义画图的path
    UIBezierPath *path = [[UIBezierPath alloc] init];
    CGFloat sidelength = 12;
    CGFloat x = kWidth/7.0*(7.0-1)-sidelength/2.0+kWidth/7.0/2.0;/// 这是最右边的x。
    x = x - (7.0-count)*kWidth/7.0; /// 这是对应的x
    //path移动到开始画图的位置
    //[path moveToPoint:CGPointMake(rect.size.width / 2.0 - sidelength/2.0, rect.size.height)];
    //从开始位置画一条直线到（rect.origin.x + rect.size.width， rect.origin.y）
    //[path addLineToPoint:CGPointMake(rect.size.width / 2.0, rect.size.height - sidelength)];
    //再从rect.origin.x + rect.size.width， rect.origin.y））画一条线到(rect.origin.x + rect.size.width/2, rect.origin.y + rect.size.height)
    //[path addLineToPoint:CGPointMake(rect.size.width / 2.0 + sidelength/2.0, rect.size.height)];
    [path moveToPoint:CGPointMake(x, rect.size.height)];
    [path addLineToPoint:CGPointMake(x+sidelength/2.0, rect.size.height - sidelength)];
    [path addLineToPoint:CGPointMake(x+sidelength, rect.size.height)];
    //关闭path
    [path closePath];

    //三角形内填充颜色
    [[UIColor whiteColor] setFill];

    [path fill];
    //    //三角形的边框为红色
    //    [[UIColor clearColor] setStroke];
    //    [path stroke];
}

- (NSMutableArray *)pionts{
    if (!_pionts) {
        _pionts = [NSMutableArray array];
    }
    return _pionts;
}

- (NSMutableArray *)piontNums{
    if (!_piontNums) {
        _piontNums = [NSMutableArray array];
    }
    return _piontNums;
}
@end
