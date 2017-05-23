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

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    self.window.backgroundColor = [UIColor whiteColor];
    
    [self.window makeKeyAndVisible];
    
    [self testNetwork];
    
    //设置推送
    
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
            
        }else if (status == 1){
            
        }else if (status == 0){
            
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
