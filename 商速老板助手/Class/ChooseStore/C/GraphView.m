//
//  GraphView.m
//  商速老板助手
//
//  Created by 赵宁 on 2018/5/9.
//  Copyright © 2018年 luyonghao. All rights reserved.
//

#import "GraphView.h"
#import "HistoryModel.h"
#import "DotLabel.h"
#define uniformSpace 12
@interface GraphView ()

/// label pionts
@property (nonatomic,strong)NSMutableArray *pionts;

/// label num
@property (nonatomic,strong)NSMutableArray *piontNums;

@property (nonatomic,strong)NSMutableArray *piontYs;
@property (nonatomic,weak)CAShapeLayer *shapeLayer;
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
            line.backgroundColor = [UIColor colorWithRed:155.0/255.0 green:155.0/255.0 blue:155.0/255.0 alpha:1];
            [line mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(line1.mas_bottom).mas_offset(30);
                make.height.width.mas_equalTo(1);
                make.left.mas_offset(i * 2.0);
            }];
        }
        
        for (int i = 0; i < 7; i ++) {
            DotLabel *point = [[DotLabel alloc] init];
            //point.text = @"😝";
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
    
    [self clearArrayAndUI]; // 清空记载数据
    
    [self showUI:models]; // 显示与隐藏数字，点
    
    [self contrastModel:models];// 找出最高点
    
    [self setNeedsDisplay];
}

- (void)clearArrayAndUI{
    [self.piontYs removeAllObjects];
    
    if (self.shapeLayer) {
        [self.shapeLayer removeFromSuperlayer];
        self.shapeLayer = nil;
    }
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
    /// update masory
    // 等分
    int uniform = maxNum / minNum;
    // 一个阶级 12 个像素
    NSInteger count = models.count;
    if (count > 7) count = 7;
    for (int i = 0; i < count; i++) {
        HistoryModel *model = models[i];
        float txAmt = [model.txAmt floatValue];
        UILabel *num = self.piontNums[i];
        UILabel *piont = self.pionts[i];
        if (txAmt == minNum) {// 取反
            [piont mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(kWidth/7.0*i);
                make.centerY.equalTo(self).mas_offset(7+uniform/2.0*uniformSpace);
                make.width.mas_equalTo(kWidth/7.0);
                make.height.mas_equalTo(20);
            }];
            [num mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(piont).mas_offset(3);
                make.right.equalTo(piont).mas_offset(-3);
                make.bottom.equalTo(piont.mas_top);
            }];
            id dic = @{@"model":model,@"toCenterYSpace":[NSString stringWithFormat:@"%f",7+uniform/2.0*uniformSpace]};
            [self.piontYs addObject:dic];
        }else if (txAmt == maxNum){
            [piont mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(kWidth/7.0*i);
                make.centerY.equalTo(self).mas_offset(7-uniform/2.0*uniformSpace);
                make.width.mas_equalTo(kWidth/7.0);
                make.height.mas_equalTo(20);
            }];
            [num mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(piont).mas_offset(3);
                make.right.equalTo(piont).mas_offset(-3);
                make.bottom.equalTo(piont.mas_top);
            }];
            id dic = @{@"model":model,@"toCenterYSpace":[NSString stringWithFormat:@"%f",7-uniform/2.0*uniformSpace]};
            [self.piontYs addObject:dic];
        }else{
            CGFloat minY = 7+uniform/2.0*uniformSpace;// 销量金额最小的Y值
            CGFloat space = txAmt/minNum*uniformSpace;// 间距
            [piont mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(kWidth/7.0*i);
                make.centerY.equalTo(self).mas_offset(minY-space);
                make.width.mas_equalTo(kWidth/7.0);
                make.height.mas_equalTo(20);
            }];
            [num mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(piont).mas_offset(3);
                make.right.equalTo(piont).mas_offset(-3);
                make.bottom.equalTo(piont.mas_top);
            }];
            id dic = @{@"model":model,@"toCenterYSpace":[NSString stringWithFormat:@"%f",minY-space]};
            [self.piontYs addObject:dic];
        }
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
    
    if (self.models.count == 0 || !self.models) return;
    
    [self drawTriangle:rect];
    //
    [self drawGraph:rect];
    
}

- (void)drawTriangle:(CGRect)rect{
    CGFloat count = self.models.count;
    //定义画图的path
    UIBezierPath *path = [[UIBezierPath alloc] init];
    CGFloat sidelength = 12;
    CGFloat x = kWidth/7.0*(7.0-1)-sidelength/2.0+kWidth/7.0/2.0;/// 这是最右边的x。
    x = x - (7.0-count)*kWidth/7.0; /// 这是对应的x
    [path moveToPoint:CGPointMake(x, rect.size.height)];
    [path addLineToPoint:CGPointMake(x+sidelength/2.0, rect.size.height - sidelength)];
    [path addLineToPoint:CGPointMake(x+sidelength, rect.size.height)];
    //关闭path
    [path closePath];
    
    //三角形内填充颜色
    [[UIColor whiteColor] setFill];
    
    [path fill];
}

