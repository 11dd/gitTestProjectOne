//
//  WeiBoHomeViewController.m
//  testProject
//
//  Created by mac3 on 17/3/31.
//  Copyright © 2017年 test. All rights reserved.
//

#import "WeiBoHomeViewController.h"

#import "XFStatusViewCell.h"
#import "XFTitleButton.h"
#import "XFStatusFrame.h"

#import "XFUser.h"
#import "XFStatus.h"

#import "XFAccount.h"
#import "XFAccountTool.h"
#import "XFDropdownView.h"

#import "UIView+Extension.h"

#define XFColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

@interface WeiBoHomeViewController ()<UIWebViewDelegate,XFDropdownViewDelegate,UITableViewDataSource,UITableViewDelegate>
/**
 *  微博数组（里面放的都是XFStatusFrame模型，一个XFStatusFrame对象就代表一条微博）
 */
@property (nonatomic,strong) NSMutableArray *statusFrames;
@property (nonatomic,strong) NSMutableArray *refreshArray;

@property (nonatomic,strong) UITableView * tableView;
@end

@implementation WeiBoHomeViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self drawNavWithTitle:@"weibo"];
    [self drawBackButton];
    

    NSMutableDictionary * dic = [NSMutableDictionary dictionary];;
    dic[@"access_token"] = @"";
    dic[@"expires_in"] = @"";
    dic[@"remind_in"] = @"";
    dic[@"uid"] = @"";
    
    // 将返回的账号字典数据 --> 模型，存进沙盒
    XFAccount *account = [XFAccount accountWithDict:dic];
    //储存账号信息
    [XFAccountTool saveAccount:account];
    
    self.tableView = [[UITableView alloc]init];
    self.tableView.frame = CGRectMake(0, 64, KScreenWidth, KScreenHeight-64-48);
    self.tableView.backgroundColor = XFColor(244, 244, 244);
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.view addSubview:self.tableView];
    
    //以下是刷新方法
    __unsafe_unretained UITableView *tableView = _tableView;
    //上拉刷新
    tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self loadMoreStatus];
    }];

    //刷新数据
    [self refreshData];


}

//刷新数据
-(void)refreshData {
    
    UIRefreshControl *refresh = [[UIRefreshControl alloc]init];
    
    [refresh addTarget:self action:@selector(refreshStatus:) forControlEvents:UIControlEventValueChanged];
    
    [self.tableView addSubview:refresh];
    
    //进来就开始刷新
    [refresh beginRefreshing];
    
    //一进来就开始加载微博
    [self refreshStatus:refresh];
    
}

/**
 *  UIRefreshControl进入刷新状态：加载最新的数据
 */
-(void)refreshStatus:(UIRefreshControl *)control {
    
    NSString *url = @"https://api.weibo.com/2/statuses/friends_timeline.json";
    
    XFAccount *account = [XFAccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    
    // 取出最前面的微博（最新的微博，ID最大的微博）
    XFStatusFrame *firstStatusF = [self.statusFrames firstObject];
    
    if (firstStatusF) {
        // 若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0
        params[@"since_id"] = firstStatusF.status.idstr;
    }
    
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    
    [sessionManager GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        // 将 "微博字典"数组 转为 "微博模型"数组
        NSArray *newStatuses = [XFStatus mj_objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        
        // 将 XFStatus数组 转为 XFStatusFrame数组
        NSArray *newFrames = [self stausFramesWithStatuses:newStatuses];
        
        NSRange range = NSMakeRange(0, newFrames.count);
        
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:range];
        
        [self.statusFrames insertObjects:newFrames atIndexes:indexSet];
        
        //刷新表格
        [self.tableView reloadData];
        //结束刷新
        [control endRefreshing];
        //显示微博刷新数
        [self showStatusCount:(int)newStatuses.count];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

//显示微博刷新数
-(void)showStatusCount:(int)count {
    
    UILabel *label = [[UILabel alloc]init];
    label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:16];
    label.width = [UIScreen mainScreen].bounds.size.width;
    label.height = 35;
    label.y = 64 - label.height;
    
    if (count) {
        label.text = [NSString stringWithFormat:@"有%d条微博更新了",count];
    }else{
        label.text = @"没有新的微博";
    }
    //添加label
    [self.navigationController.view insertSubview:label belowSubview:self.navigationController.navigationBar];
    //出来的动画
    [UIView animateWithDuration:1.0 animations:^{
        
        label.transform = CGAffineTransformMakeTranslation(0, label.height);
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:1.0 delay:1.0 options:UIViewAnimationOptionCurveLinear animations:^{
            
            label.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            
            [label removeFromSuperview];
        }];
    }];
}

/**
 *  将HWStatus模型转为HWStatusFrame模型
 */

-(NSArray *)stausFramesWithStatuses:(NSArray *)statuses
{
    NSMutableArray *frames = [NSMutableArray array];
    for (XFStatus *status in statuses) {
        XFStatusFrame *f = [[XFStatusFrame alloc] init];
        f.status = status;
        [frames addObject:f];
    }
    return frames;
}



// 加载更多的微博数据
-(void)loadMoreStatus {
    
    // 2.拼接请求参数
    XFAccount *account = [XFAccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    
    // 取出最后面的微博（最新的微博，ID最大的微博）
    XFStatusFrame *lastStatusF = [self.statusFrames lastObject];
    if (lastStatusF) {
        // 若指定此参数，则返回ID小于或等于max_id的微博，默认为0。
        // id这种数据一般都是比较大的，一般转成整数的话，最好是long long类型
        long long maxId = lastStatusF.status.idstr.longLongValue - 1;
        params[@"max_id"] = @(maxId);
    }
    
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    
    [sessionManager GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        // 将 "微博字典"数组 转为 "微博模型"数组
        NSArray *newStatuses = [XFStatus mj_objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        // 将 HWStatus数组 转为 HWStatusFrame数组
        NSArray *newFrames = [self stausFramesWithStatuses:newStatuses];
    
        // 将更多的微博数据，添加到总数组的最后面
        [self.statusFrames addObjectsFromArray:newFrames];
    
        // 刷新表格
        [self.tableView reloadData];
        
        [self.tableView.mj_footer endRefreshing];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        // 结束刷新
        self.tableView.tableFooterView.hidden = YES;
    }];
    
}


#pragma mark - Table view data source

//数据源
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //获得cell
    XFStatusViewCell *cell = [XFStatusViewCell cellWithTableView:tableView];
    //给cell传递模型数据
    cell.statusFrame = self.statusFrames[indexPath.row];

    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.statusFrames.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    XFStatusFrame *frame = self.statusFrames[indexPath.row];
    
    return frame.cellHeight;
}

//懒加载
-(NSMutableArray *)statusFrames {
    
    if (!_statusFrames) {
        _statusFrames  = [NSMutableArray array];
    }
    return _statusFrames;
}


@end
