//
//  CoverView.m
//  商速老板助手
//
//  Created by 赵宁 on 2018/4/28.
//  Copyright © 2018年 luyonghao. All rights reserved.
//

#import "CoverView.h"

@implementation CoverView

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (self.touchBegin) {
        self.touchBegin();
    }
}

@end
