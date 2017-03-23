//
//  RJUtils.h
//  RJFrameworkV2
//
//  Created by shenchengcai on 16/5/31.
//  Copyright © 2016年 dlrj. All rights reserved.
//

/*******************************************************
 类名：RJUtils
 功能描述：常用的静态方法放到此处
 
 */

//常用变量
#define KScreenIpad [[UIScreen mainScreen] bounds].size.width == 768
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface RJUtils : NSObject

/*获取当前的数据网络连接类型（
    0:RealStatusNotReachable
    1:RealStatusViaWiFi
    2:WWANType4G
    3:WWANType3G
    4:WWANType2G
）*/
+ (NSInteger)reachableType;
//监听网络状态改变
//+ (BOOL)startReachableNotifier:(id)container;
//网络连接状态的两种判断
+ (BOOL)initReachable;
+ (BOOL)reachable;
+ (BOOL)ahReachableForAddress:(NSString *)address;

//监测网络状态
+ (void)startMonitoringNetworkReachabilityWithHost:(NSString *)defaultHost;

//选择图片
+ (void)pickPhotoContainer:(UIViewController *)container allowsEditing:(BOOL)allowsEditing finish:(void (^)(UIImage *image))block;

//一句代码就能轻松解决键盘遮挡住输入框的问题
+ (void)setRJKeyboardManagerEnable:(BOOL)enable;
/*!
	@property enable
 
	@abstract enable/disable the keyboard manager. Default is NO.
 */
+ (BOOL)isRJKeyboardManagerEnabled;

//显示引导页
+ (void)showIntroductionWithView:(UIView *)aView images:(NSArray *)images didshow:(void (^)())block1 didhidden:(void (^)())block2;

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

//解析接口返回数据。data接口返回数据。该方法返回字典类型对象
+ (NSDictionary *)getDictionaryWithUTF8Data:(NSData *)data;

//解析接口返回数据。str接口返回数据。该方法返回字典类型对象
+ (NSDictionary *) dictionaryFromJson:(NSString *)str;

//解压zip压缩包。zipPath压缩包路径；_unzipto解压文件存放路径
//+ (BOOL)OpenZip:(NSString*)zipPath unzipto:(NSString*)_unzipto;


+ (NSString *)getApplicationName;
+ (NSString *)getApplicationScheme;

//系统版本
+ (CGFloat)systemVersion;
//设备高度
+ (NSInteger)deviceHeight;

@end
