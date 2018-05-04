//
//  UserModel.h
//  商速老板助手
//
//  Created by 赵宁 on 2018/5/4.
//  Copyright © 2018年 luyonghao. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef enum : NSUInteger {
    Suss = 0 ,
    Json_Is_NULL = 1,
    Synchronize_Error = 2,
    Other_Error = 3
} SaveTheJsonStatus;

@interface UserModel : NSObject

@property (nonatomic,copy)NSString *jwt;
@property (nonatomic,copy)NSString *loginTime;
@property (nonatomic,copy)NSString *resultCode;
@property (nonatomic,copy)NSString *resultDesc;
@property (nonatomic,copy)NSString *userId;
@property (nonatomic,copy)NSString *userName;


+ (SaveTheJsonStatus)saveTheJson:(id)json;

+ (UserModel *)getUserModel;
@end
