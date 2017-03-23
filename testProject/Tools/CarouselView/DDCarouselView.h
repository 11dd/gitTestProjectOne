//
//  DDCarouselView.h
//  轮播图
//
//  Created by zdd on 17/3/4.
//  Copyright © 2016年 at. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DDCarouselView;
@protocol DDCarouselViewDelegate <NSObject>
@optional
/**
 *  点击图片的回调事件
 */
- (void)carouselView:(DDCarouselView *)carouselView indexOfClickedImageBtn:(NSUInteger)index;
@end

@interface DDCarouselView : UIView

//传入图片数组
@property (nonatomic, copy) NSArray *images;

//pageControl颜色设置
@property (nonatomic, strong) UIColor *currentPageColor;
@property (nonatomic, strong) UIColor *pageColor;

//是否竖向滚动
@property (nonatomic, assign, getter=isScrollDorectionPortrait) BOOL scrollDorectionPortrait;

@property (weak, nonatomic) id<DDCarouselViewDelegate> delegate;

@end

/*
 
//使用方法
DDCarouselView *carousel = [[DDCarouselView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, kh(200))];
carousel.delegate = self;
//carousel.scrollDorectionPortrait = YES;//横向还是竖向;
carousel.images = @[
                    [UIImage imageNamed:@"0"],
                    [UIImage imageNamed:@"1"],
                    [UIImage imageNamed:@"2"],
                    [UIImage imageNamed:@"3"],
                    [UIImage imageNamed:@"4"]
                    ];
carousel.currentPageColor = [UIColor orangeColor];
carousel.pageColor = [UIColor grayColor];
[cell.contentView addSubview:carousel];
 
 #pragma - mark - 轮播图点击方法
 
 - (void)carouselView:(DDCarouselView *)carouselView indexOfClickedImageBtn:(NSUInteger )index {
 NSLog(@"点击了第%ld张图片",index);
 }
 
*/







