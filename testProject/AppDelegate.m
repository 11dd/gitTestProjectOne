//
//  AppDelegate.m
//  testProject
//
//  Created by mac3 on 17/2/10.
//  Copyright © 2017年 test. All rights reserved.
//

#import "AppDelegate.h"
#import "KKNavigationController.h"
#import "GuideViewController.h"

@interface AppDelegate ()

@end
//我就是写一个测试怎么样....
@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    self.window.backgroundColor = [UIColor whiteColor];
    
    [self.window makeKeyAndVisible];
    
    [self testNetwork];
    
    //设置推送
    [self getuiPush];
    
    //设置主页
    [self setTabbarTest];
    //引导页
    [self firstLaunched];

    return YES;
}

-(void)testNetwork
{
    // 监测网络环境
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    
    /*
     status
     AFNetworkReachabilityStatusUnknown          = -1, 不知道监测的是什么
     AFNetworkReachabilityStatusNotReachable     = 0,  没有检测到网络
     AFNetworkReachabilityStatusReachableViaWWAN = 1,  蜂窝网
     AFNetworkReachabilityStatusReachableViaWiFi = 2,  WIFI
     */
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {

        if (status == 2) {
            NSLog((@"\n[函数名:%s]\n" "[行号:%d]\n" "%@\n"), __FUNCTION__, __LINE__,@"当前网络是WiFi");
        }else if (status == 1){
            NSLog((@"\n[函数名:%s]\n" "[行号:%d]\n" "%@\n"), __FUNCTION__, __LINE__,@"当前网络是蜂窝数据");
        }else if (status == 0){
            NSLog((@"\n[函数名:%s]\n" "[行号:%d]\n" "%@\n"), __FUNCTION__, __LINE__,@"当前没有网络");
        }
    }];
    
    [manager startMonitoring];
    
}

#pragma - mark - 第一次启动
-(void)firstLaunched
{
    //增加标识，用于判断是否是第一次启动应用...
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"everLaunchedWUSI"]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"everLaunchedWUSI"];
        NSLog(@"第一次启动!");
        GuideViewController *yinDaoView = [[GuideViewController alloc]init];
        [self.tab.navigationController pushViewController:yinDaoView animated:NO];
    }

}


#pragma - mark - Tabbar

-(void)setTabbarTest
{
    self.tab = [[CustomTabbarViewController alloc]init];
    KKNavigationController *nav = [[KKNavigationController alloc]initWithRootViewController:self.tab];
    [self.window setRootViewController:nav];
}

#pragma - mark -
#pragma - mark - 以下是个推push

-(void)getuiPush
{
    [UIApplication sharedApplication].applicationIconBadgeNumber=0;//清除角标
    
    // [ GTSdk ]：是否允许APP后台运行
    //    [GeTuiSdk runBackgroundEnable:YES];
    
    // [ GTSdk ]：是否运行电子围栏Lbs功能和是否SDK主动请求用户定位
    [GeTuiSdk lbsLocationEnable:YES andUserVerify:YES];
    
    // [ GTSdk ]：自定义渠道
    [GeTuiSdk setChannelId:@"GT-Channel"];
    
    // [ GTSdk ]：使用APPID/APPKEY/APPSECRENT创建个推实例
    [GeTuiSdk startSdkWithAppId:kGtAppId appKey:kGtAppKey appSecret:kGtAppSecret delegate:self];
    
    // 注册APNs - custom method - 开发者自定义的方法
    [self registerRemoteNotification];
    
    
}

#pragma mark - 用户通知(推送) _自定义方法

/** 注册远程通知 */
- (void)registerRemoteNotification {
    /*
     警告：Xcode8的需要手动开启“TARGETS -> Capabilities -> Push Notifications”
     */
    /*
     警告：该方法需要开发者自定义，以下代码根据APP支持的iOS系统不同，代码可以对应修改。
     以下为演示代码，注意根据实际需要修改，注意测试支持的iOS系统都能获取到DeviceToken
     */
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0 // Xcode 8编译会调用
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionCarPlay) completionHandler:^(BOOL granted, NSError *_Nullable error) {
            if (!error) {
                NSLog(@"request authorization succeeded!");
            }
        }];
        
        [[UIApplication sharedApplication] registerForRemoteNotifications];
