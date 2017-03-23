//
//  Mybutton.h
//  RJFrameworkV2
//
//  Created by dlrj on 16/8/4.
//  Copyright © 2016年 dlrj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Mybutton : UIButton
{
    void (^btnBlock)(Mybutton *);
}
/**
 *  纯图片按钮
 *
 *
 *  @return 返回实例对象
 */
-(instancetype)initWithFrame:(CGRect)frame
                       Image:(NSString *)image
               andClickBlock:(void (^)(Mybutton * btu))block;
/**
 *  纯背景图片按钮
 *
 *
 *  @return 返回实例对象
 */
-(instancetype)initWithFrame:(CGRect)frame
                   backImage:(NSString *)backimage
               andClickBlock:(void (^)(Mybutton * btu))block;
/**
  *  没有边框的按钮
  *
  *  @return 返回实例对象
  */
-(instancetype)initWithFrame:(CGRect)frame
             backgroundColor:(UIColor *)backcolor
                   textColor:(UIColor *)textColor
                       title:(NSString *)title
               andClickBlock:(void (^)(Mybutton * btu))block;
/**
 *  有边框，有圆角的按钮
 *
 *  @return 返回实例对象
 */
-(instancetype)initWithFrame:(CGRect)frame
             backgroundColor:(UIColor  *)backcolor
                   textColor:(UIColor  *)textColor
                       title:(NSString *)title
                 borderWidth:(NSString *)bderWidth
                 borderColor:(UIColor  *) bdColor
                cornerRadius:(NSString *)cnradius
               andClickBlock:(void (^)(Mybutton * btu))block;
/**
 *  有图片有标题的有边框 有圆角的 按钮
 *
 *  @return 返回实例对象
 */
-(instancetype)initWithFrame:(CGRect)frame
                  titleframe:(UIEdgeInsets)titleframe
                  imageframe:(UIEdgeInsets)iamgeframe
             backgroundColor:(UIColor  *)backcolor
                   textColor:(UIColor  *)textColor
                       title:(NSString *)title
                       Image:(NSString *)image
                 borderWidth:(NSString *)bderWidth
                 borderColor:(UIColor  *) bdColor
                cornerRadius:(NSString *)cnradius
               andClickBlock:(void (^)(Mybutton * btu))block;
@end
