//
//  UIAlertView+Block.h
//  JKCategories
//
//  Created by  on 15/5/9.
//  Copyright (c) 2015年 All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^UIAlertViewJKCallBackBlock)(NSInteger buttonIndex);

@interface UIAlertView (JKBlock)<UIAlertViewDelegate>

@property (nonatomic, copy) UIAlertViewJKCallBackBlock jk_alertViewCallBackBlock;

+ (void)jk_alertWithCallBackBlock:(UIAlertViewJKCallBackBlock)alertViewCallBackBlock
                            title:(NSString *)title message:(NSString *)message  cancelButtonName:(NSString *)cancelButtonName
                otherButtonTitles:(NSString *)otherButtonTitles, ...NS_REQUIRES_NIL_TERMINATION;

@end
