//
//  UIView+UIView_BlockGesture.h
//  JKCategories
//
//  Created by Jakey on 14/12/30.
//  Copyright (c) 2014年 . All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^JKGestureActionBlock)(UIGestureRecognizer *gestureRecoginzer);

@interface UIView (JKBlockGesture)
/**
 *  @brief  添加tap手势
 *
 *  @param block 代码块
 */
- (void)jk_addTapActionWithBlock:(JKGestureActionBlock)block;
/**
 *  @brief  添加长按手势
 *
 *  @param block 代码块
 */
- (void)jk_addLongPressActionWithBlock:(JKGestureActionBlock)block;
@end
