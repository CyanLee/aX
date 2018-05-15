//
//  NetTools.h
//  商速老板助手
//
//  Created by 赵宁 on 2018/5/2.
//  Copyright © 2018年 luyonghao. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AFNetworking.h"
@interface NetTools : NSObject

+ (void)POST:(NSString *)URLString parameters:(id)parameters success:(void (^)(id responseObject))success failure:(void (^)( NSString * errStr))failure;

+ (void)POST:(NSString *)URLString parameters:(id)parameters imageData:(NSData *)imageData constructingBodyWithBlocksuccess:(void (^)(id responseObject))success failure:(void (^)( id errStr))failure;

+ (NSString*)dictionaryToJson:(NSDictionary *)dic;

@end
