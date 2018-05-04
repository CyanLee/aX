//
//  UserModel.m
//  商速老板助手
//
//  Created by 赵宁 on 2018/5/4.
//  Copyright © 2018年 luyonghao. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel
+ (SaveTheJsonStatus)saveTheJson:(id)json{
    if (json) {
        NSUserDefaults *def =  [NSUserDefaults standardUserDefaults];
        [def setObject:json forKey:@"UserModel"];
        BOOL res = [def synchronize];
        return res == true ? Suss : Synchronize_Error;
    }
    return Json_Is_NULL;
}

+ (UserModel *)getUserModel{
    NSUserDefaults *def =  [NSUserDefaults standardUserDefaults];
    id json = [def objectForKey:@"UserModel"];
    return json == nil ? nil : [UserModel mj_objectWithKeyValues:json];
}
@end
