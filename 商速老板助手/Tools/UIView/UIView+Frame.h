//
//  UIView+Frame.h
//  商速老板助手
//
//  Created by 赵宁 on 2018/5/2.
//  Copyright © 2018年 luyonghao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)
@property (nonatomic,assign)CGFloat x;
@property (nonatomic,assign)CGFloat y;

@property (nonatomic,assign)CGFloat centerX;
@property (nonatomic,assign)CGFloat centerY;

@property (nonatomic,assign)CGFloat width;
@property (nonatomic,assign)CGFloat height;

///需要确定width
@property (nonatomic,assign)CGFloat rightX;
///需要确定height
@property (nonatomic,assign)CGFloat bottomY;
@end
