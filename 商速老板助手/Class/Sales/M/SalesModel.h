//
//  SalesModel.h
//  商速老板助手
//
//  Created by 赵宁 on 2018/5/5.
//  Copyright © 2018年 luyonghao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SalesModel : NSObject

@property (nonatomic,copy)NSString *payAmt;
@property (nonatomic,copy)NSString *payTimes;
@property (nonatomic,copy)NSString *payType;

/// model置空
+ (instancetype)define;
@end
