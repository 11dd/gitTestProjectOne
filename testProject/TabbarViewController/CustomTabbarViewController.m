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

#import "WeiBoHomeViewController.h"

#define kblueColor    [UIColor colorWithRed:0/255.0 green:160/255.0 blue:233/255.0 alpha:1.0]

@interface CustomTabbarViewController ()<UITabBarControllerDelegate>
{
    NSMutableArray * arrbtu;
    NSArray *arr;
    NSArray *arr1;
    NSArray *arr2;
    NSInteger selectcount;
}

@property(nonatomic,assign)NSInteger currentSelectedIndex;

@end

@implementation CustomTabbarViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabBar.hidden = NO;
    
    arrbtu=[[NSMutableArray alloc]init];
    selectcount=0;

    [self customtabbar];
    
    self.delegate=self;
    
}

- (void)changeTabBtnSelected:(int)index
{
    UIButton * btu=[self.view viewWithTag:index];
    [self Pressbtu:btu];
}


-(void)customtabbar
{
    
    MainViewController *mainVC = [[MainViewController alloc]init];
    DDSecondViewController *secondVC = [[DDSecondViewController alloc]init];
    //WeiBoHomeViewController *secondVC = [[WeiBoHomeViewController alloc]init];
    DDThirdViewController *ThirdVC = [[DDThirdViewController alloc]init];
    FourthViewController *FourthVC = [[FourthViewController alloc]init];
    MineViewController *mineVC = [[MineViewController alloc]init];
    
    NSArray * arr3=@[mainVC,secondVC,ThirdVC,FourthVC,mineVC];

    arr=@[@"tab11",@"tab21",@"tab51",@"tab31",@"tab41"];
    arr1=@[@"tab12",@"tab22",@"tab52",@"tab32",@"tab42"];
    arr2=@[@"主页",@"第二页",@"第三页",@"第四页",@"我的"];
    
    
    for (int i=0; i<5; i++) {
        UIButton * btu=[[UIButton alloc]init];
        btu.frame=CGRectMake(KScreenWidth/5*i,KScreenHeight-49 , KScreenWidth/5, 49);
        
        // btu.frame=CGRectMake([UIScreen mainScreen].bounds.size.width/6*i,0, [UIScreen mainScreen].bounds.size.width/6, 49);
        [btu setImage:[UIImage imageNamed:arr[i]] forState:UIControlStateNormal];
        if (i!=2) {
            [btu setTitle:arr2[i] forState:UIControlStateNormal];
            btu.titleLabel.font=kFont(10);
            [btu settitlebuttomandImagetop];
        }
        btu.tag=1000+i;
        [btu setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [btu setImage:[UIImage imageNamed:arr1[i]] forState:UIControlStateHighlighted];
        [btu setImage:[UIImage imageNamed:arr1[i]] forState:UIControlStateSelected];
        
        // [btu setImageEdgeInsets:UIEdgeInsetsMake(-13,10, 0, 0)];
        // [btu setTitleEdgeInsets:UIEdgeInsetsMake(25, -28, 0, 5)];
        [btu addTarget:self action:@selector(Pressbtu:) forControlEvents:UIControlEventTouchUpInside];
        if (i==0)
        {
            btu.selected=YES;
            selectcount=1000;
            [btu setTitleColor:kblueColor forState:UIControlStateNormal];
        }
        [self.view addSubview :btu];
        [arrbtu addObject:btu];
        
        //KKNavigationController *nav = [[KKNavigationController alloc]initWithRootViewController:arr3[i]];
        
        [self addChildViewController:arr3[i]];
        
    }

}

-(void)Pressbtu:(UIButton *) btu
{
    if (btu.tag==selectcount) {
        return;
    }
    
    self.selectedIndex = btu.tag-1000; //切换不同控制器的界面
    btu.selected=YES;
    selectcount=btu.tag;
    [btu setTitleColor:kblueColor forState:UIControlStateNormal];
    for (UIButton * btuother in arrbtu)
    {
        if (btuother.tag!=btu.tag)
        {
            [btuother setImage:[UIImage imageNamed:arr[btuother.tag-1000]] forState:UIControlStateNormal];
            [btuother setImage:[UIImage imageNamed:arr[btuother.tag-1000]] forState:UIControlStateSelected];
            [btuother setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        }else
        {
            [btu setImage:[UIImage imageNamed:arr1[btuother.tag-1000]] forState:UIControlStateSelected];
            [btu setImage:[UIImage imageNamed:arr[btuother.tag-1000]] forState:UIControlStateNormal];
        }
    }
    
}


- (void)isHiddenTab
{
    self.tabBar.hidden = YES;
    UIButton * btu1=[self.view viewWithTag:1000];
    UIButton * btu2=[self.view viewWithTag:1001];
    UIButton * btu3=[self.view viewWithTag:1002];
    UIButton * btu4=[self.view viewWithTag:1003];
    UIButton * btu5=[self.view viewWithTag:1004];
    btu1.hidden = YES;
    btu2.hidden = YES;
    btu3.hidden = YES;
    btu4.hidden = YES;
    btu5.hidden = YES;
}

- (void)isShowTab
{
    self.tabBar.hidden = NO;
    
    UIButton * btu1=[self.view viewWithTag:1000];
    UIButton * btu2=[self.view viewWithTag:1001];
    UIButton * btu3=[self.view viewWithTag:1002];
    UIButton * btu4=[self.view viewWithTag:1003];
    UIButton * btu5=[self.view viewWithTag:1004];
    
    btu1.hidden = NO;
    btu2.hidden = NO;
    btu3.hidden = NO;
    btu4.hidden = NO;
    btu5.hidden = NO;
    
}

#pragma mark -系统tabbar

-(void)systabbar
{
    
    MainViewController *mainVC = [[MainViewController alloc]init];
    DDSecondViewController *secondVC = [[DDSecondViewController alloc]init];
    DDThirdViewController *ThirdVC = [[DDThirdViewController alloc]init];
    FourthViewController *FourthVC = [[FourthViewController alloc]init];
    MineViewController *mineVC = [[MineViewController alloc]init];
    [self addChild:mainVC image:@"tab11" imageSele:@"tab12" title:@"首页"];
    [self addChild:secondVC image:@"tab21" imageSele:@"tab22" title:@"电网状态"];
    [self addChild:ThirdVC image:@"tab55" imageSele:@"tab55" title:@""];
    [self addChild:FourthVC image:@"tab31" imageSele:@"tab32" title:@"故障报警"];
    [self addChild:mineVC image:@"tab41" imageSele:@"tab42" title:@"我的"];
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
        
        self.tabBar.frame = CGRectMake(0, KScreenHeight- KTABBAR_HEIGHT -20, KScreenWidth, KTABBAR_HEIGHT);
        
    }else{
        
        self.tabBar.frame = CGRectMake(0, KScreenHeight- KTABBAR_HEIGHT, KScreenWidth,KTABBAR_HEIGHT);

    }

    
}

#pragma mark-状态栏录音或通话状态通知以及开启热点

-(void)layoutControllerSubViews:(NSNotification *)notification{
    
    CGRect statusBarRect = [[UIApplication sharedApplication] statusBarFrame];
    
    if (statusBarRect.size.height == 40){
        
        self.tabBar.frame = CGRectMake(0, KScreenHeight- KTABBAR_HEIGHT -20, KScreenWidth, KTABBAR_HEIGHT);
        
    }else{
        
        self.tabBar.frame = CGRectMake(0, KScreenHeight- KTABBAR_HEIGHT, KScreenWidth,KTABBAR_HEIGHT);
        
    }
}


- (void)statusBarFrameWillChange:(NSNotification*)notification{
    
    CGRect statusBarRect = [[UIApplication sharedApplication] statusBarFrame];
    
    
    if (statusBarRect.size.height == 40){
        
        self.tabBar.frame = CGRectMake(0, KScreenHeight- KTABBAR_HEIGHT -20, KScreenWidth, KTABBAR_HEIGHT);
        
    }else{
        
        self.tabBar.frame = CGRectMake(0, KScreenHeight- KTABBAR_HEIGHT, KScreenWidth,KTABBAR_HEIGHT);
        
    }
}

#pragma - mark - 以上测试热点监听

@end
