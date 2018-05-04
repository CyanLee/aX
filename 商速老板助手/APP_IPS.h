//
//  APP_IPS.h
//  商速老板助手
//
//  Created by 赵宁 on 2018/5/4.
//  Copyright © 2018年 luyonghao. All rights reserved.
//

#ifndef APP_IPS_h
#define APP_IPS_h

/// app启动页
static NSString *APP_START_IMG_URL = @"http://www.shopspeed.cn:80/shopspeed_points/BossAssistant/userLogin.do";

/// 登录
static NSString *APP_LOGON_URL = @"http://www.shopspeed.cn:80/shopspeed_points/BossAssistant/userLogin.do";

/// 忘记密码
static NSString *APP_FORGET_PWS_URLF = @"http://www.shopspeed.cn:80/shopspeed_points/BossAssistant/modifyUserPwd.do";

/// 获取手机验证码
static NSString *APP_CODE_URL = @"http://www.shopspeed.cn:80/shopspeed_points/SMSDeal/GetIdentCode.do";

/// 历史数据
static NSString *APP_HISTORY_URL = @"http://www.shopspeed.cn:80/shopspeed_points/BossAssistant/getDayBusiness.do";

/// 销售量前10
static NSString *APP_SALE_SORT_10_URL = @"http://www.shopspeed.cn:80/shopspeed_points/BossAssistant/getTopNumsSaleItems.do";

/// 销售金额前10
static NSString *APP_SALE_MONEY_10_URL = @"http://www.shopspeed.cn:80/shopspeed_points/BossAssistant/getTopAmountSaleItems.do";

/// 商品类别销量情况
static NSString *APP_SALE_GOODS_URL = @"http://www.shopspeed.cn:80/shopspeed_points/BossAssistant/getSaleItemTypes.do";

/// 收银情况汇总
static NSString *APP_SALE_BACK_URL = @"http://www.shopspeed.cn:80/shopspeed_points/BossAssistant/getPayments.do";


#endif /* APP_IPS_h */
