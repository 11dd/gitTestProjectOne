//
//  DDImageViewController.m
//  test315
//
//  Created by mac3 on 17/3/3.
//  Copyright © 2017年 test. All rights reserved.
//

#import "DDImageViewController.h"
#import "UIImageView+WebCache.h"
#import "SeeImageObj.h"
#import "SeeImagesView.h"

@interface DDImageViewController ()<UIGestureRecognizerDelegate,UIScrollViewDelegate>


@end

//照片查看器,查看单张图片,可缩放查看
@implementation DDImageViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = rgba(233, 233, 233, 1);
    [self drawNavWithTitle:@"照片墙"];

    [self drawBackButton];


    
    SeeImageObj *z1 = [[SeeImageObj alloc]init];
    z1.name = @"test0";
    z1.url = self.urlStr;
    z1.whidth = [NSString stringWithFormat:@"%f",KScreenWidth];
    z1.height = [NSString stringWithFormat:@"%f",KScreenHeight-64];
    z1.imgTitle = @"";
    z1.imgContent = @"";
    
    //单张
    SeeImagesView *ss = [[SeeImagesView alloc]init];
    ss.backgroundColor = [UIColor clearColor];
    CGRect re1 = ss.frame;
    re1.origin.x = 0;
    re1.origin.y = 64;
    re1.size.width = KScreenWidth;
    re1.size.height = KScreenHeight-64;
    ss.frame = re1;
    
    [ss setObj:z1 ImageArray:nil];
    ss.isOpen = YES;
    //[self.view addSubview:ss];
    
    //多张
    NSMutableArray *arr = [NSMutableArray arrayWithObjects:z1,z1, nil];
    
    SeeImagesView * Img = [[SeeImagesView alloc]initWithFrame:CGRectMake(0, 10, 320, 400)];
    [Img setObj:z1 ImageArray:arr];
    Img.isOpen = YES;
    //[self.view addSubview:Img];
    
}

-(void)btubackPress
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
