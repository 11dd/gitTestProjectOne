//
//  BaseModel.h
//  RWUIControls
//
//  Created by shenchengcai on 15/3/3.
//  Copyright (c) 2015年 QM. All rights reserved.
//

/*******************************************************
 类名：BaseModel.h
 功能描述：基础类，定义通用的数据类型
 
 */

#import <Foundation/Foundation.h>

@interface BaseModel : NSObject <NSCoding>

@property (nonatomic, copy) NSString *objectId;

+ (id)objectFromDictionary:(NSDictionary*)dictionary;

- (id)initWithDictionary:(NSDictionary *)dictionary;

- (NSMutableDictionary *)toDictionary;

//json解析
- (NSString *)json;

//转成字典格式
- (NSDictionary *)dictionary;

@end
