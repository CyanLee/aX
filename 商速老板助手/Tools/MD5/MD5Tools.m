//
//  MD5Tools.m
//  商速老板助手
//
//  Created by 今日 on 2018/5/14.
//  Copyright © 2018年 luyonghao. All rights reserved.
//

#import "MD5Tools.h"
#import<CommonCrypto/CommonDigest.h>

@implementation MD5Tools

+ (NSString *) md5:(NSString *) input {
    const char *cStr = [input UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), digest ); // This is the md5 call
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return  output;
}

@end
