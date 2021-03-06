//
//  GSKeyChainDataManager.h
//  keychaintest
//
//  Created by Apple on 16/8/2.
//  Copyright © 2016年 张国森. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GSKeyChainDataManager : NSObject

/**
 *   存储 UUID
 *
 *     */
+(void)saveUUID:(NSString *)UUID key:(NSString *)key;

/**
 *  读取UUID *
 *
 */
+(NSString *)readUUIDkey:(NSString *)key;

/**
 *    删除数据
 */
+(void)deleteUUIDkey:(NSString *)key;


@end
