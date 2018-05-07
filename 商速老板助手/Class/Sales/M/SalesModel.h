//
//  SalesModel.h
//  商速老板助手
//
//  Created by 赵宁 on 2018/5/5.
//  Copyright © 2018年 luyonghao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SalesModel : NSObject

/// 商店销量前10 && 销售金额前10
@property (nonatomic,copy)NSString *itemName;
@property (nonatomic,copy)NSString *saleNums;
@property (nonatomic,copy)NSString *txAmt;

/// 收银情况汇总
@property (nonatomic,copy)NSString *payAmt;
@property (nonatomic,copy)NSString *payTimes;
@property (nonatomic,copy)NSString *payType;

/// model置空
+ (instancetype)define;
@end
