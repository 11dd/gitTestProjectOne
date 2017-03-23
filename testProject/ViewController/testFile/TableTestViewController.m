//
//  TableTestViewController.m
//  testProject
//
//  Created by mac3 on 17/3/13.
//  Copyright © 2017年 test. All rights reserved.
//

#import "TableTestViewController.h"
#import "TestTableViewCell.h"
#import "TestModel.h"

#import "CollectionViewController.h"

@interface TableTestViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong)UITableView * tempTableView;

@property (nonatomic,strong)NSMutableArray *dataSource;

@property(nonatomic, strong)UIView * forView;

@end

//测试示例cell动态高度

static NSString *identify = @"TestTableViewCell";

@implementation TableTestViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = rgba(233, 233, 233, 1);
    [self drawNavWithTitle:@"测试页动态cell高度"];
    [self drawBackButton];

    [self configModel];
    
    [self.tempTableView registerNib:[UINib nibWithNibName:identify bundle:nil]
             forCellReuseIdentifier:identify];
    
    [self.view addSubview:self.tempTableView];

}

#pragma - mark - 数据模型
- (void)configModel
{
    NSArray *descArr = @[@"1\n我\n是一个\n名字",
                         @"2\n这里\n可是显示任何文字信息,并且不做显示的\n全部显示",
                         @"3\n也可以设置行数哈",
                         @"4\n这样动态cell的高度就\n好多了",
                         @"5\n建设\n社会主义新中国",
                         @"6\n我\n是一个\n名字"];
    
    for (NSInteger i = 0; i < descArr.count; i ++)
    {
        TestModel *model = [[TestModel alloc] init];
        model.userName = descArr[i];
        [self.dataSource addObject:model];
    }
}


#pragma - mark - 懒加载tableview
-(UITableView*)tempTableView
{
    if (!_tempTableView) {
        
        _tempTableView = [[UITableView alloc]initWithFrame:
                          CGRectMake(0, 64, KScreenWidth, KScreenHeight - 64)
                                                     style:UITableViewStylePlain];
        _tempTableView.backgroundColor = rgba(241, 241, 241, 1);
        
        _tempTableView.delegate = self;
        _tempTableView.dataSource = self;
        //隐藏滚动条
        _tempTableView.showsVerticalScrollIndicator = NO;
        //分隔线
        //_tempTableView.separatorColor = [UIColor clearColor];

        UIView * footView = [[UIView alloc]init];
        footView.backgroundColor = rgba(241, 241, 241, 1);;
        _tempTableView.tableFooterView = footView;
        
        //以下是刷新方法
        __unsafe_unretained UITableView *tableView = _tempTableView;
        
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
    return _tempTableView;
}

#pragma - mark - cell布数据
- (void)configCell:(TestTableViewCell *)cell indexpath:(NSIndexPath *)index
{
    TestModel *model = self.dataSource[index.row];
    
    cell.testLabel.text = model.userName;
    
}
#pragma - mark - 点击cell方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionViewController *chooseVC = [[CollectionViewController alloc]init];
    [self.navigationController pushViewController:chooseVC animated:YES];
}

#pragma - mark - cell布局
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TestTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;//没有选中状态

    [self configCell:cell indexpath:indexPath];

    return cell;
    
}
#pragma - mark - 行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

#pragma - mark - 先预估设置的高度
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kh(50);
}

#pragma - mark - 实际计算高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [tableView fd_heightForCellWithIdentifier:identify cacheByIndexPath:indexPath configuration:^(TestTableViewCell *cell)
            {
                [self configCell:cell indexpath:indexPath];
            }];
    
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
    return kh(200);
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

#pragma - mark - 数据源数组实例化
-(NSMutableArray *)dataSource
{
    if (_dataSource == nil) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
}




@end
