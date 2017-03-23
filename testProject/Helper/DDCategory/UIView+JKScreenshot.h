//
//  UIView+Screenshot.h
//  JKCategories
//
//  Created by Jakey on 15/1/10.
//  Copyright (c) 2015年 . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (JKScreenshot)
/**
 *  @brief  view截图
 *
 *  @return 截图
 */
- (UIImage *)jk_screenshot;

/**
 *  @author Jakey
 *
 *  @brief  截图一个view中所有视图 包括旋转缩放效果
 *
    一个view
 *   限制缩放的最大宽度 保持默认传0
 *
 *  @return 截图
 */
- (UIImage *)jk_screenshot:(CGFloat)maxWidth;
@end
