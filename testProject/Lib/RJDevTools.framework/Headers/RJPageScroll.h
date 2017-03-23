//
//  RJPageScroll.h
//  RJFramework
//
//  Created by shenchengcai on 16/7/15.
//  Copyright © 2016年 dlrj. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RJPageScrollDelegate <NSObject>

@optional
- (void)pageScrollClicked:(NSInteger)index;

@end

@interface RJPageScroll : UIView


@property (nonatomic, strong) UIPageControl *pageCtrl;/**< 页码指示器 */

@property (nonatomic ,assign) id<RJPageScrollDelegate> delegate;
//设置图片名称数组
- (void)setImageNames:(NSArray *)imagenames;
//设置图片链接数组
- (void)setImageUrls:(NSArray *)imageurls;

@end
