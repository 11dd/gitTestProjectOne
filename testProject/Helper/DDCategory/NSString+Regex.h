//
//  NSString+Regex.h
//  MyExperience
//
//  Created by _Andrew on 16/8/2.
//  Copyright © 2016年 . All rights reserved.
//

/** NSString 正则表达式处理 */

#import <Foundation/Foundation.h>

@interface NSString (Regex)

/** 判断是否为纯中文字符 */
- (BOOL)isChineseChar;

/** 判断是否为手机号 */
- (BOOL)isPhoneNumber;

@end
