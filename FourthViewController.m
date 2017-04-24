//
//  FourthViewController.m
//  testProject
//
//  Created by mac3 on 17/2/20.
//  Copyright © 2017年 test. All rights reserved.
//

#import "FourthViewController.h"

#import "CustomttCollectionViewCell.h"
typedef enum{
    RTSnapshotMeetsEdgeTop,
    RTSnapshotMeetsEdgeBottom,
}RTSnapshotMeetsEdge;
@interface FourthViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    NSMutableArray * arrdatamy;
    NSMutableArray * arrdatatuijian;
    UICollectionView * collectviewtoutiao;
    NSString * statedianji;
  //  UIButton * btueditor;
   // UILabel *label;
}
/**记录手指所在的位置*/
@property (nonatomic, assign) CGPoint fingerLocation;
/**被选中的cell的新位置*/
@property (nonatomic, strong) NSIndexPath *relocatedIndexPath;
/**被选中的cell的原始位置*/
@property (nonatomic, strong) NSIndexPath *originalIndexPath;
/**对被选中的cell的截图*/
@property (nonatomic, weak) UIView *snapshot;
/**自动滚动的方向*/
@property (nonatomic, assign) RTSnapshotMeetsEdge autoScrollDirection;
/**cell被拖动到边缘后开启，collectionView自动向上或向下滚动*/
@property (nonatomic, strong) CADisplayLink *autoScrollTimer;
@property (nonatomic, assign) int availNum;
@end

@implementation FourthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = rgba(233, 233, 233, 1);
    [self drawNavWithTitle:@"第四"];
    [self createCollectionviews];
    statedianji=@"0";
    arrdatamy=[NSMutableArray arrayWithObjects:@"推荐",@"大连",@"体育",@"游戏",@"股票",@"三农",@"军事",@"热点",@"社会",@"娱乐",@"科技",@"汽车",@"财经",@"国际",@"趣图",@"房产",@"育儿",@"数码",@"电影",@"家居",@"教育",@"手机",@"精选",@"彩票",@"小说",@"历史",@"政务", nil];
 //   arrdatamy=@[@"推荐",@"大连",@"体育",@"游戏",@"股票",@"三农",@"军事",@"热点",@"社会",@"娱乐",@"科技",@"汽车",@"财经",@"国际",@"趣图",@"房产",@"育儿",@"数码",@"电影",@"家居",@"教育",@"手机",@"精选",@"彩票",@"小说",@"历史",@"政务"];
    arrdatatuijian=[NSMutableArray arrayWithObjects:@"直播",@"时尚",@"搞笑",@"美食",@"养生",@"旅游",@"宠物",@"情感",@"孕产",@"科学",@"故事",@"收藏",@"语录",@"星座",@"美图",@"辟谣",@"中国新唱将",@"健康",@"特卖",@"订阅",@"美女",@"正能量",@"动漫",@"图片",@"文化",@"视频",@"段子",@"火山直播",@"问答", nil];
 //   arrdatatuijian=@[@"直播",@"时尚",@"搞笑",@"美食",@"养生",@"旅游",@"宠物",@"情感",@"孕产",@"科学",@"故事",@"收藏",@"语录",@"星座",@"美图",@"辟谣",@"中国新唱将",@"健康",@"特卖",@"订阅",@"美女",@"正能量",@"动漫",@"图片",@"文化",@"视频",@"段子",@"火山直播",@"问答"];
    
}
-(void)createCollectionviews
{
    UICollectionViewFlowLayout * flowlayout=[[UICollectionViewFlowLayout alloc]init];
    flowlayout.itemSize = CGSizeMake(kw(60), kh(30)) ;
    flowlayout.minimumLineSpacing = kw(4);
    flowlayout.minimumInteritemSpacing = kh(4) ;
    flowlayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    collectviewtoutiao=[[UICollectionView alloc]initWithFrame:CGRectMake(kw(0), 64,KScreenWidth, KScreenHeight-64-49) collectionViewLayout:flowlayout];
    [collectviewtoutiao registerClass:[CustomttCollectionViewCell class] forCellWithReuseIdentifier:@"cell_id"];
    //    //注册headerView  此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中 一致  均为reusableView
    [collectviewtoutiao registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"cell_id"];
    collectviewtoutiao.delegate=self;
    collectviewtoutiao.dataSource=self;
    collectviewtoutiao.backgroundColor=kclearcolor;
    collectviewtoutiao.alwaysBounceVertical = YES;
    [self.view addSubview:collectviewtoutiao];
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressGestureRecognized:)];
    [collectviewtoutiao addGestureRecognizer:longPress];
}
# pragma mark - Gesture methods

