//
//  TimeView.h
//  商速老板助手
//
//  Created by LusHo on 2018/5/1.
//  Copyright © 2018年 luyonghao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimeView : UIView

@property (nonatomic,copy)void(^chooseTimeBlock)(UIButton *btn);
@property (nonatomic,copy)void(^btnDidClickedBlock)(UIButton *btn);

- (instancetype)initWithTimeH:(CGFloat)timeH WithSwicthTimeH:(CGFloat)swicthTimeH;

@property (nonatomic,strong)NSMutableArray *models;
@end
