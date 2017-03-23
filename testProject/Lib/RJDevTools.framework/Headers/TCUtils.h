//
//  TCUtils.h
//  E-Book
//

/*******************************************************
 类名：TCUtils
 功能描述：常用的静态方法放到此处
 
 */

//常用变量
#define KScreenIpad [[UIScreen mainScreen] bounds].size.width == 768
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
@class AppDelegate;

@interface TCUtils : NSObject

//获取缓存
+ (id)cacheForKey:(NSString *)anAttribute;

//获取AppDelegate
+ (AppDelegate *)App;

//显示提示框
+ (void)showMessageWithHud:(NSString*)message
                     addTo:(UIViewController*)controller
                   yOffset:(CGFloat)yoffset;

//显示加载视图－自定义
+(void)showLoadingWithView:(UIView *)aView;

//显示加载视图
+(void)showLoadingWithView:(UIView *)aView text:(NSString *)text customMode:(BOOL)custom;

//移除加载视图
+(void)hiddonLoadingWithView:(UIView *)aView;

//封装弹出框的方法
+ (void)showAlertViewWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate cancel:(NSString *) cancelBtn other: (NSString *) otherBtn tag: (int) tag;

//解析接口返回数据。data接口返回数据。该方法返回字典类型对象
+ (NSDictionary *)getDictionaryWithUTF8Data:(NSData *)data;

//解析接口返回数据。str接口返回数据。该方法返回字典类型对象
+ (NSDictionary *) dictionaryFromJson:(NSString *)str;

@end
