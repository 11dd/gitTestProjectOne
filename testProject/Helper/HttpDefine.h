//
//  Define.h
//  HitPool
//
//  Created by  on 16/5/29.
//  Copyright © 2016年 . All rights reserved.
//

#ifndef Define_h
#define Define_h

#define appVerson  [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

#if 1

/**
 *    正式环境地址
 */

# define PUBLIC_DYNAMIC_URL        @"http://    /%@"
# define SPLICE_URL(SpliceStr)     [NSString stringWithFormat:PUBLIC_DYNAMIC_URL,SpliceStr]

#else

/**
 *    测试环境地址
 */
# define PUBLIC_DYNAMIC_URL        @"http://    /ForAppSvc/%@"
# define SPLICE_URL(SpliceStr)     [NSString stringWithFormat:PUBLIC_DYNAMIC_URL,SpliceStr]

#endif


/** 微信appKey */
# define WXAppKey                  @""

/** 微信AppSecret */
# define WXAppSecret               @""

/** QQAppID */
# define QQAppID                   @""

/** QQAppKey */
# define QQAppKey                  @""

/** 微博AppKey */
# define SinaAppKey                @""

/** 微博AppSecret */
# define SinaAppSecret             @""

/** 百度地图Key */
# define BaiDuMapKey               @""

/** 版本号 */

/**********************************************/
/** 登录 */


/**********************************************/
/** 个人中心 */






/**********************************************/



/**********************************************/





#endif