- (void)drawGraph:(CGRect)rect{
    UIBezierPath *path0 = [UIBezierPath bezierPath];
    NSMutableArray *pathArr = [NSMutableArray array];
    CGFloat centerY = rect.size.height/2;
    CGPoint first = CGPointMake(0.0, centerY);
    CGPoint last= CGPointMake(kWidth,centerY);
    for (int i = 0; i < self.piontYs.count; i ++) {
        if (i == 0) {
            id dic = self.piontYs[i];
            for (HistoryModel *model in self.models) {
                if ([model isEqual:dic[@"model"]]) {
                    NSString *toCenterYSpace = dic[@"toCenterYSpace"];
                    CGPoint p = CGPointMake(kWidth/7.0/2, centerY+toCenterYSpace.floatValue);
                    first = p;
                    NSValue *v = [NSValue valueWithCGPoint:p];
                    [pathArr addObject:v];
                }
            }
        }else if (i == 6){
            id dic = self.piontYs[i];
            for (HistoryModel *model in self.models) {
                if ([model isEqual:dic[@"model"]]) {
                    NSString *toCenterYSpace = dic[@"toCenterYSpace"];
                    CGPoint p = CGPointMake(kWidth-(kWidth/7.0/2), centerY+toCenterYSpace.floatValue);
                    NSValue *v = [NSValue valueWithCGPoint:p];
                    [pathArr addObject:v];
                    last = p;
                }
            }
        }else{
            id dic = self.piontYs[i];
            for (HistoryModel *model in self.models) {
                if ([model isEqual:dic[@"model"]]) {
                    NSString *toCenterYSpace = dic[@"toCenterYSpace"];
                    CGPoint p = CGPointMake(kWidth/7.0*i+(kWidth/7.0/2), centerY+toCenterYSpace.floatValue);
                    NSValue *v = [NSValue valueWithCGPoint:p];
                    [pathArr addObject:v];
                    last = p;
                }
            }
        }
    }
    [path0 moveToPoint:CGPointMake(0.0, centerY)];
    [path0 addLineToPoint:first];
    for (NSInteger i=0; i<pathArr.count - 3; i++) {
        CGPoint t0 = [pathArr[i+0] CGPointValue];
        CGPoint t1 = [pathArr[i+1] CGPointValue];
        CGPoint t2 = [pathArr[i+2] CGPointValue];
        CGPoint t3 = [pathArr[i+3] CGPointValue];
        //
        for (int i=0; i<100; i++) {
            CGFloat t = i/100.0;
            CGPoint point = [self getPoint:t p0:t0 p1:t1 p2:t2 p3:t3];
            [path0 addLineToPoint:point];
        }
    }
    [path0 addLineToPoint:last];
    if (pathArr.count == 7) {
        [path0 addLineToPoint:CGPointMake(kWidth,centerY)];
    }
    //
    //关闭path
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = CGRectMake(0.0, 0.0, rect.size.width, rect.size.height);
    shapeLayer.lineWidth = 1.0;
    shapeLayer.lineCap = @"round";
    shapeLayer.strokeColor = [[UIColor whiteColor] CGColor];
    shapeLayer.fillColor = [[UIColor clearColor] CGColor];
    shapeLayer.path = [path0 CGPath];
    shapeLayer.strokeStart = 0.0;
    shapeLayer.strokeEnd = 1.0;
    [self.layer addSublayer:shapeLayer];
    self.shapeLayer = shapeLayer;
}
/**
 Catmull-Rom算法
 根据四个点计算中间点
 */
- (CGPoint)getPoint:(CGFloat)t p0:(CGPoint)p0 p1:(CGPoint)p1 p2:(CGPoint)p2 p3:(CGPoint)p3 {
    CGFloat t2 = t*t;
    CGFloat t3 = t2*t;
    
    CGFloat f0 = -0.5*t3 + t2 - 0.5*t;
    CGFloat f1 = 1.5*t3 - 2.5*t2 + 1.0;
    CGFloat f2 = -1.5*t3 + 2.0*t2 + 0.5*t;
    CGFloat f3 = 0.5*t3 - 0.5*t2;
    
    CGFloat x = p0.x*f0 + p1.x*f1 + p2.x*f2 +p3.x*f3;
    CGFloat y = p0.y*f0 + p1.y*f1 + p2.y*f2 +p3.y*f3;
    
    return CGPointMake(x, y);
    
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

- (NSMutableArray *)piontYs{
    if (!_piontYs) {
        _piontYs = [NSMutableArray array];
    }
    return _piontYs;
}
@end
