//
//  CommonTableViewController.m
//  testProject
//
//  Created by mac3 on 17/3/17.
//  Copyright © 2017年 test. All rights reserved.
//

#import "CommonTableViewController.h"
#import "CommonTableViewCell.h"

@interface CommonTableViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong)UITableView * tableView;
@property(nonatomic, strong)NSMutableArray * tempArray;
@property(nonatomic, assign)NSInteger pageNum;


@end

@implementation CommonTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = rgba(241, 241, 241, 1);
    [self drawNavWithTitle:@"测试tableview"];
    [self drawBackButton];

    self.tempArray = [NSMutableArray arrayWithObjects:@"逗你玩",@"逗你玩",@"逗你玩",@"逗你玩",@"逗你玩",@"逗你玩",@"逗你玩", nil];
    [self.view addSubview:self.tableView];

}

#pragma - mark - 初始化tableview
-(UITableView*)tableView
{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]init];
        _tableView.frame = CGRectMake(0, 64, KScreenWidth, KScreenHeight - 64);
        _tableView.backgroundColor = rgba(241, 241, 241, 1);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        
        UIView * footView = [[UIView alloc]init];
        footView.backgroundColor = rgba(241, 241, 241, 1);;
        _tableView.tableFooterView = footView;
        
        __unsafe_unretained UITableView *tableView = _tableView;
        
        // 下拉刷新
        tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [tableView.mj_header endRefreshing];
            });
        }];
        
        // 设置自动切换透明度(在导航栏下面自动隐藏)
        tableView.mj_header.automaticallyChangeAlpha = YES;
        
        // 上拉刷新
        tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [tableView.mj_footer endRefreshing];
            });
        }];

        
    }
    return _tableView;
}

#pragma - mark - 布局
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CommonTableViewCell *cell = [CommonTableViewCell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.textLabel.text = [self.tempArray objectAtIndex:indexPath.row];
    
    return cell;
}
#pragma - mark - 行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tempArray.count;
}

#pragma - mark - 行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return kh(82);
}
#pragma - mark - 选中点击方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   

}


#pragma - mark - tableview头部view
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * view = [[UIView alloc]init];
    
    return view;
}

#pragma - mark - tableview头部高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return kh(10);
}

#pragma - mark - tableview尾部view
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView * view = [[UIView alloc]init];
    
    return view;
}

#pragma - mark - tableview尾部高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    return kh(10);
    
}

#pragma - mark -
#pragma - mark - 删除

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  UITableViewCellEditingStyleDelete;

    // return UITableViewCellEditingStyleNone;
}


-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        UIAlertView *alt = [[UIAlertView alloc]initWithTitle:@"是否删除该信息" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alt.tag = indexPath.row;
        [alt show];
        
    }
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return @"删除";
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex == 0){
    }
    else{
        
        
    }
    
}

#pragma - mark - 数据源数组实例化

-(NSMutableArray *)tempArray
{
    if (_tempArray == nil) {
        _tempArray = [[NSMutableArray alloc] init];
    }
    return _tempArray;
}

@end
