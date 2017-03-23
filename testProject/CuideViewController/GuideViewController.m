//
//  GuideViewController.m
//  testProject
//
//  Created by mac3 on 17/2/13.
//  Copyright © 2017年 test. All rights reserved.
//

#import "GuideViewController.h"
#import "MainViewController.h"

@interface GuideViewController ()

@end

@implementation GuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self drawView];
}

-(void)drawView{
    
    NSArray *imageAry_480 = @[@"2-480",@"1-480",@"3-480",@"4-480"];
    NSArray *imageAry_568 = @[@"2-568",@"1-568",@"3-568",@"4-568"];
    NSArray *title1Ary = @[@"第一页",@"第二页",@"第三页",@"第四页"];
    NSArray *title2Ary = @[@"",@"",@"",@""];
    
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, -20, KScreenWidth, KScreenHeight + 20)];
    _scrollView.bounces = NO;
    [_scrollView setPagingEnabled:YES];
    
    for (int i = 0 ; i < imageAry_480.count; i++) {
        
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(KScreenWidth * i, 0, KScreenWidth, KScreenHeight)];
        imageView.backgroundColor = [UIColor redColor];
        UILabel *title1 = [[UILabel alloc]initWithFrame:CGRectMake(0, kh(80), KScreenWidth, kh(40))];
        title1.text = [title1Ary objectAtIndex:i];
        [title1 setTextAlignment:NSTextAlignmentCenter];
        title1.textColor = [UIColor whiteColor];
        title1.font = [UIFont systemFontOfSize:30];
        [imageView addSubview:title1];
        
        UILabel *title2 = [[UILabel alloc]initWithFrame:CGRectMake(0, kh(130), KScreenWidth, kh(30))];
        title2.text = [title2Ary objectAtIndex:i];
        [title2 setTextAlignment:NSTextAlignmentCenter];
        title2.textColor = [UIColor whiteColor];
        [imageView addSubview:title2];
    
        if(KScreenWidth == 480){
            [imageView setImage:[UIImage imageNamed:[imageAry_480 objectAtIndex:i]]];
        }else{
            [imageView setImage:[UIImage imageNamed:[imageAry_568 objectAtIndex:i]]];
            
        }
        [_scrollView addSubview:imageView];
        if (i == imageAry_480.count - 1) {
            UIButton *beginButton = [[UIButton alloc]initWithFrame:CGRectMake(kw(110), kh(190), kw(100), kh(30))];
            beginButton.layer.borderColor = [[UIColor whiteColor]CGColor];
            beginButton.layer.borderWidth = 1;
            [beginButton setTitle:@"现在开始" forState:UIControlStateNormal];
            [beginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            beginButton.layer.cornerRadius = kh(15);
            [beginButton addTarget:self action:@selector(beginClicked:) forControlEvents:UIControlEventTouchUpInside];
            imageView.userInteractionEnabled = YES;
            [imageView addSubview:beginButton];
        }
    }
    
    [self.view addSubview:_scrollView];
    _scrollView.contentSize = CGSizeMake(KScreenWidth * imageAry_480.count, KScreenHeight );
}

-(void)beginClicked:(id)sender{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"firstlaunchmethod" object:nil];
    [self.navigationController popToRootViewControllerAnimated:YES];
    
//    MainViewController *vc = [[MainViewController alloc]init];
//    [self.navigationController pushViewController:vc animated:YES];
}


@end
