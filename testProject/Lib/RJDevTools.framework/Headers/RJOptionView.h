//
//  RJOptionView.h
//  RJDevTools
//
//  Created by HarwordLiu on 16/8/4.
//  Copyright © 2016年 HarwordLiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RJOptionViewDelegate <NSObject>

/**
 *  选项卡选中第几个
 *
 *  @param index 第几个
 */
- (void)optionViewSelectedIndex:(NSInteger)index;

@end

@interface RJOptionView : UIView
/**
 *  初始化方法
 *
 *  @param frame           整个选项卡frame
 *  @param array           选项卡标题数组
 *  @param titleColor      标题文字颜色
 *  @param backgroundColor 背景颜色
 *  @param selectedColor   选中选项卡颜色
 *
 *  @return RJOptionView
 */
- (instancetype)initWithFrame:(CGRect)frame TitleArray:(NSArray *)array TitleColor:(UIColor *)titleColor BackgroundColor:(UIColor *)backgroundColor SelectedColor:(UIColor *)selectedColor;
/**
 *  初始化方法
 *
 *  @param frame           整个选项卡frame
 *  @param array           选项卡标题数组
 *  @param titleColor      标题文字颜色
 *  @param backgroundColor 背景颜色
 *  @param selectedColor   选中选项卡颜色
 *
 *  @return RJOptionView
 */
+ (instancetype)optionViewWithFrame:(CGRect)frame TitleArray:(NSArray *)array TitleColor:(UIColor *)titleColor BackgroundColor:(UIColor *)backgroundColor SelectedColor:(UIColor *)selectedColor;

@property (nonatomic, assign) id delegate;
/**
 *  设置默认选择第几个选项卡
 *  注意：此方法不会回调点击方法
 *
 *  @param selectedIndex 第几个选项卡
 */
- (void)setSelectedIndex:(NSInteger)selectedIndex;

@end
