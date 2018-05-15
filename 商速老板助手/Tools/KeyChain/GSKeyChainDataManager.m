//
//  GSKeyChainDataManager.m
//  keychaintest
//
//  Created by Apple on 16/8/2.
//  Copyright © 2016年 张国森. All rights reserved.
//

#import "GSKeyChainDataManager.h"
#import "GSKeyChain.h"
@implementation GSKeyChainDataManager

//static NSString * const KEY_IN_KEYCHAIN_UUID = @"唯一识别的KEY_UUID";
//static NSString * const KEY_UUID = @"唯一识别的key_uuid";

+(void)saveUUID:(NSString *)UUID key:(NSString *)key{
    
    NSMutableDictionary *usernamepasswordKVPairs = [NSMutableDictionary dictionary];
    [usernamepasswordKVPairs setObject:UUID forKey:key];
    
    [GSKeyChain save:key data:usernamepasswordKVPairs];
}

+(NSString *)readUUIDkey:(NSString *)key{
    
    NSMutableDictionary *usernamepasswordKVPair = (NSMutableDictionary *)[GSKeyChain load:key];
    
    return [usernamepasswordKVPair objectForKey:key];
    
}

+(void)deleteUUIDkey:(NSString *)key{
    
    [GSKeyChain delete:key];
    
}

@end
