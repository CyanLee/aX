//
//  DotLabel.m
//  商速老板助手
//
//  Created by 赵宁 on 2018/5/18.
//  Copyright © 2018年 luyonghao. All rights reserved.
//

#import "DotLabel.h"

@implementation DotLabel

- (instancetype)init{
    if (self = [super init]) {
        UIView *dot = [[UIView alloc]init];
        [self addSubview:dot];
        [dot mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
            make.height.width.mas_equalTo(8);
        }];
        dot.backgroundColor = [UIColor whiteColor];
        dot.layer.cornerRadius = 4;
        dot.layer.masksToBounds = true;
    }
    return self;
}
@end
