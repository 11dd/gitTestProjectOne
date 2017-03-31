//
//  Helper.h
//  testProject
//
//  Created by mac3 on 17/2/13.
//  Copyright © 2017年 test. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "IQKeyboardManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface Helper : NSObject

+(CGFloat)returnHeight;

//显示loading
+(void)showLoadingWithView:(UIView *)aView;

//影藏loading
+(void)hiddonLoadingWithView:(UIView *)aView;

//显示提示框
+ (void)showMessageWithHud:(NSString*)message
                     addTo:(UIViewController*)controller
                   yOffset:(CGFloat)yoffset;


/*
 @property enable
 @abstract enable/disable the keyboard manager. Default is NO.
 */
+ (BOOL)isKeyboardManagerEnabled;

//解决键盘遮挡住输入框的问题
+ (void)setKeyboardManagerEnable:(BOOL)enable;

//属性字符串
+ (NSMutableAttributedString *)stringToAttributedString:(NSString*)tempStr NSMakeRange:(int)num;

//获取当前时间
+ (NSString *)stringToNowDateTime:(NSString*)Str;

//与当前时间比较时间大小
+ (NSString *)timeCompareNowTime:(NSString *)time;

//计算时间差,刚刚,几分钟,几小时,昨天,前天
+(NSString *)CreatedTimeToNowTime:(NSString *)CreatTime;


//示例,字符串操作
+ (NSString *)stringToString:(NSString*)tempStr;

//示例,数组操作
+ (NSMutableArray *)arrayToArray:(NSMutableArray*)tempArr;


/*******************************************/

//是否已登录
+ (BOOL)isUserLogined;

//存储用户ID
+ (void)saveUserId:(NSString*)userId;

//获取用户ID
+ (NSString*)fetchUserId;

//存储用户姓名
+ (void)saveUserName:(NSString*)userName;

//获取用户姓名
+ (NSString*)fetchUserName;

//存储用户 选择发生地编码
+ (void)saveChoiceAddNumeber:(NSString*)addNumberstr;

//获取用户 选择发生地编码
+ (NSString*)fetchChoiceAddNumber;

//存储用户密码
+ (void)saveUserpwd:(NSString*)userpwd;

//获取用户密码
+ (NSString*)fetchUserpwd;

//存储用户Token
+ (void)saveUserToken:(NSString*)userToken;

//获取用户Token
+ (NSString*)fetchUserToken;

//存储用户验证码比对是否成功 yes 成功 no 不成功
+ (void)saveUserSecurity:(BOOL)security;

//获取用户验证码比对结果
+ (BOOL)fetchUserSecurity;

//存储用户Status
+ (void)saveUserPushMode:(NSString *)status;

//获取用户Status
+ (NSString*)fetchUserPushMode;


/**< 返回错误提示信息 */
+ (void)showReturnAlert:(NSString *)alert;

///**< 设置显示容器方法 */
//+ (void)saveRootController:(UINavigationController *)controller;
//
//+ (UINavigationController *)fetchRootController;
/**< 设置显示容器方法 */

+ (void)saveRootController:(UITabBarController *)controller;

+ (UITabBarController     *)fetchRootController;

//上传图片文件
+(void)postRequestWithURL: (NSString *)url picFileName: (NSString *)picFileName dataimage:(UIImage *)image andBlock:(void(^)(NSDictionary *retDic,NSError *error))block;

//判空
+ (BOOL) isBlankString:(NSString *)string;

//邮箱格式验证
+(BOOL)verifyemail:(NSString * )str;

//身份证格式验证
+(BOOL)verifyIDCardNumber:(NSString *)value;


@end
NS_ASSUME_NONNULL_END


NS_ASSUME_NONNULL_BEGIN

@interface UIButton (custom)

-(void)settitlebuttomandImagetop;

- (void)setTextSize:(CGFloat)size;

- (void)setTextColor:(UIColor*)color;

- (void)setText:(NSString * )text;

- (void)setImgv:(NSString *)imgvstr;

- (void)addClick:(_Nullable id)target selector:(_Nonnull SEL)selector;

@end
NS_ASSUME_NONNULL_END
