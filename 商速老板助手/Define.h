//
//  Define.h
//  商速老板助手
//
//  Created by 赵宁 on 2018/4/26.
//  Copyright © 2018年 luyonghao. All rights reserved.
//

#ifndef Define_h
#define Define_h

//获取屏幕 宽度、高度
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
//---------------------打印日志--------------------------


//----------------------系统----------------------------

//获取系统版本
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
#define CurrentSystemVersion [[UIDevice currentDevice] systemVersion]

//获取当前语言
#define CurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])

//判断是否 Retina屏、设备是否%fhone 5、是否是iPad
#define isRetina ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define isPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

#define iPhoneX ([UIScreen mainScreen].bounds.size.height == 812)
#define iPhone4 ([UIScreen mainScreen].bounds.size.height == 480)


#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height

//判断iPhone6以下的机型
#define iPhoneMin ([UIScreen mainScreen].bounds.size.width == 320)
#define iPhonePLUS ([UIScreen mainScreen].bounds.size.width == 414)

#define TabbarColor [UIColor colorWithRed:83/255.0 green:96/255.0 blue:96/255.0 alpha:1]
#define DefineRedColor [UIColor colorWithRed:205/255.0 green:50/255.0 blue:57/255.0 alpha:1]
//----------------------图片----------------------------

//读取本地图片
#define LOADIMAGE(file,ext) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:file ofType:ext]]

//定义UIImage对象
#define IMAGE(A) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:A ofType:nil]]

//定义UIImage对象
#define ImageNamed(_pointer) [UIImage imageNamed:[UIUtil imageName:_pointer]]

#define ip @"http://www.shopspeed.cn:80/shopspeed_points/BossAssistant/getOpenScreen.do"

#import "AFNetworking.h"
//打印日志
#define LOG_OPEN
#ifdef LOG_OPEN
#   define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#   define DLog(...)
#endif

#endif /* Define_h */
