//
//  SalesCell.h
//  商速老板助手
//
//  Created by 今日 on 2018/5/4.
//  Copyright © 2018年 luyonghao. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SalesModel.h"

@interface SalesCell : UITableViewCell

@property (nonatomic,strong)SalesModel *model;
@property (nonatomic,assign)NSInteger type;

@end
