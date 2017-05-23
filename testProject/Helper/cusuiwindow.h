//
//  cusuiwindow.h
//  米哈健身
//
//  Created by dlrj on 17/4/18.
//  Copyright © 2017年 test. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SingleTon.h"
@interface cusuiwindow : NSObject
single_interface(cusuiwindow)

@property(strong,nonatomic)UIWindow *window;
@property(strong,nonatomic)UIButton *button;


/*
 全局悬浮按钮
 createButton 创建
 removeButton 移除
 */
- (void)createButton;

- (void)removeButton;

@end