- (void)longPressGestureRecognized:(id)sender{
    
    UILongPressGestureRecognizer *longPress = (UILongPressGestureRecognizer *)sender;
    UIGestureRecognizerState longPressState = longPress.state;
    //手指在collectionView中的位置
    _fingerLocation = [longPress locationInView:collectviewtoutiao];
    //手指按住位置对应的indexPath，可能为nil
    _relocatedIndexPath = [collectviewtoutiao indexPathForItemAtPoint:_fingerLocation];
    NSLog(@"_relocatedIndexPath.section==%ld",(long)_relocatedIndexPath.section);
    if(_relocatedIndexPath.section==0)
    {
        statedianji=@"1";
        if (_relocatedIndexPath.row > arrdatamy.count ) return;  //空白模块不可移动
        switch (longPressState) {
            case UIGestureRecognizerStateBegan:{
                
                //手势开始，对被选中cell截图，隐藏原cell
                _originalIndexPath = [collectviewtoutiao indexPathForItemAtPoint:_fingerLocation];
                if (_originalIndexPath) {
                    [self cellSelectedAtIndexPath:_originalIndexPath];
                }
                break;
            }
            case UIGestureRecognizerStateChanged:{//点击位置移动，判断手指按住位置是否进入其它indexPath范围，若进入则更新数据源并移动cell
                
                //截图跟随手指移动
                CGPoint center = _snapshot.center;
                center.y = _fingerLocation.y;
                center.x = _fingerLocation.x ;
                _snapshot.center = center;
                
                NSLog(@"_relocatedIndexPath:%ld,availNum:%lu",(long)_relocatedIndexPath.row,(unsigned long)arrdatamy.count);
                // if (_relocatedIndexPath.row < self.availNum ) {
                if (_relocatedIndexPath.row < arrdatamy.count ) {
                    //                NSLog(@"_relocatedIndexPath:%d,availNum:%d",_relocatedIndexPath.row,self.availNum);
                    
                    //如果到了整个collectionView以外，就滚回原处
                    if ([self checkIfSnapshotMeetsEdge]) {
                        [self startAutoScrollTimer];
                    }else{
                        [self stopAutoScrollTimer];
                    }
                    
                    //手指按住位置对应的indexPath，可能为nil
                    
                    if (_relocatedIndexPath && ![_relocatedIndexPath isEqual:_originalIndexPath]) {
                        
                        [self cellRelocatedToNewIndexPath:_relocatedIndexPath];
                        NSLog(@"拖拽过程中：移动位置到 -- %ld",(long)_relocatedIndexPath.row);
                        
                    }
                }
                break;
            }
            default: {                             //长按手势结束或被取消，移除截图，显示cell
                [self stopAutoScrollTimer];
                [self didEndDraging];
                //            if ([self.adelegate respondsToSelector:@selector(cellDidEndMovingIncollectionView:)]) {
                //                [self.adelegate cellDidEndMovingIncollectionView:self];
                //            }
                break;
            }
        }
    }else
    {
        if ([statedianji isEqualToString:@"1"]) {
            if(longPressState==UIGestureRecognizerStateChanged)
            {
                CGPoint center = _snapshot.center;
                center.y = _fingerLocation.y;
                center.x = _fingerLocation.x ;
                _snapshot.center = center;
            }
            if (longPressState==UIGestureRecognizerStateEnded) {// 拖拽结束
                [self stopAutoScrollTimer];
                NSLog(@"%ld %ld",(long)_originalIndexPath.section,_originalIndexPath.row);
                [arrdatatuijian insertObject:arrdatamy[_originalIndexPath.row] atIndex:0];
                [arrdatamy removeObjectAtIndex:_originalIndexPath.row];
                NSIndexPath * path=[NSIndexPath indexPathForRow:0 inSection:1];
                CustomttCollectionViewCell *cell =(CustomttCollectionViewCell *) [collectviewtoutiao cellForItemAtIndexPath:_originalIndexPath] ;
                cell.hidden = NO;
                cell.alpha = 0;
                [collectviewtoutiao moveItemAtIndexPath:_originalIndexPath toIndexPath:path];
                //  [collectviewtoutiao reloadData];
                statedianji=@"0";
                [self didEndDraging];
            }
        }
        
    }

    
}
/**
 *  cell被长按手指选中，对其进行截图，原cell隐藏
 */
- (void)cellSelectedAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectviewtoutiao cellForItemAtIndexPath:indexPath] ;
    
    UIView *snapshot = [self customSnapshotFromView:cell];
    
    [collectviewtoutiao addSubview:snapshot];
    
    _snapshot = snapshot;
    cell.hidden = YES;
    CGPoint center = _snapshot.center;
    center.y = _fingerLocation.y;
    [UIView animateWithDuration:0.2 animations:^{
        _snapshot.transform = CGAffineTransformMakeScale(1.03, 1.03);
        _snapshot.alpha = 0.98;
        _snapshot.center = center;
    }];
}

