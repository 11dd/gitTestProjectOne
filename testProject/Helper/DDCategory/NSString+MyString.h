//
//  NSString+MyString.h
//  HitPool
//
//  Created by jyzml_success on 16/4/20.
//  Copyright © 2016年 . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MyString)

- (NSString *)MD5Hash16;

- (NSString *)MD5Hash32;

- (NSString*)conversionTimestampToString;


- (NSString *)strToUTF8;

- (NSString *)UTF8ToStr;

- (BOOL)isNumber;

//防止出Null或者nil
- (NSString *)getNotNullStr:(NSString *)str;

@end
