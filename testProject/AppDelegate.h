//
//  AppDelegate.h
//  testProject
//
//  Created by mac3 on 17/2/10.
//  Copyright © 2017年 test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTabbarViewController.h"

//#import "GeTuiSdk.h"
////个推
//#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
//#import <UserNotifications/UserNotifications.h>
//#endif
//
//#ifdef DEBUG
////个人
//#define kGtAppId           @"FhhyRVgPfG8C3e21Do0t14"
//#define kGtAppKey          @"b6ljZp8QIMA9s4aaM1aOM2"
//#define kGtAppSecret       @"pJD9X7jOKX8au8weiriVk8"
//
//#else
////公司
//#define kGtAppId           @"23P2Wn4WUJ8P07MzinDhN1"
//#define kGtAppKey          @"O3GOg9gL8l7xgHZlKbf47A"
//#define kGtAppSecret       @"80SuZ7k7Nb676yTSM7r7m2"
//
//#endif

@interface AppDelegate : UIResponder <UIApplicationDelegate>//GeTuiSdkDelegate,UNUserNotificationCenterDelegate

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic,strong) CustomTabbarViewController *tab;


@end