#pragma mark - 返回一个给定view的截图.
- (UIView *)customSnapshotFromView:(UIView *)inputView {
    
    // Make an image from the input view.
    UIGraphicsBeginImageContextWithOptions(inputView.bounds.size, NO, 0);
    [inputView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // Create an image view.
    UIView *snapshot = [[UIImageView alloc] initWithImage:image];
    snapshot.center = inputView.center;
    snapshot.layer.masksToBounds = NO;
    snapshot.layer.cornerRadius = 0.0;
    snapshot.layer.shadowOffset = CGSizeMake(-5.0, 0.0);
    snapshot.layer.shadowRadius = 5.0;
    snapshot.layer.shadowOpacity = 0.4;
    
    return snapshot;
}
#pragma mark -  检查截图是否到达整个collectionView的边缘，并作出响应

- (BOOL)checkIfSnapshotMeetsEdge{
    CGFloat minY = CGRectGetMinY(_snapshot.frame);
    CGFloat maxY = CGRectGetMaxY(_snapshot.frame);
    if (minY < collectviewtoutiao.contentOffset.y) {
        _autoScrollDirection = RTSnapshotMeetsEdgeTop;
        return YES;
    }
    if (maxY > collectviewtoutiao.bounds.size.height + collectviewtoutiao.contentOffset.y) {
        _autoScrollDirection = RTSnapshotMeetsEdgeBottom;
        return YES;
    }
    return NO;
}
#pragma mark - timer methods
/**
 *  创建定时器并运行
 */
- (void)startAutoScrollTimer{
    if (!_autoScrollTimer) {
        _autoScrollTimer = [CADisplayLink displayLinkWithTarget:self selector:@selector(startAutoScroll)];
        [_autoScrollTimer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    }
}
/**
 *  停止定时器并销毁
 */
- (void)stopAutoScrollTimer{
    if (_autoScrollTimer) {
        [_autoScrollTimer invalidate];
        _autoScrollTimer = nil;
    }
}
#pragma mark - 开始自动滚动

- (void)startAutoScroll{
    CGFloat pixelSpeed = 5;
    if (_autoScrollDirection == RTSnapshotMeetsEdgeTop) {//向下滚动
        if (collectviewtoutiao.contentOffset.y > 0) {//向下滚动最大范围限制
            [collectviewtoutiao setContentOffset:CGPointMake(0, collectviewtoutiao.contentOffset.y - pixelSpeed)];
            _snapshot.center = CGPointMake(_snapshot.center.x, _snapshot.center.y - pixelSpeed);
        }
    }else{                                               //向上滚动
        if (collectviewtoutiao.contentOffset.y + collectviewtoutiao.bounds.size.height < collectviewtoutiao.contentSize.height) {//向下滚动最大范围限制
            [collectviewtoutiao setContentOffset:CGPointMake(0, collectviewtoutiao.contentOffset.y + pixelSpeed)];
            _snapshot.center = CGPointMake(_snapshot.center.x, _snapshot.center.y + pixelSpeed);
        }
    }
    
    /*  当把截图拖动到边缘，开始自动滚动，如果这时手指完全不动，则不会触发‘UIGestureRecognizerStateChanged’，对应的代码就不会执行，导致虽然截图在collectionView中的位置变了，但并没有移动那个隐藏的cell，用下面代码可解决此问题，cell会随着截图的移动而移动
     */
    
    _relocatedIndexPath = [collectviewtoutiao indexPathForItemAtPoint:_snapshot.center] ;
    if (_relocatedIndexPath && ![_relocatedIndexPath isEqual:_originalIndexPath]) {
        [self cellRelocatedToNewIndexPath:_relocatedIndexPath];
    }
}
#pragma mark - 移动时更新位置数据
/**
 *  截图被移动到新的indexPath范围，这时先更新数据源，重排数组，再将cell移至新位置
 *  @param indexPath 新的indexPath
 */
- (void)cellRelocatedToNewIndexPath:(NSIndexPath *)indexPath{
    //更新数据源并返回给外部
    [self updateDataSource];
    //交换移动cell位置
    
    [collectviewtoutiao moveItemAtIndexPath:_originalIndexPath toIndexPath:indexPath];
    //更新cell的原始indexPath为当前indexPath
    _originalIndexPath = indexPath;
    
}
# pragma mark - Private methods
/**修改数据源，通知外部更新数据源*/
- (void)updateDataSource{
    
    //通过DataSource代理获得原始数据源数组
//    NSMutableArray *tempArray = [NSMutableArray array];
//    if ([self.adataSource respondsToSelector:@selector(originalArrayDataForcollectionView:)]) {
//        [tempArray addObjectsFromArray:[self.adataSource originalArrayDataForcollectionView:self]];
//    }
//    [tempArray addObjectsFromArray:arrdatamy];
    //移动数据
   NSMutableArray * arr=[NSMutableArray arrayWithArray:[self moveObjectInMutableArray:arrdatamy fromIndex:_originalIndexPath.row toIndex:_relocatedIndexPath.row]];
    [arrdatamy removeAllObjects];
    [arrdatamy addObjectsFromArray:arr];
    //    将新数组传出外部以更改数据源
//    if ([self.adelegate respondsToSelector:@selector(collectionView:newArrayDataForDataSource:)]) {
//        [self.adelegate collectionView:self newArrayDataForDataSource:tempArray];
//    }
}

/**
 *  将可变数组中的一个对象移动到该数组中的另外一个位置
 *  @param array     要变动的数组
 *  @param fromIndex 从这个index
 *  @param toIndex   移至这个index
 */
- (NSMutableArray *)moveObjectInMutableArray:(NSMutableArray *)array fromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex{
    
  //  NSInteger tempIndex = 0;
  //  NSMutableString *tempTitle = nil;
    
    if (fromIndex < toIndex) {
        for (NSInteger i = fromIndex; i < toIndex; i ++) {
            [array exchangeObjectAtIndex:i withObjectAtIndex:i + 1];
        }
    }else{
        for (NSInteger i = fromIndex; i > toIndex; i --) {
            [array exchangeObjectAtIndex:i withObjectAtIndex:i - 1];
        }
    }
    return array;
}
/**
 *  拖拽结束，显示cell，并移除截图
 */
- (void)didEndDraging{
    
    CustomttCollectionViewCell *cell =(CustomttCollectionViewCell *) [collectviewtoutiao cellForItemAtIndexPath:_originalIndexPath] ;
    cell.hidden = NO;
    cell.alpha = 0;
    [UIView animateWithDuration:0.2 animations:^{
        _snapshot.center = cell.center;
        _snapshot.alpha = 0;
        _snapshot.transform = CGAffineTransformIdentity;
        cell.alpha = 1;
    } completion:^(BOOL finished) {
        cell.hidden = NO;
        [_snapshot removeFromSuperview];
        _snapshot = nil;
        _originalIndexPath = nil;
        _relocatedIndexPath = nil;
        
        [collectviewtoutiao reloadData];
    }];
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section==0) {
       return arrdatamy.count;
    }else
    {
       return arrdatatuijian.count;
    }
    
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(kh(0), kw(34),kh(0),kw(33));
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
  
    CustomttCollectionViewCell * cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cell_id" forIndexPath:indexPath];
    
    
    if (indexPath.section==0) {
        cell.labname.text=arrdatamy[indexPath.row];
    }else
    {
        cell.labname.text=arrdatatuijian[indexPath.row];
  
    }
    
    return cell;
}
//header的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(KScreenWidth, kh(40));
}
//通过设置SupplementaryViewOfKind 来设置头部或者底部的view，其中 ReuseIdentifier 的值必须和 注册是填写的一致，本例都为 “reusableView”
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"cell_id" forIndexPath:indexPath];
    headerView.backgroundColor =kclearcolor;
   [headerView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
   UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(kw(34), kh(5), kw(100), kh(30))];
    if (indexPath.section==0) {
         label.text = @"我的频道";
      UIButton *  btueditor=[[UIButton alloc]initWithFrame:CGRectMake(KScreenWidth-kw(34+35),kh(12),kw(35),kh(16))];
        kyjviewBorderRadius(btueditor, kh(8), 0.5, kredColor);
        [btueditor setText:@"编辑"];
        [btueditor setTextColor:kredColor];
        btueditor.titleLabel.font=kFont(9);
        [btueditor addClick:self selector:@selector(btubianji:)];
        [headerView addSubview:btueditor];
    }else  if (indexPath.section==1)
    {
         label.text = @"频道推荐";
   
    }
    label.textColor=ktextColor1;
    label.font = kFont(12);
    [headerView addSubview:label];

    return headerView;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
     [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
          CustomttCollectionViewCell * cell=(CustomttCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
          NSLog(@"%@",cell.labname.text);
    if (indexPath.section==1)
    {
        [arrdatamy addObject:arrdatatuijian[indexPath.row]];
        [arrdatatuijian removeObjectAtIndex:indexPath.row];
        NSIndexPath * path=[NSIndexPath indexPathForRow:arrdatamy.count-1 inSection:0];
        [collectviewtoutiao moveItemAtIndexPath:indexPath toIndexPath:path];
        [collectviewtoutiao reloadData];
    }
}

//- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//}
-(void)btubianji:(UIButton *)sender
{
    NSLog(@"编辑");
}

@end
