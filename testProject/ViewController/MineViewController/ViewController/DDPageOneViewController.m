//
//  DDPageOneViewController.m
//  testProject
//
//  Created by mac3 on 17/3/17.
//  Copyright © 2017年 test. All rights reserved.
//

#import "DDPageOneViewController.h"
#import "CommonTableViewCell.h"

@interface DDPageOneViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *tempArray;

@end

@implementation DDPageOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.index == 0) {
        
        NSDictionary * dic = [NSDictionary dictionaryWithObject:@"我是第一页" forKey:@"title"];
        self.tempArray = [NSMutableArray arrayWithObjects:dic, nil];
        
    }else if (self.index == 1){
        
        NSDictionary * dic = [NSDictionary dictionaryWithObject:@"我是第二页" forKey:@"title"];
        self.tempArray = [NSMutableArray arrayWithObjects:dic, nil];
        
    }else{
        
        NSDictionary * dic = [NSDictionary dictionaryWithObject:@"我是第三页" forKey:@"title"];
        self.tempArray = [NSMutableArray arrayWithObjects:dic, nil];
        
    }

    [self.view addSubview:self.tableView];

}

#pragma - mark - 初始化tableview

-(UITableView*)tableView
{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]init];
        _tableView.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight - 104);
        _tableView.backgroundColor = rgba(241, 241, 241, 1);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        
        UIView * footView = [[UIView alloc]init];
        footView.backgroundColor = rgba(241, 241, 241, 1);
        _tableView.tableFooterView = footView;
        
        __unsafe_unretained UITableView *tableView = _tableView;
        
        tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{

            [self initData];
        }];
        // 设置自动切换透明度(在导航栏下面自动隐藏)
        tableView.mj_header.automaticallyChangeAlpha = YES;
        
        tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
          
            [self initData];

        }];
    
    }
    return _tableView;
}

#pragma - mark - 请求数据

-(void)initData
{
    
    if (self.index == 0) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        [dic setValue:@"13478693636" forKey:@"username"];
        
        [NetworkTool POSTWithURLString:@"http://wscsapi.dlruijin.com/Myinterface/Api/MessageCenter" parameters:dic isLoading:self.view success:^(id responseObject) {
            
            NSDictionary * dic = responseObject;
            [self.tempArray addObjectsFromArray: dic[@"querry"]];
            
            [self.tableView reloadData];
            
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
            
        } faile:^(NSError *error) {
            
        }];

    }else{
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }
  
}

#pragma - mark - 布局
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CommonTableViewCell *cell = [CommonTableViewCell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.titleLabel.text = self.tempArray[indexPath.row][@"title"];
    
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

@end
