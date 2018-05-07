//
//  SalesModel.m
//  商速老板助手
//
//  Created by 赵宁 on 2018/5/5.
//  Copyright © 2018年 luyonghao. All rights reserved.
//

#import "SalesModel.h"

@implementation SalesModel

+ (instancetype)define{
    SalesModel *tmp = [[SalesModel alloc]init];
    tmp.payAmt = @"暂无";
    tmp.payTimes = @"暂无";
    tmp.payType = @"暂无";
    tmp.itemName = @"暂无";
    tmp.saleNums = @"暂无";
    tmp.txAmt = @"暂无";
    return tmp;
}
@end
