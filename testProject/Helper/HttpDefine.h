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

/** 友盟appKey */
# define UMAppKey                  @"5465c050fd98c57e3a000b46"

/** 微信appKey */
# define WXAppKey                  @"wx75590c2744537220"

/** 微信AppSecret */
# define WXAppSecret               @"f052dfd9477127bac59d4679232e159c"

/** QQAppID */
# define QQAppID                   @"1105426859"

/** QQAppKey */
# define QQAppKey                  @"ViPeKqd3nByLEh3v"

/** 微博AppKey */
# define SinaAppKey                @"2631344004"

/** 微博AppSecret */
# define SinaAppSecret             @"bebbd3dd3229600c9c8d739f82cf83a2"

/** 百度地图Key */
# define BaiDuMapKey               @"9FDBhHClzU51GqvGLBeP7Wrx"

/** 版本号 */

/**********************************************/
/** 登录 */


/**********************************************/
/** 个人中心 */






/**********************************************/



/**********************************************/





#endif