#else // Xcode 7编译会调用
        UIUserNotificationType types = (UIUserNotificationTypeAlert | UIUserNotificationTypeSound | UIUserNotificationTypeBadge);
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
#endif
    } else if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        UIUserNotificationType types = (UIUserNotificationTypeAlert | UIUserNotificationTypeSound | UIUserNotificationTypeBadge);
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    } else {
//        UIRemoteNotificationType apn_type = (UIRemoteNotificationType)(UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeBadge);
//        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:apn_type];
    }
}


#pragma mark - GeTuiSdkDelegate

/** SDK启动成功返回cid */
- (void)GeTuiSdkDidRegisterClient:(NSString *)clientId {
    // [4-EXT-1]: 个推SDK已注册，返回clientId
    NSLog((@"\n[函数名:%s]\n" "[行号:%d]\n" "\n>>[GTSdk RegisterClient]:%@\n\n"), __FUNCTION__, __LINE__,clientId);
    
    Kusersave(clientId, @"CLIENTID");
    
    //    UIAlertView *alt = [[UIAlertView alloc]initWithTitle:@"Clientid" message:clientId delegate:self
    //                                       cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    //    [alt show];
    
}

/** SDK遇到错误回调 */
- (void)GeTuiSdkDidOccurError:(NSError *)error {
    
    // [EXT]:个推错误报告，集成步骤发生的任何错误都在这里通知，如果集成后，无法正常收到消息，查看这里的通知。
    NSLog(@"\n>>[GTSdk error]:%@\n\n", [error localizedDescription]);
}


/** SDK收到透传消息回调 */
- (void)GeTuiSdkDidReceivePayloadData:(NSData *)payloadData andTaskId:(NSString *)taskId andMsgId:(NSString *)msgId andOffLine:(BOOL)offLine fromGtAppId:(NSString *)appId {
    // [ GTSdk ]：汇报个推自定义事件(反馈透传消息)
    [GeTuiSdk sendFeedbackMessage:90001 andTaskId:taskId andMsgId:msgId];
    
    // 数据转换
    NSString *payloadMsg = nil;
    if (payloadData) {
        payloadMsg = [[NSString alloc] initWithBytes:payloadData.bytes length:payloadData.length encoding:NSUTF8StringEncoding];
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:payloadData options:kNilOptions error:nil];
        if (dic) {
            NSLog((@"\n[函数名:%s]\n" "[行号:%d]\n" "%@\n"), __FUNCTION__, __LINE__,dic);
        }
    }
    
    // 控制台打印日志
    NSString *msg = [NSString stringWithFormat:@"taskId=%@,messageId:%@,payloadMsg:%@%@", taskId, msgId, payloadMsg, offLine ? @"<离线消息>" : @""];
    
    NSLog((@"\n[函数名:%s]\n" "[行号:%d]\n" "\n>>控制台打印日志:%@\n\n"), __FUNCTION__, __LINE__,msg);
    
    UIAlertView *alt = [[UIAlertView alloc]initWithTitle:@"您有一条新消息" message:payloadMsg delegate:self
                                       cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alt show];
}

/** SDK收到sendMessage消息回调 */
- (void)GeTuiSdkDidSendMessage:(NSString *)messageId result:(int)result {
    // 发送上行消息结果反馈
    NSString *msg = [NSString stringWithFormat:@"sendmessage=%@,result=%d", messageId, result];
    
    NSLog((@"\n[函数名:%s]\n" "[行号:%d]\n" "\n>>发送上行消息结果反馈:%@\n\n"), __FUNCTION__, __LINE__,msg);
    
}

