//
//  GraphView.m
//  商速老板助手
//
//  Created by 赵宁 on 2018/5/9.
//  Copyright © 2018年 luyonghao. All rights reserved.
//

#import "GraphView.h"

@interface GraphView ()

/// label pionts
@property (nonatomic,strong)NSMutableArray *pionts;

/// label num
@property (nonatomic,strong)NSMutableArray *piontNums;

@end


@implementation GraphView


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
            [self.pionts addObject:point];
        }
        
        for (int i = 0; i < 7; i ++) {
            UILabel *num = [[UILabel alloc] init];
            num.text = @"33322";
            num.font = [UIFont systemFontOfSize:12];
            num.textAlignment = 1;
            num.textColor = [UIColor whiteColor];
            [self addSubview:num];
            num.backgroundColor = [UIColor clearColor];
            UILabel *piont = self.pionts[i];
            [num mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(piont);
                make.bottom.equalTo(piont.mas_top);
            }];
            num.tag = i;
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


- (void)setModel:(NSObject *)model{
    _model = model;
    
    for (UILabel *label in self.pionts) {
        /// update masory
    }
    
    for (UILabel *label in self.piontNums) {
        /// update masory
    }
}
- (void)drawRect:(CGRect)rect {
    // Drawing code

    //定义画图的path
    UIBezierPath *path = [[UIBezierPath alloc] init];

    CGFloat sidelength = 12;
    //path移动到开始画图的位置
    [path moveToPoint:CGPointMake(rect.size.width / 2.0 - sidelength/2.0, rect.size.height)];
    //从开始位置画一条直线到（rect.origin.x + rect.size.width， rect.origin.y）
    [path addLineToPoint:CGPointMake(rect.size.width / 2.0, rect.size.height - sidelength)];
    //再从rect.origin.x + rect.size.width， rect.origin.y））画一条线到(rect.origin.x + rect.size.width/2, rect.origin.y + rect.size.height)
    [path addLineToPoint:CGPointMake(rect.size.width / 2.0 + sidelength/2.0, rect.size.height)];

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
