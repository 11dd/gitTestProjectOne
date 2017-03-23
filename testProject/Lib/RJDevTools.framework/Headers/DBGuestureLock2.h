//
//  DBGuestureLock.h
//  DBGuestureLock
//
//  Created by DeBao.Wu on 2/27/16.
//  Email: i36.lib@gmail.com    QQ: 754753371
//  Copyright © 2016 http://i36.Me/. All rights reserved.
//  Github地址: https://github.com/i36lib/DBGuestureLock/

#import <UIKit/UIKit.h>
#define DBFirstTimeSetupPassword @"Me_i36_DBGuestureLock_DBFirstSetupPswd"
#define DBSecondTimeSetupPassword @"Me_i36_DBGuestureLock_DBSecondSetupPswd"
#define DBLockPasswordShow @"Me_i36_DBGuestureLock_DBPswdShow"
//#define DBWhiteColor             [UIColor orangeColor]
//#define DBOrangeColor            [UIColor whiteColor]
//#define DBLightTextColor         [UIColor colorWithWhite:1.0 alpha:0.5]
#pragma mark _change20160524_scc_2 改变选中的边框颜色为透明(红色)，为选中为透明(浅灰色)，设置画线颜色为红色
#define kLineColor               [UIColor colorWithRed:208/255.0 green:3/255.0 blue:5/255.0 alpha:1.0]
#define DBStrok0Color            [UIColor clearColor]//colorWithRed:228/255.0 green:2/255.0 blue:3/255.0 alpha:1.0]
#define DBStrokeColor            [UIColor clearColor]//colorWithRed:143/255.0 green:137/255.0 blue:134/255.0 alpha:1.0]
#define DBWhiteColor             [UIColor orangeColor]
#define DBOrangeColor            [UIColor whiteColor]
#pragma mark _change20160524_scc_1 改变选中的填充颜色为透明
#define DBLightTextColor         [UIColor clearColor]
#pragma mark _change20160524_scc_3 改变选中的填充颜色与手势密码页背景颜色一致，修改忘记密码按钮颜色
#define DBCenterPointColor       [UIColor colorWithRed:161/255.0 green:16/255.0 blue:12/255.0 alpha:1.0]
#define DBCenterPointWidth       24.f
#define DBForgetPwdColor         [UIColor colorWithRed:233/255.0 green:87/255.0 blue:20/255.0 alpha:1.0]
#pragma mark _change20160524_scc_4 改变底部按钮的marginBottom
#define DBButtonsMarginBottom    17.f

@class DBGuestureLock2;

// Button state
typedef NS_ENUM(NSInteger, DBButtonState) {
    DBButtonStateNormal = 0,
    DBButtonStateSelected,
    DBButtonStateIncorrect,
};

// Delegate
@protocol DBGuestureLockDelegate <NSObject>

@required
-(void)guestureLock:(DBGuestureLock2 *)lock didSetPassword:(NSString*)password;
-(void)guestureLock:(DBGuestureLock2 *)lock didGetCorrectPswd:(NSString*)password;
-(void)guestureLock:(DBGuestureLock2 *)lock didGetIncorrectPswd:(NSString*)password;

@optional
-(BOOL)showButtonCircleCenterPointOnState:(DBButtonState)buttonState;
-(BOOL)fillButtonCircleCenterPointOnState:(DBButtonState)buttonState;
-(CGFloat)widthOfButtonCircleStrokeOnState:(DBButtonState)buttonState;
-(CGFloat)radiusOfButtonCircleCenterPointOnState:(DBButtonState)buttonState;
-(CGFloat)lineWidthOfGuestureOnState:(DBButtonState)buttonState;
-(UIColor *)colorOfButtonCircleStrokeOnState:(DBButtonState)buttonState;
-(UIColor *)colorForFillingButtonCircleOnState:(DBButtonState)buttonState;
-(UIColor *)colorOfButtonCircleCenterPointOnState:(DBButtonState)buttonState;
-(UIColor *)lineColorOfGuestureOnState:(DBButtonState)buttonState;

@end

// Class
@interface DBGuestureLock2 : UIView

@property (nonatomic, readonly, assign)BOOL fillCenterPoint;
@property (nonatomic, readonly, assign)BOOL showCenterPoint;
@property (nonatomic, readonly, assign)CGFloat lineWidth;
@property (nonatomic, readonly, assign)CGFloat circleRadius;
@property (nonatomic, readonly, assign)CGFloat strokeWidth;
@property (nonatomic, readonly, assign)CGFloat centerPointRadius;
@property (nonatomic, readonly, strong)UIColor *lineColor;
@property (nonatomic, readonly, strong)UIColor *fillColor;
@property (nonatomic, readonly, strong)UIColor *strokeColor;
@property (nonatomic, readonly, strong)UIColor *centerPointColor;

@property (nonatomic, readonly, assign)BOOL isPasswordSetup;
@property (nonatomic, copy)NSString *firstTimeSetupPassword;
@property (nonatomic, assign)id<DBGuestureLockDelegate> delegate;
@property (nonatomic, copy) void(^onPasswordSet)(DBGuestureLock2 *lock, NSString *password);
@property (nonatomic, copy) void(^onGetCorrectPswd)(DBGuestureLock2 *lock, NSString *password);
@property (nonatomic, copy) void(^onGetIncorrectPswd)(DBGuestureLock2 *lock, NSString *password);

// Password
+(BOOL)passwordActiveStatus;
+(BOOL)passwordSetupStatus;
+(BOOL)passwordManageStatus;
+(void)setPasswordManageStatus:(int)status;
+(BOOL)passwordShowStatus;
+(void)setPasswordShowStatus:(BOOL)status;
+(void)clearFirstGuestureLockPassword;
+(void)clearGuestureLockPassword;
+(NSString *)getGuestureLockPassword;
-(void)setPropertiesByState:(DBButtonState)buttonState;

//Working with protocal
+(instancetype)lockOnView:(UIView*)view delegate:(id<DBGuestureLockDelegate>)delegate;
+(instancetype)lockOnView:(UIView*)view offsetFromBottom:(CGFloat)offset delegate:(id<DBGuestureLockDelegate>)delegate;

//Working with block
+(instancetype)lockOnView:(UIView*)view marginBottom:(CGFloat)marginBottom onPasswordSet:(void (^)(DBGuestureLock2 *lock, NSString *password))onPasswordSet onGetCorrectPswd:(void (^)(DBGuestureLock2 *lock, NSString *password))GetCorrectPswd onGetIncorrectPswd:(void (^)(DBGuestureLock2 *lock, NSString *password))GetIncorrectPswd;
+(instancetype)lockOnView:(UIView*)view offsetFromBottom:(CGFloat)offset onPasswordSet:(void (^)(DBGuestureLock2 *lock, NSString *password))onPasswordSet onGetCorrectPswd:(void (^)(DBGuestureLock2 *lock, NSString *password))GetCorrectPswd onGetIncorrectPswd:(void (^)(DBGuestureLock2 *lock, NSString *password))GetIncorrectPswd;

//Setup lock theme
-(void)setupLockThemeWithLineColor:(UIColor*)lineColor lineWidth:(CGFloat)lineWidth  strokeColor:(UIColor*)strokeColor strokeWidth:(CGFloat)strokeWidth circleRadius:(CGFloat)circleRadius fillColor:(UIColor*)fillColor showCenterPoint:(BOOL)showCenterPoint centerPointColor:(UIColor*)centerPointColor centerPointRadius:(CGFloat)centerPointRadius fillCenterPoint:(BOOL)fillCenterPoint onState:(DBButtonState)buttonState;

@end