/** SDK运行状态通知 */
- (void)GeTuiSDkDidNotifySdkState:(SdkStatus)aStatus {
    // 通知SDK运行状态
    NSLog(@"\n>>[GTSdk SdkState]:%u\n\n", aStatus);
}

/** SDK设置推送模式回调 */
- (void)GeTuiSdkDidSetPushMode:(BOOL)isModeOff error:(NSError *)error {
    if (error) {
        NSLog(@"\n>>[GTSdk SetModeOff Error]:%@\n\n", [error localizedDescription]);
        return;
    }
    
    NSLog(@"\n>>[GTSdk SetModeOff]:%@\n\n", isModeOff ? @"开启" : @"关闭");
}


#pragma mark - 远程通知(推送)回调

/** 远程通知注册成功委托 */
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    NSString *token = [[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"\n>>>[DeviceToken Success]:%@\n\n", token);
    
    // [ GTSdk ]：向个推服务器注册deviceToken
    [GeTuiSdk registerDeviceToken:token];
    
    //    UIAlertView *alt = [[UIAlertView alloc]initWithTitle:@"Token" message:token delegate:self
    //                                       cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    //    [alt show];
    
}

/** 远程通知注册失败委托 */
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"\n>>>[DeviceToken Error]:%@\n\n", error.description);
}

#pragma mark - APP运行中接收到通知(推送)处理 - iOS 10以下版本收到推送

/** APP已经接收到“远程”通知(推送) - 透传推送消息  */
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler {
    
    // [ GTSdk ]：将收到的APNs信息传给个推统计
    [GeTuiSdk handleRemoteNotification:userInfo];
    
    [UIApplication sharedApplication].applicationIconBadgeNumber=0;//清除角标
    
    // 控制台打印接收APNs信息
    NSLog((@"\n[函数名:%s]\n" "[行号:%d]\n" "\n>>>控制台打印接收APNs信息:%@\n\n"), __FUNCTION__, __LINE__,userInfo);
    
    completionHandler(UIBackgroundFetchResultNewData);
}

#pragma mark - iOS 10中收到推送消息

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
//  iOS 10: App在前台获取到通知
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler {
    
    NSLog(@"willPresentNotification：%@", notification.request.content.userInfo);
    
    // 根据APP需要，判断是否要提示用户Badge、Sound、Alert
    completionHandler(UNNotificationPresentationOptionBadge | UNNotificationPresentationOptionSound | UNNotificationPresentationOptionAlert);
}

//  iOS 10: 点击通知进入App时触发
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    
    [UIApplication sharedApplication].applicationIconBadgeNumber=0;//清除角标
    
    // [ GTSdk ]：将收到的APNs信息传给个推统计
    [GeTuiSdk handleRemoteNotification:response.notification.request.content.userInfo];
    
    completionHandler();
}
#endif

#pragma - mark - 以上是个推



#pragma - mark - 生命周期

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    NSLog(@"已经进入后台：%s",__func__);
    
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *nowTime = [dateFormatter stringFromDate:currentDate];

    Kusersave(nowTime, @"TIME");
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
    NSLog(@"将要进入前台：%s",__func__);
    
    //时间
    NSString *createdTimeStr = Kuserread(@"TIME");
    
    //把字符串转为NSdate
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *timeDate = [dateFormatter dateFromString:createdTimeStr];
    
    //得到与当前时间差
    NSTimeInterval timeInterval = [timeDate timeIntervalSinceNow];
    timeInterval = -timeInterval;
    
    long temp = 0;
    
    NSString *result;
    
    if ((temp = timeInterval/3600) > 24){
        result = [NSString stringWithFormat:@"大于一天"];
        
    }else{
      

    }
    
}


- (void)applicationWillTerminate:(UIApplication *)application {
    
    NSLog(@"程序将要退出：%s",__func__);
}



- (void)applicationDidBecomeActive:(UIApplication *)application {
    
    NSLog(@"已经获得焦点：%s",__func__);
}



- (void)applicationWillResignActive:(UIApplication *)application {
    
    NSLog(@"将要释放焦点：%s",__func__);
}


@end
