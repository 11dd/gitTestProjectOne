//
//  MainViewController.m
//  testProject
//
//  Created by mac3 on 17/2/13.
//  Copyright © 2017年 test. All rights reserved.
//

#import "TableTestViewController.h"
#import "MainViewController.h"
#import "MainTableViewCell.h"
#import "MainModel.h"


@interface MainViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong)UITableView * tempTableView;

@property (nonatomic,strong)NSMutableArray *dataSource;

@property (nonatomic,strong)NSString *tempStr;

@end

static NSString *identify = @"MainTableViewCell";

@implementation MainViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = rgba(233, 233, 233, 1);
    [self drawNavWithTitle:@"主页"];

    [self test];//进入示例类
    
    
    [self.view addSubview:self.tempTableView];
    [self.tempTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        //CGFloat top, CGFloat left, CGFloat bottom, CGFloat right
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(64, 0, KTABBAR_HEIGHT, 0));
    }];


    
    [self configModel];

}
-(void)test
{
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, kw(60), 44)];
    [btn setTitle:@"示例类" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clickTest) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:btn];
}
//进入示例类
-(void)clickTest
{
    TableTestViewController *tableVC = [[TableTestViewController alloc]init];
    [self.navigationController pushViewController:tableVC animated:YES];
    
}
//数据模型
- (void)configModel
{
    
    NSMutableArray *descArr = [[NSMutableArray alloc]init];
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setValue:@"13478693636" forKey:@"username"];
    
    [NetworkTool POSTWithURLString:@"http://wscsapi.dlruijin.com/Myinterface/Api/MessageCenter" parameters:dic isLoading:self.view success:^(id responseObject) {
        
        NSDictionary * dic = responseObject;
        [descArr addObjectsFromArray: dic[@"querry"]];

        for(int i = 0; i < descArr.count; i ++)
        {
            MainModel *model = [[MainModel alloc] init];
            
            model.userName = descArr[i][@"title"];
            model.mainImageURL = descArr[i][@"text"];
            [self.dataSource addObject:model];
            
            [self.tempTableView reloadData];
            
            [self.tempTableView.mj_header endRefreshing];
            [self.tempTableView.mj_footer endRefreshing];
            
        }
        
    } faile:^(NSError *error) {

    }];
    
}


//懒加载tableview
-(UITableView*)tempTableView
{
    if (!_tempTableView) {
        
        _tempTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStyleGrouped];
        _tempTableView.backgroundColor = rgba(241, 241, 241, 1);
        _tempTableView.delegate = self;
        _tempTableView.dataSource = self;
        //隐藏滚动条
        _tempTableView.showsVerticalScrollIndicator = NO;
        //分隔线
        //_tempTableView.separatorColor = [UIColor clearColor];
        
        [_tempTableView registerClass:[MainTableViewCell class] forCellReuseIdentifier:identify];

        
        UIView * footView = [[UIView alloc]init];
        footView.backgroundColor = rgba(241, 241, 241, 1);;
        _tempTableView.tableFooterView = footView;
        
        __unsafe_unretained UITableView *tableView = _tempTableView;
        
        tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self configModel];
        }];
        // 设置自动切换透明度(在导航栏下面自动隐藏)
        tableView.mj_header.automaticallyChangeAlpha = YES;
        
        tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            [self configModel];
        }];
        
    }
    return _tempTableView;
}

#pragma - mark - tableView
#pragma - mark - cellForRowAtIndexPath

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[MainTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
        
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self configCell:cell indexpath:indexPath];
    
    return cell;
    
}

//cell布数据
- (void)configCell:(MainTableViewCell *)cell indexpath:(NSIndexPath *)index
{
    MainModel *model = self.dataSource[index.row];
    
    cell.topLabel.text = model.userName;
    cell.timeLabel.text = model.mainImageURL;
    
}

//实际计算高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 120;
}

//行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

//先预估设置的高度
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kh(50);
}

#pragma - mark - 点击cell方法

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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
    
    return kh(5);
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * view = [[UIView alloc]init];

    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
  
    return kh(200);
}

//数据源
-(NSMutableArray *)dataSource
{
    if (_dataSource == nil) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
}

@end
