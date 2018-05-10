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



#define notNet @"连接网络失败"
#import "NetTools.h"
#import "SVProgressHUD.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#define MaxPage 20 /// 加载数据默认
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;
//打印日志
#define LOG_OPEN
#ifdef LOG_OPEN
#   define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#   define DLog(...)
#endif


// NSlocalizeString 第一个参数是内容,根据第一个参数去对应语言的文件中取对应的字符串，第二个参数将会转化为字符串文件里的注释，可以传nil，也可以传空字符串@""。
#define NSLocalized(key, comment) [[NSBundle mainBundle] localizedStringForKey:(key) value:@"" table:nil]

#pragma mark- 保存键值对到应用
#define UD_GET_OBJ(KEY) [[NSUserDefaults standardUserDefaults] objectForKey:(KEY)]
#define UD_SET_OBJ(OBJ,KEY)  [[NSUserDefaults standardUserDefaults] setObject:(OBJ) forKey:(KEY)]; [[NSUserDefaults standardUserDefaults] synchronize]

#endif /* Define_h */
