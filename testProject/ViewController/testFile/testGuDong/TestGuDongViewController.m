//
//  TestGuDongViewController.m
//  testProject
//
//  Created by mac3 on 17/3/24.
//  Copyright © 2017年 test. All rights reserved.
//

#import "TestGuDongViewController.h"
#import "TestScrollView.h"

@interface TestGuDongViewController ()

@property(nonatomic,strong)TestScrollView *DDView;

@property(nonatomic,strong)UIView *bgView;

@end

@implementation TestGuDongViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self drawNavWithTitle:@"测试仿照咕咚效果"];
    [self drawBackButton];
    
    _DDView = [[TestScrollView alloc] initWithFrame:CGRectMake(0, 64, KScreenWidth, KScreenHeight-64)];
    [self.view addSubview:_DDView];
    
    UIView *bgView = [[UIView alloc]init];
    bgView.frame = CGRectMake(-KScreenWidth/2, KScreenHeight - KScreenWidth+100, KScreenWidth*2, KScreenWidth*2);
    bgView.backgroundColor = [UIColor lightGrayColor];
    bgView.layer.cornerRadius = KScreenWidth;
    self.bgView = bgView;
    [self.view addSubview:bgView];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    
    [self.bgView removeFromSuperview];
    
}

@end
