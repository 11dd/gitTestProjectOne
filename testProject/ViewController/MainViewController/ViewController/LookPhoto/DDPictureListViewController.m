//
//  SGImageViewController.m
//  testA
//
//  Created by mac3 on 17/2/13.
//  Copyright © 2017年 test. All rights reserved.
//

#import "DDPictureListViewController.h"


@interface DDPictureListViewController ()<UICollectionViewDataSource, UICollectionViewDelegate,
                                        UIScrollViewDelegate,UIGestureRecognizerDelegate>
{
    UICollectionView *_collectionView;
    UIView * backgroundView;
    
    int imageTag;
    
    CGFloat lastScale;
    
}

@property (nonatomic, strong)UIScrollView *rotateScrollView;
@property (nonatomic, strong)NSMutableArray *imageArray;

@end
//图片列表也,点击之后全屏查看,可左右滑动查看
@implementation DDPictureListViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.imageArray = [NSMutableArray arrayWithObjects:
                       @"zdd_nanzhuang",
                       @"zdd_nvzhuang",
                       @"zdd_peishi",
                       @"zdd_zhubao", nil];
    [self drawView];

}

//隐藏状态栏
- (BOOL)prefersStatusBarHidden {
    
    return YES;
}

#pragma - mark - 创建collectionView

-(void)drawView{
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(KScreenWidth/3, KScreenWidth/3);
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 0;
    flowLayout.sectionInset  = UIEdgeInsetsMake(0, 0, 0, 0);
    
    _collectionView = [[UICollectionView alloc] initWithFrame:
                       CGRectMake(0, 64, KScreenWidth,KScreenHeight-64) collectionViewLayout:flowLayout];
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"colletionCell"];
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderIdentifier"];
    
    _collectionView.backgroundColor = rgba(241, 241, 241, 1);
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    
    _collectionView.alwaysBounceVertical = YES;
    _collectionView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_collectionView];
    
}

#pragma - mark - collectionView头header高度

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    CGSize size={KScreenWidth,0};
    return size;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.imageArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuseIdetify = @"colletionCell";
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdetify forIndexPath:indexPath];
    
    cell.contentView.backgroundColor = [UIColor whiteColor];
    
    UIImageView* myImageView = [[UIImageView alloc] init];
    myImageView.frame = CGRectMake(kw(5), kh(5), KScreenWidth/3-kw(10),KScreenWidth/3-kw(10));
    myImageView.backgroundColor = [UIColor lightGrayColor];
    
    //[myImageView sd_setImageWithURL:self.imageArray[0] placeholderImage:[UIImage imageNamed:@""]];
    myImageView.image = [UIImage imageNamed:self.imageArray[indexPath.row]];
    
    myImageView.userInteractionEnabled = YES;
    
    [cell.contentView addSubview:myImageView];

    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    imageTag = (int)indexPath.row;

    backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight)];
    [backgroundView setBackgroundColor:[UIColor blackColor]];
    
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    [window addSubview:backgroundView];
    
    [self.rotateScrollView setContentOffset:CGPointMake(CGRectGetWidth(self.view.frame)*imageTag, 0) animated:YES];
    
    [backgroundView addSubview:self.rotateScrollView];
    
    [self shakeToShow:backgroundView];//放大过程中的动画
    
}


//放大过程中出现的缓慢动画
- (void)shakeToShow:(UIView*)aView{
    
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.3;
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    [aView.layer addAnimation:animation forKey:nil];
    
}

#pragma - mark - 以下是ScrollView滑动

-(UIScrollView *)rotateScrollView
{
    if (!_rotateScrollView) {
        
        _rotateScrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
        _rotateScrollView.contentSize = CGSizeMake(CGRectGetWidth(self.view.frame)*self.imageArray.count, CGRectGetHeight(self.view.frame));
        _rotateScrollView.pagingEnabled = YES;
        _rotateScrollView.showsHorizontalScrollIndicator = NO;
        
        _rotateScrollView.minimumZoomScale = 1; // 最小缩小比例
        _rotateScrollView.maximumZoomScale = 2; // 最大缩放比例
        
        _rotateScrollView.delegate = self;

        for (int i = 0; i< self.imageArray.count; i++) {
            
            UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(KScreenWidth*i+5, kh(100),
                                                                                 KScreenWidth-10, kh(345))];
            imgView.backgroundColor = [UIColor lightGrayColor];
            
            //[imgView sd_setImageWithURL:self.imageArray[i] placeholderImage:[UIImage imageNamed:@""]];
            imgView.image = [UIImage imageNamed:self.imageArray[i]];

            imgView.userInteractionEnabled = YES;
            imgView.contentMode =UIViewContentModeScaleAspectFit;
            
            [_rotateScrollView addSubview:imgView];
            
            //单击手势
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closeView)];
            [tapGesture setNumberOfTapsRequired:1];
            [_rotateScrollView addGestureRecognizer:tapGesture];
            
            //            //双击手势
            //            UITapGestureRecognizer *doubleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
            //                                                                                               action:@selector(douleGesture:)];
            //            [doubleTapGesture setNumberOfTapsRequired:2];
            //            [_rotateScrollView addGestureRecognizer:doubleTapGesture];
            //             //区分单击,双击
            //             [tapGesture requireGestureRecognizerToFail:doubleTapGesture];

            
            UIPinchGestureRecognizer *pinchRecognizer = [[UIPinchGestureRecognizer alloc]initWithTarget:self
                                                                                                 action:@selector(scaGesture:)];
            [pinchRecognizer setDelegate:self];
            [_rotateScrollView addGestureRecognizer:pinchRecognizer];

        }
    }
    return _rotateScrollView;
}

-(void)closeView{
    
    [backgroundView removeFromSuperview];
}

-(void)scaGesture:(id)sender {
    
    [self.view bringSubviewToFront:[(UIPinchGestureRecognizer*)sender view]];
    
    if([(UIPinchGestureRecognizer*)sender state] == UIGestureRecognizerStateEnded) {
        
        lastScale = 1.0;
        return;
    }
    CGFloat scale = 1.0 - (lastScale - [(UIPinchGestureRecognizer*)sender scale]);
    
    CGAffineTransform currentTransform = [(UIPinchGestureRecognizer*)sender view].transform;
    
    CGAffineTransform newTransform = CGAffineTransformScale(currentTransform, scale, scale);
    
    [[(UIPinchGestureRecognizer*)sender view]setTransform:newTransform];
    
    lastScale = [(UIPinchGestureRecognizer*)sender scale];
    
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
  shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    
    return ![gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]];
    
}

//完成放大缩小时调用
-(void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale
{
    
    CGAffineTransform currentTransform = scrollView.transform;
    
    if (currentTransform.a < 1.0) {
        currentTransform.a = 1.0;
    }
    if (currentTransform.d < 1.0) {
        currentTransform.d = 1.0;
    }

    CGAffineTransform newTransform = CGAffineTransformScale(currentTransform, scale, scale);
    
    [scrollView setTransform:newTransform];
    
}

//滑动时缩小到正常尺寸
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
        
    float curOffX = scrollView.contentOffset.x;

    if (curOffX >= KScreenWidth) {
        
        CGAffineTransform currentTransform = _rotateScrollView.transform;
        
        if (currentTransform.a > 1.0) {
            currentTransform.a = 1.0;
        }
        if (currentTransform.d > 1.0) {
            currentTransform.d = 1.0;
        }
        CGAffineTransform newTransform = CGAffineTransformScale(currentTransform, 1.0, 1.0);
        [scrollView setTransform:newTransform];

    }
    
}
@end
