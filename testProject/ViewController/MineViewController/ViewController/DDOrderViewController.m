//
//  DDOrderViewController.m
//  testProject
//
//  Created by mac3 on 17/3/17.
//  Copyright © 2017年 test. All rights reserved.
//

#import "DDOrderViewController.h"
#import "DDPageOneViewController.h"
#import "MLMSegmentManager.h"
#import "AppDelegate.h"

@interface DDOrderViewController ()
{
    NSArray *list;
}

@property (nonatomic, strong) MLMSegmentHead *segHead;
@property (nonatomic, strong) MLMSegmentScroll *segScroll;

@end

@implementation DDOrderViewController

-(void)viewWillAppear:(BOOL)animated
{
    //移除栈里的其他页面,直接回到跟目录
    NSMutableArray*tempMarr =[NSMutableArray arrayWithArray:self.navigationController.viewControllers];
    NSMutableArray* temp = [[NSMutableArray alloc]init];
    [temp addObject:[tempMarr objectAtIndex:0]];
    [temp addObject:self];
    [self.navigationController setViewControllers:temp animated:YES];
    
//    AppDelegate *appDeleage = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    appDeleage.tab.selectedIndex = 5;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self drawNavWithTitle:@"我的订单"];
    [self drawBackButton];

    [self segmentStyle];
}

#pragma mark - 均分下划线

- (void)segmentStyle
{
    list = @[@"全部订单",@"未完成",@"已完成"];
    //headStyle:1 layoutStyle:0这个风格是下划线风格
    _segHead = [[MLMSegmentHead alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 40) titles:list headStyle:1 layoutStyle:0];
    _segHead.fontScale = .85;
    _segHead.fontSize = 14;
    _segHead.lineScale = .5;
    _segHead.bottomLineHeight = 0;
    
    _segScroll = [[MLMSegmentScroll alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_segHead.frame), SCREEN_WIDTH, SCREEN_HEIGHT-CGRectGetMaxY(_segHead.frame)) vcOrViews:[self vcArr:list.count]];
    _segScroll.loadAll = NO;
    _segScroll.showIndex = 0;
    
    [MLMSegmentManager associateHead:_segHead withScroll:_segScroll completion:^{
        [self.view addSubview:_segHead];
        [self.view addSubview:_segScroll];
    }];

}

#pragma mark - 数据源
- (NSArray *)vcArr:(NSInteger)count {
    
    NSMutableArray *arr = [NSMutableArray array];
    for (NSInteger i = 0; i < count; i ++) {
        DDPageOneViewController *vc = [DDPageOneViewController new];
        vc.index = i;
        [arr addObject:vc];
    }
    return arr;
}




@end
