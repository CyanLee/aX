//
//  HistoryModel.h
//  商速老板助手
//
//  Created by 今日 on 2018/5/4.
//  Copyright © 2018年 luyonghao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HistoryModel : NSObject

//时间
@property (nonatomic,copy) NSString *dealDate;
//营业额
@property (nonatomic,copy) NSString *txAmt;
//笔数
@property (nonatomic,copy) NSString *saleNums;

@end
