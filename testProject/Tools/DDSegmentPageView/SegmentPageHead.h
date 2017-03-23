//
//  SegmentPageHead.h
//  MLMSegmentPage
//
//  Created by my on 16/11/4.
//  Copyright © 2016年 my. All rights reserved.
//

#ifndef SegmentPageHead_h
#define SegmentPageHead_h

#import "UIView+ViewController.h"
#import "UIView+EasyFrame.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#endif /* SegmentPageHead_h */


/*
         #pragma mark - 均分下划线使用示例
         
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

 
 */
