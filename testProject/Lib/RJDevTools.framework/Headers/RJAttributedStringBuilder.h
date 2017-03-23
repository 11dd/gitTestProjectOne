//
//  RJAttributedStringRange.h
//  RJDevTools
//
//  Created by HarwordLiu on 16/8/2.
//  Copyright © 2016年 HarwordLiu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class RJAttributedStringBuilder;

/* Attribute 对照表
 NSFontAttributeName ：字体字号
 value值：UIFont类型
 
 NSParagraphStyleAttributeName ： 段落样式
 value值：NSParagraphStyle类型（其属性如下）
 lineSpacing 行间距(具体用法可查看上面的设置行间距API)
 paragraphSpacing 段落间距
 alignment 对齐方式
 firstLineHeadIndent 指定段落开始的缩进像素
 headIndent 调整全部文字的缩进像素
 
 NSForegroundColorAttributeName 字体颜色
 value值：UIColor类型
 
 NSBackgroundColorAttributeName 背景颜色
 value值：UIColor类型
 
 NSObliquenessAttributeName 字体粗倾斜
 value值：NSNumber类型
 
 NSExpansionAttributeName 字体加粗
 value值：NSNumber类型(比例) 0就是不变 1增加一倍
 
 NSKernAttributeName 字间距
 value值：CGFloat类型
 
 NSUnderlineStyleAttributeName 下划线
 value值：1或0
 
 NSUnderlineColorAttributeName 下划线颜色
 value值：UIColor类型
 
 NSStrikethroughStyleAttributeName 删除线
 value值：1或0
 
 NSStrikethroughColorAttributeName 删除线颜色
 value值：UIColor类型
 
 NSStrokeColorAttributeName 字体颜色
 value值：UIColor类型
 
 NSStrokeWidthAttributeName 字体描边
 value值：CGFloat
 
 NSLigatureAttributeName 连笔字
 value值：1或0
 
 NSShadowAttributeName 阴影
 value值：NSShawdow类型（下面是其属性）
 shadowOffset 影子与字符串的偏移量
 shadowBlurRadius 影子的模糊程度
 shadowColor 影子的颜色
 
 NSTextEffectAttributeName 设置文本特殊效果,目前只有图版印刷效果可用
 value值：NSString类型
 
 NSAttachmentAttributeName 设置文本附件
 value值：NSTextAttachment类型（没研究过，可自行百度研究）
 
 NSLinkAttributeName 链接
 value值：NSURL (preferred) or NSString类型
 
 NSBaselineOffsetAttributeName 基准线偏移
 value值：NSNumber类型
 
 NSWritingDirectionAttributeName 文字方向 分别代表不同的文字出现方向
 value值：@[@(1),@(2)]
 
 NSVerticalGlyphFormAttributeName 水平或者竖直文本 在iOS没卵用，不支持竖版
 value值：1竖直 0水平
 */

/**属性字符串区域***/
@interface RJAttributedStringRange : NSObject


-(RJAttributedStringRange*)setFont:(UIFont*)font;              //字体
-(RJAttributedStringRange*)setTextColor:(UIColor*)color;       //文字颜色
-(RJAttributedStringRange*)setBackgroundColor:(UIColor*)color; //背景色
-(RJAttributedStringRange*)setParagraphStyle:(NSParagraphStyle*)paragraphStyle;  //段落样式
-(RJAttributedStringRange*)setLigature:(BOOL)ligature;  //连体字符，好像没有什么作用
-(RJAttributedStringRange*)setKern:(CGFloat)kern; //字间距
-(RJAttributedStringRange*)setLineSpacing:(CGFloat)lineSpacing;   //行间距
-(RJAttributedStringRange*)setStrikethroughStyle:(int)strikethroughStyle;  //删除线
-(RJAttributedStringRange*)setStrikethroughColor:(UIColor*)StrikethroughColor NS_AVAILABLE_IOS(7_0);  //删除线颜色
-(RJAttributedStringRange*)setUnderlineStyle:(NSUnderlineStyle)underlineStyle; //下划线
-(RJAttributedStringRange*)setUnderlineColor:(UIColor*)underlineColor NS_AVAILABLE_IOS(7_0);  //下划线颜色
-(RJAttributedStringRange*)setShadow:(NSShadow*)shadow;                          //阴影
-(RJAttributedStringRange*)setTextEffect:(NSString*)textEffect NS_AVAILABLE_IOS(7_0);
-(RJAttributedStringRange*)setAttachment:(NSTextAttachment*)attachment NS_AVAILABLE_IOS(7_0); //将区域中的特殊字符: NSAttachmentCharacter,替换为attachement中指定的图片,这个来实现图片混排。
-(RJAttributedStringRange*)setLink:(NSURL*)url NS_AVAILABLE_IOS(7_0);   //设置区域内的文字点击后打开的链接
-(RJAttributedStringRange*)setBaselineOffset:(CGFloat)baselineOffset NS_AVAILABLE_IOS(7_0);  //设置基线的偏移量，正值为往上，负值为往下，可以用于控制UILabel的居顶或者居低显示
-(RJAttributedStringRange*)setObliqueness:(CGFloat)obliqueness NS_AVAILABLE_IOS(7_0);   //设置倾斜度
-(RJAttributedStringRange*)setExpansion:(CGFloat)expansion NS_AVAILABLE_IOS(7_0);  //压缩文字，正值为伸，负值为缩

-(RJAttributedStringRange*)setStrokeColor:(UIColor*)strokeColor;  //中空文字的颜色
-(RJAttributedStringRange*)setStrokeWidth:(CGFloat)strokeWidth;   //中空的线宽度


//可以设置多个属性
-(RJAttributedStringRange*)setAttributes:(NSDictionary*)dict;

//得到构建器
-(RJAttributedStringBuilder*)builder;

@end


/*属性字符串构建器*/
@interface RJAttributedStringBuilder : NSObject

+(RJAttributedStringBuilder*)builderWith:(NSString*)string;


-(id)initWithString:(NSString*)string;

-(RJAttributedStringRange*)range:(NSRange)range;  //指定区域,如果没有属性串或者字符串为nil则返回nil,下面方法一样。
-(RJAttributedStringRange*)allRange;      //全部字符
-(RJAttributedStringRange*)lastRange;     //最后一个字符
-(RJAttributedStringRange*)lastNRange:(NSInteger)length;  //最后N个字符
-(RJAttributedStringRange*)firstRange;    //第一个字符
-(RJAttributedStringRange*)firstNRange:(NSInteger)length;  //前面N个字符
-(RJAttributedStringRange*)characterSet:(NSCharacterSet*)characterSet;             //用于选择特殊的字符
-(RJAttributedStringRange*)includeString:(NSString*)includeString all:(BOOL)all;   //用于选择特殊的字符串
-(RJAttributedStringRange*)regularExpression:(NSString*)regularExpression all:(BOOL)all;   //正则表达式


//段落处理,以\n结尾为一段，如果没有段落则返回nil
-(RJAttributedStringRange*)firstParagraph;
-(RJAttributedStringRange*)nextParagraph;


//插入，如果为0则是头部，如果为-1则是尾部
-(void)insert:(NSInteger)pos attrstring:(NSAttributedString*)attrstring;
-(void)insert:(NSInteger)pos attrBuilder:(RJAttributedStringBuilder*)attrBuilder;

-(NSAttributedString*)commit;


@end

