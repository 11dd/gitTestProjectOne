//
//  SeeImagesView.h
//  testFramworkDemo
//
//  Created by GT_MAC_2 on 15/7/16.
//  Copyright (c) 2015年 hyc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SeeImageObj.h"

@interface SeeImagesView : UIView

//这个图片类的图片
@property (nonatomic,strong) UIImageView *MyImageView;

//图片显示需要的 图片对象数组
@property (nonatomic,strong) NSMutableArray *arr_Imgs;

//手势状态  999为特殊设置打开图片就显示上下遮盖（999只走一次）， 0有上下黑色半透明遮盖   1，没有遮盖
@property (nonatomic,assign) int ShouShitype;

//图片滚动scr
@property (nonatomic,strong) UIScrollView *img_Scroll;

//接收传过来的图片对象
@property (nonatomic,strong) SeeImageObj *imgOb;

//winsdow 添加的最外层view
@property (nonatomic,strong) UIView *windowView;

//topView  顶遮盖
@property (nonatomic,strong) UIView *topView;

//下方遮盖
@property (nonatomic ,strong) UIView *bottomView;

//scroller 显示的当前页数
@property (nonatomic,assign) int currentPage;

//当前页数lab
@property (nonatomic,strong) UILabel *currentLabel;

//scroller 显示当前页的图片文字
@property (nonatomic,strong) NSString *imgString;

//图片文字lab
@property (nonatomic,strong) UILabel *imgContentLabel;

//scroller 显示当前图的标题
@property (nonatomic,strong) NSString *imgNameSt;

//图片标题lab
@property (nonatomic,strong)  UILabel * imgNameLabel;

//获取的window 的最外层view
@property (nonatomic,strong)  UIView *outView;

//scroll里面的图片view 数组
@property (nonatomic,strong) NSMutableArray *arr_viewImg;

//scroller里面的scroller   数组
@property (nonatomic,strong) NSMutableArray *arr_scro;

//未缩放的 view的Img 的frame 的数组
@property (nonatomic,strong) NSMutableArray *arr_imgF;

//第一次缩放 判断
//@property (nonatomic,assign) BOOL isOne;

/*******************以下是外部调用******************************/

//是否开启 点击手势
@property (nonatomic,assign) BOOL isOpen;

//设置当前图片显示的 图片对象
- (void) setObj :(id) aa  ImageArray:(NSMutableArray *)array;

////外部调用 这只 图片对象数组
//- (void) setImagesArray :(NSMutableArray *)arr;

@end
