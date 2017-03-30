//
//  ModelSelectViewController.h
//  testProject
//
//  Created by mac3 on 17/3/27.
//  Copyright © 2017年 test. All rights reserved.
//

#import "BaseViewController.h"

@interface ModelSelectViewController : BaseViewController

@end


/*
 UICollectionView拖拽重排
 
 1、继承于XWDragCellCollectionView；
 
 2、实现必须实现的DataSouce代理方法：（在该方法中返回整个CollectionView的数据数组用于重排）
 - (NSArray *)dataSourceArrayOfCollectionView:(XWDragCellCollectionView *)collectionView;
 
 3、实现必须实现的一个Delegate代理方法：（在该方法中将重拍好的新数据源设为当前数据源）(例如 :_data = newDataArray)
 - (void)dragCellCollectionView:(XWDragCellCollectionView *)collectionView newDataArrayAfterMove:(NSArray *)newDataArray;
 
 */

/*
 
 利用截图大法，将手指要移动的cell截个图来进行移动，并隐藏该cell，
 然后在合适的时候交换cell的位置，造成是拖拽cell被拖拽到新位置的效果
 
 */

/*
 
 从iOS9开始，系统已经提供了重排的API;
 
 // Support for reordering
 - (BOOL)beginInteractiveMovementForItemAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(9_0); // returns NO if reordering was prevented from beginning - otherwise YES
 - (void)updateInteractiveMovementTargetPosition:(CGPoint)targetPosition NS_AVAILABLE_IOS(9_0);
 - (void)endInteractiveMovement NS_AVAILABLE_IOS(9_0);
 - (void)cancelInteractiveMovement NS_AVAILABLE_IOS(9_0);
 
 */



