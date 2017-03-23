//
//  BaseViewController.m
//  testProject
//
//  Created by mac3 on 17/2/13.
//  Copyright © 2017年 test. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setHidden:YES];

    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.backgroundColor = rgba(233, 233, 233, 1);

    self.navigationController.navigationBar.hidden = YES;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
}

-(void)drawNavWithTitle:(NSString *)Title{
    
    UILabel *labNav = [[UILabel alloc]initWithFrame:CGRectMake(0, 0,KScreenWidth , 64)];
    labNav.backgroundColor = [UIColor colorWithRed:0/255 green:155.0/255 blue:250.0/255 alpha:1];
    [self.view addSubview:labNav];
    
    UILabel* lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0,200,30)];
    lab.center = CGPointMake(KScreenWidth/2 , 44) ;
    lab.textAlignment = NSTextAlignmentCenter;
    lab.textColor = [UIColor whiteColor];
    lab.font = [UIFont boldSystemFontOfSize:20.0];
    lab.text = Title;
    lab.backgroundColor = [UIColor clearColor];
    [self.view addSubview:lab];
    
}

-(void)drawBackButton{
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, KScreenWidth / 320  * 60, 44)];
    [btn setImage:[UIImage imageNamed:@"Back"] forState:UIControlStateNormal];
    [btn setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
    [btn addTarget:self action:@selector(clickBack) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:btn];
}

//渐变色
-(void)GradualChangeColors
{
    CAGradientLayer *gradientLayer = [[CAGradientLayer alloc] init];
    gradientLayer.colors = @[(__bridge id)rgba(132, 225, 252, 1).CGColor,
                             (__bridge id)rgba(95, 150, 105, 1).CGColor];
    //位置x,y 自己根据需求进行设置  使其从不同位置进行渐变
    gradientLayer.startPoint = CGPointMake(1, 0);
    gradientLayer.endPoint = CGPointMake(1, 1);
    gradientLayer.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
    [self.view.layer addSublayer:gradientLayer];
}

-(void)clickBack
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
