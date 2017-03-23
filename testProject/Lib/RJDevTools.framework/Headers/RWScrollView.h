//
//  RWScrollView.h
//  RWUIControls
//
//  Created by shenchengcai on 15/3/2.
//  Copyright (c) 2015年 QM. All rights reserved.
//
//  更新日期：2016-08-02 by shenchengcai
//  更新内容：增加列表分页的功能

#import <UIKit/UIKit.h>

@protocol RWScrollViewDelegate<NSObject, UITableViewDelegate>

@required
//分页的请求方法
- (void)getDatasource:(void (^)(NSArray *dicarray, NSError *error))block page:(NSInteger)page __deprecated_msg("Renamed to 有优化的方法");

@optional
//分页请求返回结果后的处理，一般用来hidden loading
- (void)endDatasource;

- (void)noMoreDataSource;

@end

/**
 *  封装一个具有下拉刷新和上提加载功能的UITableView
 */

@interface RWScrollView : UITableView

#pragma mark - 实现分页

@property (nonatomic, assign) id<RWScrollViewDelegate> delegate;/**< UITableViewDelegate */
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSString *modelName;/**< model的name */

- (void)reqDatasource;

#pragma mark - 继承自MJRefresh

@property (assign, nonatomic) CGFloat mj_x;
@property (assign, nonatomic) CGFloat mj_y;
@property (assign, nonatomic) CGFloat mj_width;
@property (assign, nonatomic) CGFloat mj_height;
@property (assign, nonatomic) CGSize mj_size;
@property (assign, nonatomic) CGPoint mj_origin;

@property (assign, nonatomic) CGFloat mj_contentInsetTop;
@property (assign, nonatomic) CGFloat mj_contentInsetBottom;
@property (assign, nonatomic) CGFloat mj_contentInsetLeft;
@property (assign, nonatomic) CGFloat mj_contentInsetRight;

@property (assign, nonatomic) CGFloat mj_contentOffsetX;
@property (assign, nonatomic) CGFloat mj_contentOffsetY;

@property (assign, nonatomic) CGFloat mj_contentSizeWidth;
@property (assign, nonatomic) CGFloat mj_contentSizeHeight;

#pragma mark - 下拉刷新
/**
 *  添加一个下拉刷新头部控件
 *
 *  @param callback 回调
 */
- (void)addHeaderWithCallback:(void (^)())callback;

/**
 *  添加一个下拉刷新头部控件
 *
 *  @param target 目标
 *  @param action 回调方法
 */
- (void)addHeaderWithTarget:(id)target action:(SEL)action;

/**
 *  移除下拉刷新头部控件
 */
- (void)removeHeader;

/**
 *  主动让下拉刷新头部控件进入刷新状态
 */
- (void)headerBeginRefreshing;

/**
 *  让下拉刷新头部控件停止刷新状态
 */
- (void)headerEndRefreshing;

/**
 *  下拉刷新头部控件的可见性
 */
@property (nonatomic, assign, getter = isHeaderHidden) BOOL headerHidden;

/**
 *  是否正在下拉刷新
 */
@property (nonatomic, assign, readonly, getter = isHeaderRefreshing) BOOL headerRefreshing;

#pragma mark - 上拉刷新
/**
 *  添加一个上拉刷新尾部控件
 *
 *  @param callback 回调
 */
- (void)addFooterWithCallback:(void (^)())callback;

/**
 *  添加一个上拉刷新尾部控件
 *
 *  @param target 目标
 *  @param action 回调方法
 */
- (void)addFooterWithTarget:(id)target action:(SEL)action;

/**
 *  移除上拉刷新尾部控件
 */
- (void)removeFooter;

/**
 *  主动让上拉刷新尾部控件进入刷新状态
 */
- (void)footerBeginRefreshing;

/**
 *  让上拉刷新尾部控件停止刷新状态
 */
- (void)footerEndRefreshing;

/**
 *  上拉刷新头部控件的可见性
 */
@property (nonatomic, assign, getter = isFooterHidden) BOOL footerHidden;

/**
 *  是否正在上拉刷新
 */
@property (nonatomic, assign, readonly, getter = isFooterRefreshing) BOOL footerRefreshing;

/**
 *  设置尾部控件的文字
 */
@property (copy, nonatomic) NSString *footerPullToRefreshText; // 默认:@"上拉可以加载更多数据"
@property (copy, nonatomic) NSString *footerReleaseToRefreshText; // 默认:@"松开立即加载更多数据"
@property (copy, nonatomic) NSString *footerRefreshingText; // 默认:@"正在帮你加载数据..."

/**
 *  设置头部控件的文字
 */
@property (copy, nonatomic) NSString *headerPullToRefreshText; // 默认:@"下拉可以刷新"
@property (copy, nonatomic) NSString *headerReleaseToRefreshText; // 默认:@"松开立即刷新"
@property (copy, nonatomic) NSString *headerRefreshingText; // 默认:@"正在帮你刷新..."

@end
