//
//  InfoView.h
//  商速老板助手
//
//  Created by 赵宁 on 2018/5/3.
//  Copyright © 2018年 luyonghao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InfoView : UIView

@property (nonatomic,copy)void(^reportBtnBlock)(void);
@property (nonatomic,copy)void(^historyBtnBlock)(void);
@property (nonatomic,copy)void(^segmentedCBlock)(NSInteger);

@property (nonatomic,strong)NSMutableArray *graphViewModels;

@property (nonatomic,assign)BOOL showNum;
@end
