//
//  CustomTabbarViewController.m
//  Com.wusi.ruijin
//
//  Created by 滕 on 14-11-4.
//  Copyright (c) 2014年 admin. All rights reserved.
//

#import "CustomTabbarViewController.h"
#import "MainViewController.h"
#import "DDSecondViewController.h"
#import "DDThirdViewController.h"
#import "FourthViewController.h"
#import "MineViewController.h"

#import "TableTestViewController.h"


@interface CustomTabbarViewController ()<UITabBarControllerDelegate>


@end

@implementation CustomTabbarViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabBar.hidden = NO;
    
    [self systabbar];
    
}


-(void)systabbar
{
    
    MainViewController *mainVC = [[MainViewController alloc]init];
    DDSecondViewController *secondVC = [[DDSecondViewController alloc]init];
    DDThirdViewController *ThirdVC = [[DDThirdViewController alloc]init];
    FourthViewController *FourthVC = [[FourthViewController alloc]init];
    MineViewController *mineVC = [[MineViewController alloc]init];
    [self addChild:mainVC image:@"Image-1" imageSele:@"Image-2" title:@"首页"];
    [self addChild:secondVC image:@"Image-3" imageSele:@"Image-4" title:@"第二"];
    [self addChild:ThirdVC image:@"Image-5" imageSele:@"Image-6" title:@"第三"];
    [self addChild:FourthVC image:@"Image-7" imageSele:@"Image-8" title:@"第四"];
    [self addChild:mineVC image:@"Image-9" imageSele:@"Image" title:@"我的"];
    self.selectedIndex=0;
    
}


- (void)addChild:(UIViewController *)childVC
           image:(NSString *)image
       imageSele:(NSString *)imageSele
           title:(NSString *)title{
    
    
    [self addChildViewController:childVC];
    UITabBarItem *item0=childVC.tabBarItem;
    // 取消tabbar文字渲染效果,属性字符串
    NSMutableDictionary *dicTemp = [NSMutableDictionary dictionary];
    dicTemp[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    NSMutableDictionary *dicTempTwo = [NSMutableDictionary dictionary];
    dicTempTwo[NSForegroundColorAttributeName] = [UIColor colorWithRed:55/255.0 green:205/255.0 blue:173/255.0 alpha:1.0];
    [item0
     setTitleTextAttributes:dicTemp forState:UIControlStateNormal];
    [item0 setTitleTextAttributes:dicTempTwo forState:
     UIControlStateSelected];
    item0.title=title;
    
    item0.selectedImage = [[UIImage imageNamed:imageSele] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];;
    item0.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
}


/*
 //    //使图片和文字水平居中显示
 //    _btn1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
 //
 //    //图片距离右边框距离减少文字的宽度，其它不边
 //    [_btn1 setImageEdgeInsets:UIEdgeInsetsMake(0.0, 0.0,0.0, -_btn1.titleLabel.bounds.size.width)];
 //
 //    //文字距离上边框的距离增加imageView的高度，距离左边框减少imageView的宽度，距离下边框和右边框距离不变
 //    [_btn1 setTitleEdgeInsets:UIEdgeInsetsMake(_btn1.imageView.frame.size.height ,-_btn1.imageView.frame.size.width, 0.0,0.0)];
 */

#pragma - mark - 以下测试热点监听

#pragma - mark - viewWillAppear

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [[ NSNotificationCenter defaultCenter ] addObserver : self selector : @selector (statusBarFrameWillChange:) name : UIApplicationWillChangeStatusBarFrameNotification object : nil ];
    
    [[ NSNotificationCenter defaultCenter ] addObserver : self selector : @selector (layoutControllerSubViews:) name : UIApplicationDidChangeStatusBarFrameNotification object : nil ];
    
    CGRect statusBarRect = [[UIApplication sharedApplication] statusBarFrame];
    
    if (statusBarRect.size.height == 40){
        
        self.tabBar.frame = CGRectMake(0, KScreenHeight- TABBAR_HEIGHT -20, KScreenWidth, TABBAR_HEIGHT);
        
    }else{
        
        self.tabBar.frame = CGRectMake(0, KScreenHeight- TABBAR_HEIGHT, KScreenWidth,TABBAR_HEIGHT);

    }

    
}

#pragma mark-状态栏录音或通话状态通知以及开启热点

-(void)layoutControllerSubViews:(NSNotification *)notification{
    
    CGRect statusBarRect = [[UIApplication sharedApplication] statusBarFrame];
    
    if (statusBarRect.size.height == 40){
        
        self.tabBar.frame = CGRectMake(0, KScreenHeight- TABBAR_HEIGHT -20, KScreenWidth, TABBAR_HEIGHT);
        
    }else{
        
        self.tabBar.frame = CGRectMake(0, KScreenHeight- TABBAR_HEIGHT, KScreenWidth,TABBAR_HEIGHT);
        
    }
}


- (void)statusBarFrameWillChange:(NSNotification*)notification{
    
    CGRect statusBarRect = [[UIApplication sharedApplication] statusBarFrame];
    
    
    if (statusBarRect.size.height == 40){
        
        self.tabBar.frame = CGRectMake(0, KScreenHeight- TABBAR_HEIGHT -20, KScreenWidth, TABBAR_HEIGHT);
        
    }else{
        
        self.tabBar.frame = CGRectMake(0, KScreenHeight- TABBAR_HEIGHT, KScreenWidth,TABBAR_HEIGHT);
        
    }
}

#pragma - mark - 以上测试热点监听

@end
