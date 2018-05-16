//
//  NetTools.m
//  商速老板助手
//
//  Created by 赵宁 on 2018/5/2.
//  Copyright © 2018年 luyonghao. All rights reserved.
//

#import "NetTools.h"


@implementation NetTools

+ (void)POST:(NSString *)URLString parameters:(id)parameters success:(void (^)(id responseObject))success failure:(void (^)( NSString * errStr))failure{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.requestSerializer.timeoutInterval = 15;
    [manager POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([NetTools serverError:responseObject] == 0) {
            success(responseObject);
        }else{
            failure([NetTools getServerErrorDes:responseObject]);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        DLog(@"boom网络炸了");
        failure(notNet);
    }];
}

+ (void)POST:(NSString *)URLString parameters:(id)parameters imageData:(NSData *)imageData constructingBodyWithBlocksuccess:(void (^)(id responseObject))success failure:(void (^)(id errStr))failure{
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.requestSerializer = [AFJSONRequestSerializer serializer];
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    session.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
    NSString *fileName = [NSString stringWithFormat:@"%@.png", @"image1"];
    [session POST:URLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:imageData name:@"image1" fileName:fileName mimeType:@"image/png"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, NSObject *responseObject) {
        if ([responseObject isKindOfClass:[NSData class]]) {
            NSDictionary * dic = [self serializationJsonData:(NSData*)responseObject];
            if ([NetTools serverError:dic] == 0) {
                success(dic);
            }else{
                failure([NetTools getServerErrorDes:dic]);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error.userInfo);
        DLog(@"boom网络炸了");
        failure(notNet);
    }];
}

/// 序列化data
+ (NSDictionary *)serializationJsonData:(NSData *)data{
    NSString *receiveStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSData * jsonData = [receiveStr dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:nil];
    return jsonDict;
}

+ (NSInteger)serverError:(id)responseObject{
    if ([responseObject objectForKey:@"resultCode"]) {
        NSString *resultCode = [responseObject objectForKey:@"resultCode"];
        return resultCode.integerValue;
    }
    return -1;
}

+ (NSString *)getServerErrorDes:(id)responseObject{
    if ([responseObject objectForKey:@"resultDesc"]) {
        return  [responseObject objectForKey:@"resultDesc"];
    }else{
       return notNet;
    }
}

/**
 *  字典转JSON字符串
 *
 *  @param dic 字典
 *
 *  @return JSON字符串
 */
+ (NSString*)dictionaryToJson:(NSDictionary *)dic{
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

@end
