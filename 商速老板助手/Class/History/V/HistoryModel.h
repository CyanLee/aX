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
@property (nonatomic,weak) NSString *time;
//营业额
@property (nonatomic,weak) NSString *turnoverNum;
//笔数
@property (nonatomic,weak) NSString *num;

@end
