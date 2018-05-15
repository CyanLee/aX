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
    
    //1。创建管理者对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    //2.上传文件
    [manager POST:URLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:imageData name:@"file" fileName:@"123.png" mimeType:@"image/png"];
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
//    [manager POST:urlString parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//        //上传文件参数
//        UIImage *iamge = [UIImage imageNamed:@"123.png"];
//        NSData *data = UIImagePNGRepresentation(iamge);
//        //这个就是参数
//        [formData appendPartWithFileData:data name:@"file" fileName:@"123.png" mimeType:@"image/png"];
//
//    } progress:^(NSProgress * _Nonnull uploadProgress) {
//
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//
//        //请求成功
//        WKNSLog(@"请求成功：%@",responseObject);
//
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//
//        //请求失败
//        WKNSLog(@"请求失败：%@",error);
//    }];
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
        return [responseObject objectForKey:@"resultDesc"];
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
