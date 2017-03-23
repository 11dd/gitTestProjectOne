//
//  NSMutableAttributedString+RJMuAttStr.h
//  RJDevTools
//
//  Created by HarwordLiu on 16/8/2.
//  Copyright © 2016年 HarwordLiu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>

@interface NSMutableAttributedString (RJMuAttStr)


/**
 *  单纯改变一句话中的某些字的颜色（一种颜色）
 *
 *  @param color    需要改变成的颜色
 *  @param subArray 需要改变颜色的文字数组(要是有相同的 只取第一个)
 *
 *  @return 生成的富文本
 */
- (void)rj_changeCorlorWithColor:(UIColor *)color SubStringArray:(NSArray *)subArray;



/**
 *  单纯改变句子的字间距（需要 <CoreText/CoreText.h>）
 *
 *  @param space       字间距
 *
 *  @return 生成的富文本
 */
- (void)rj_changeSpaceWithSpace:(CGFloat)space;

/**
 *  单纯改变段落的行间距
 *
 *  @param lineSpace   行间距
 *
 *  @return 生成的富文本
 */
- (void)rj_changeLineSpaceWithLineSpace:(CGFloat)lineSpace;

/**
 *  同时更改行间距和字间距
 *
 *  @param lineSpace   行间距
 *  @param textSpace   字间距
 *
 *  @return 生成的富文本
 */
- (void)rj_changeLineAndTextSpaceWithLineSpace:(CGFloat)lineSpace textSpace:(CGFloat)textSpace;

/**
 *  改变某些文字的颜色 并单独设置其字体
 *
 *  @param font        设置的字体
 *  @param color       颜色
 *  @param subArray    想要变色的字符数组
 *
 *  @return 生成的富文本
 */
- (void)rj_changeFontAndColor:(UIFont *)font Color:(UIColor *)color SubStringArray:(NSArray *)subArray;


@end
