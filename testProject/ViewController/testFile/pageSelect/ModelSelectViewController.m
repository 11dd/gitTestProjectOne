//
//  ModelSelectViewController.m
//  testProject
//
//  Created by mac3 on 17/3/27.
//  Copyright © 2017年 test. All rights reserved.
//

#import "ModelSelectViewController.h"
#import "XWCell.h"
#import "XWCellModel.h"
#import "XWDragCellCollectionView.h"

@interface ModelSelectViewController ()<XWDragCellCollectionViewDataSource, XWDragCellCollectionViewDelegate>
@property (nonatomic, strong) NSArray *data;
@property (nonatomic, weak) XWDragCellCollectionView *mainView;
@property (nonatomic, assign) UIButton *editButton;
@end

@implementation ModelSelectViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self drawNavWithTitle:@"测试CV拖动重排"];
    [self drawBackButton];
    
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    CGFloat width = (self.view.bounds.size.width - 40) / 3.0f;
    layout.itemSize = CGSizeMake(width, width/2);
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    layout.minimumInteritemSpacing = 10;
    
    
    XWDragCellCollectionView *mainView = [[XWDragCellCollectionView alloc] initWithFrame:CGRectMake(0, 64, KScreenWidth, TableViewHeight) collectionViewLayout:layout];
    _mainView = mainView;
    mainView.delegate = self;
    mainView.dataSource = self;
    mainView.shakeLevel = 3.0f;
    mainView.backgroundColor = [UIColor whiteColor];
    [mainView registerNib:[UINib nibWithNibName:@"XWCell" bundle:nil] forCellWithReuseIdentifier:@"XWCell"];
    [mainView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderIdentifier"];
    [self.view addSubview:mainView];
    
    
    UIButton *editingButton = [[UIButton alloc]initWithFrame:CGRectMake(KScreenWidth-50, 20, KScreenWidth / 320  * 60, 44)];
    [editingButton setTitle:@"编辑" forState:UIControlStateNormal];
    [editingButton addTarget:self action:@selector(xwp_edting:) forControlEvents:UIControlEventTouchDown];
    _editButton = editingButton;
    [self.view addSubview:editingButton];
    
}

- (NSArray *)data{
    
    if (!_data) {
        
        NSMutableArray *temp = @[].mutableCopy;
        NSArray *colors = @[[UIColor redColor], [UIColor blueColor]];
        
        for (int i = 0; i < 2; i ++) {
            
            NSMutableArray *tempSection = @[].mutableCopy;
            
            for (int j = 0; j < arc4random() % 20 + 6; j ++) {
                
                NSString *str = [NSString stringWithFormat:@"%@--%d", @"栏目", j];
                XWCellModel *model = [XWCellModel new];
                model.backGroundColor = colors[i];
                model.title = str;
                [tempSection addObject:model];
                
            }
            [temp addObject:tempSection.copy];
        }
        _data = temp.copy;
    }
    return _data;
}

- (void)xwp_edting:(UIBarButtonItem *)sender{
    
    if (_mainView.isEditing) {
        
        [_mainView xw_stopEditingModel];
        sender.title = @"编辑";
        
    }else{
        
        [_mainView xw_enterEditingModel];
        sender.title = @"退出";
    }
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
        
        //分组的名字
        UILabel * timeLabel = [UILabel new];
        timeLabel.frame = CGRectMake(0, kh(20), kw(320), kh(40));
        timeLabel.backgroundColor = [UIColor whiteColor];
        timeLabel.textColor = [UIColor blackColor];
        timeLabel.textAlignment = NSTextAlignmentLeft;
        timeLabel.font = [UIFont fontWithName:@"Arial" size:kh(14)];
        
        if (indexPath.section == 0) {
            timeLabel.text = [NSString stringWithFormat:@"    %@",@"切换栏目"];

        }else{
            
            timeLabel.text = [NSString stringWithFormat:@"    %@",@"添加栏目"];

        }
        
        [HeaderView addSubview:timeLabel];
        
    }
    
    return HeaderView;
}


#pragma mark - <XWDragCellCollectionViewDataSource>

//返回的组数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return self.data.count;
}

//返回每组的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    NSArray *sec = _data[section];
    return sec.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    XWCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"XWCell" forIndexPath:indexPath];
    cell.data = _data[indexPath.section][indexPath.item];
    return cell;
}

- (NSArray *)dataSourceArrayOfCollectionView:(XWDragCellCollectionView *)collectionView{
    
    return _data;
}

#pragma mark - <XWDragCellCollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    XWCellModel *model = _data[indexPath.section][indexPath.item];
    NSLog(@"点击了%@",model.title);
}

- (void)dragCellCollectionView:(XWDragCellCollectionView *)collectionView newDataArrayAfterMove:(NSArray *)newDataArray{
    
    _data = newDataArray;
    
}

- (void)dragCellCollectionView:(XWDragCellCollectionView *)collectionView cellWillBeginMoveAtIndexPath:(NSIndexPath *)indexPath{
    //拖动时候最后禁用掉编辑按钮的点击
    _editButton.enabled = NO;
}

- (void)dragCellCollectionViewCellEndMoving:(XWDragCellCollectionView *)collectionView{
    
    _editButton.enabled = YES;
}

//- (NSArray<NSIndexPath *> *)excludeIndexPathsWhenMoveDragCellCollectionView:(XWDragCellCollectionView *)collectionView{
//    //每个section的最后一个cell都不能交换
//    NSMutableArray * excluedeIndexPaths = [NSMutableArray arrayWithCapacity:self.data.count];
//    
//    [self.data enumerateObjectsUsingBlock:^(NSArray*  _Nonnull section, NSUInteger idx, BOOL * _Nonnull stop) {
//        
//        [excluedeIndexPaths addObject:[NSIndexPath indexPathForItem:section.count - 1 inSection:idx]];
//        
//    }];
//    
//    return excluedeIndexPaths.copy;
//}


@end
