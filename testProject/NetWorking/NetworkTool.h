//
//  NetworkTool.h
//  testProject
//
//  Created by mac3 on 17/3/13.
//  Copyright © 2017年 test. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface NetworkTool : AFHTTPSessionManager

/**
 *  网络请求工具类全局访问点
 *
 *  @return AFHTTPSessionManager的实例
 */
+ (instancetype)sharedNetworkTool;

/**
 *  网络请求工具类请求的主方法
 *
 *  @param URLString 请求地址
 *  @param success   成功的回调
 *  @param failure     失败的回调
 */

+ (void)POSTWithURLString:(NSString *)URLString parameters:(NSMutableDictionary *)parameters isLoading:(UIView*)loadView
                  success:(void(^)(id responseObject))success faile:(void(^)(NSError *error))failure;


@end
