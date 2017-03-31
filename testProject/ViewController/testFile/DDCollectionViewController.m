//
//  ChooseViewController.m
//  Com.wusi.ruijin
//
//  Created by mac3 on 17/1/15.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "DDCollectionViewController.h"


@interface DDCollectionViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>
{
    
    UICollectionView *_collectionView;

    NSInteger signNum;//标记点击的第几个组
}

@end
//测试示例,CollectionView

@implementation DDCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = rgba(241, 241, 241, 1);
    [self drawNavWithTitle:@"测试Collection"];
    [self drawBackButton];
    
    [self drawViewCollectionView];

}

#pragma - mark - 创建collectionView

-(void)drawViewCollectionView{
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(kw(300)/4, kw(300)/8);//每个cell的宽高
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 0;
    flowLayout.sectionInset  = UIEdgeInsetsMake(0, 0, 0, 0);
    
    _collectionView = [[UICollectionView alloc] initWithFrame:
                       CGRectMake(kw(10), 64, kw(300),KScreenHeight-64) collectionViewLayout:flowLayout];
    
    //一定要注册
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"colletionCell"];
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderIdentifier"];
    
    _collectionView.backgroundColor = rgba(241, 241, 241, 1);
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    
    _collectionView.alwaysBounceVertical = YES;
    _collectionView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_collectionView];
    
}

#pragma - mark - 布局cell

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuseIdetify = @"colletionCell";
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdetify forIndexPath:indexPath];
    
    cell.contentView.backgroundColor = rgba(241, 241, 241, 1);
    //这句是每次都移除view上的控件,从新添加的;
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];

    
    /********************/
    //每个按钮创建(此处最好用label),上下左右各留1像素,就出来UI上的线了,节省了划线的代码;
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(1, 1, cell.contentView.frame.size.width - 2, cell.contentView.frame.size.height - 2)];
    btn.backgroundColor = [UIColor whiteColor];
    
    [btn setTitle:@"测试数据啊" forState:UIControlStateNormal];
    
    [btn setTitleColor:rgba(0, 0, 0, 0.6)  forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:kh(11)];
    
    btn.enabled = NO;
    
    [cell.contentView addSubview:btn];
    /***********************/
    
    
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    

    
}


//返回每组的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 4;
}

//返回的组数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 3;
}


#pragma - mark - collectionView头header高度

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    CGSize size={KScreenWidth,kh(60)};//返回高度
    return size;
}

#pragma - mark - collectionView上的title

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView * HeaderView;
    
    if(kind ==UICollectionElementKindSectionHeader){
        
        HeaderView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"HeaderIdentifier" forIndexPath:indexPath];
        
        HeaderView.backgroundColor = rgba(241, 241, 241, 1);
        [HeaderView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        
        //分组的名字,
        UILabel * timeLabel = [UILabel new];
        timeLabel.frame = CGRectMake(0, kh(20), kw(320), kh(40));
        timeLabel.backgroundColor = [UIColor whiteColor];
        timeLabel.textColor = [UIColor blackColor];
        timeLabel.textAlignment = NSTextAlignmentLeft;
        timeLabel.font = [UIFont fontWithName:@"Arial" size:kh(14)];
        
        timeLabel.text = [NSString stringWithFormat:@"    %@",@"我是标题"];
        
        [HeaderView addSubview:timeLabel];
        
    }
    
    return HeaderView;
}



@end
