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
        DLog(@"responseObject == %@",responseObject);
        //0:成功，1:没有登录，2:参数错误， 3:系统错误
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
@end
