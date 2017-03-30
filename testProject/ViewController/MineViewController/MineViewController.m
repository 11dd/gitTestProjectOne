//
//  MineViewController.m
//  testProject
//
//  Created by mac3 on 17/2/13.
//  Copyright © 2017年 test. All rights reserved.
//

#import "MineViewController.h"
#import "LoginViewController.h"
#import "GTMBase64_2.h"
#import "NotificationViewController.h"
#import "DDOrderViewController.h"
#import "ChagePassWordViewController.h"
#import "SettingViewController.h"

#define kHEIGHT 160 * (KScreenHeight) / 568.0

@interface MineViewController ()<UITableViewDelegate,UITableViewDataSource,
                     UINavigationControllerDelegate,
                     UIImagePickerControllerDelegate>

@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, strong) UIImageView * headerImg;
@end

@implementation MineViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = rgba(233, 233, 233, 1);
    [self drawNavWithTitle:@"我的"];

    self.dataSource = [NSMutableArray arrayWithObjects:
                       @[@"个人信息",@"我的收藏",@"我的订单",@"消息中心"],
                       @[@"修改密码",@"系统设置",@"关于我们"],nil];
    
    [self.view addSubview:self.tableView];
   
    //在做autoLayout之前 一定要先将view添加到superview上 否则会报错
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        //CGFloat top, CGFloat left, CGFloat bottom, CGFloat right
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(64, 0, KTABBAR_HEIGHT, 0));
    }];

}


#pragma - mark - tableview

-(UITableView *)tableView
{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:
                      CGRectMake(0, 0, 0, 0) style:UITableViewStyleGrouped];
        
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorColor = rgba(207, 210, 213, 1);
        _tableView.showsVerticalScrollIndicator = NO;//隐藏滚动条
        //_tableView.bounces = NO;//禁止tableView弹性效果
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell_id"];
        _tableView.tableFooterView = [[UIView alloc]init];
        
    }
    return _tableView;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell_id" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;//点击没有选中状态
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //显示最右边的箭头

    cell.textLabel.text = self.dataSource[indexPath.section][indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:kh(13)];
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSource[section] count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kh(44);
}

#pragma - mark - 点击cell方法

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 2) {
            DDOrderViewController *orderVC = [[DDOrderViewController alloc]init];
            [self.navigationController pushViewController:orderVC animated:YES];

        }
        if (indexPath.row == 3) {
            NotificationViewController *msgVC = [[NotificationViewController alloc]init];
            [self.navigationController pushViewController:msgVC animated:YES];

        }
    }else if(indexPath.section == 1){
        
        if (indexPath.row == 0) {
            ChagePassWordViewController *chageVC = [[ChagePassWordViewController alloc]init];
            [self.navigationController pushViewController:chageVC animated:YES];

        }
        if (indexPath.row == 1) {
            
            SettingViewController *setVC = [[SettingViewController alloc]init];
            [self.navigationController pushViewController:setVC animated:YES];
        }
    }
    
    
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        
        UIView * view = [[UIView alloc]init];
        view.backgroundColor = KNavColor;
        
        //显示头像还是登录按钮
        int i = 0;
        if (i == 1) {
            
            self.headerImg = [[UIImageView alloc]init];
            self.headerImg.frame = CGRectMake((KScreenWidth - kh(100))/2, kh(20), kh(100), kh(100));
            self.headerImg.backgroundColor = [UIColor yellowColor];
            self.headerImg.layer.cornerRadius = kh(100)/2;
            self.headerImg.userInteractionEnabled = YES;
            [view addSubview:self.headerImg];
            //单击手势
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(singleClick)];
            [tapGesture setNumberOfTapsRequired:1];
            [self.headerImg addGestureRecognizer:tapGesture];

            
        }else{
            
            UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake((KScreenWidth-kw(100))/2, kh(100), kw(100), kh(50));
            button.backgroundColor = [UIColor clearColor];
            [button setTitle:@"登录" forState:UIControlStateNormal];
            [button addTarget:self action:@selector(Loginpress) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:button];

        }
        
        return view;
        
        
    }else{
        UIView * view = [[UIView alloc]init];
        view.backgroundColor = rgba(241, 241, 241, 1);
        return view;
    }
   
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView * view = [[UIView alloc]init];
    view.backgroundColor = rgba(241, 241, 241, 1);
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return kHEIGHT;
    }else{
        
        return kh(5);
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return kh(5);
}

-(void)Loginpress
{
    LoginViewController *loginVC = [[LoginViewController alloc]init];
    [self.navigationController pushViewController:loginVC animated:YES];
}



#pragma - mark - 以下为更换头像方法

-(void)singleClick
{
    UIAlertView * altvw=[[UIAlertView alloc]initWithTitle:@"请选择获取方式" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"打开照相机",@"从手机相册获取", nil];
    altvw.delegate=self;
    [altvw show ];
}


- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    
    /*
     调用相机相册,显示中文将Info.plist 
     文件中的Localization native development region
     设置为China
     
     */
    if (buttonIndex == 1) {
        [self getAvatatFormCamera:self];
    }
    if (buttonIndex ==2) {
        [self getAvatatFormPhotoLibrary:self];
        
    }
    NSLog(@"%ld",(long)buttonIndex);
}


#pragma - mark - getAvatar Action

- (void)getAvatatFormPhotoLibrary:(UIViewController *)controller
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        picker.delegate = self;
        picker.allowsEditing = YES;
        
        [self presentViewController:picker animated:YES completion:nil];
        
    }
}

- (void)getAvatatFormCamera:(UIViewController *)controller
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    picker.delegate = self;
    picker.showsCameraControls = YES;
    picker.allowsEditing = YES;
    
    [self presentViewController:picker animated:YES completion:nil];
    
}

#pragma - mark - UIImagePickerControllerDelegate

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    UIImage* image = [info objectForKey:UIImagePickerControllerEditedImage];
    
    [picker dismissViewControllerAnimated:YES completion:^{
        
        CGSize newSize = CGSizeMake(kw(300), kw(300));
        UIGraphicsBeginImageContext(newSize);
        UIImage *imagechuansong = image;
        [imagechuansong drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
        UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        NSLog((@"\n[函数名:%s]\n" "[行号:%d]\n" "%@\n"), __FUNCTION__, __LINE__,newImage);

//        //以文件形式上传图片
//        [self postRequestWithURL:@"" picFileName:@"boris.png" dataimage:newImage];
//        
//        //以data格式上传图片
//        NSString * aString = [GTMBase64_2 stringByEncodingData:UIImagePNGRepresentation(newImage)];
//        [self reloadPhoto:aString];
        
    }];
    
}

#pragma - mark - post 上传图片

-(void)reloadPhoto:(NSString *)aString
{
    
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setValue:@"" forKey:@""];
    
    [NetworkTool POSTWithURLString:@"" parameters:dic isLoading:self.view success:^(id responseObject) {
        
        
    } faile:^(NSError *error) {
        
    }];

}


#pragma makr -- 上传图片文件到服务器

static NSString * const FORM_FLE_INPUT = @"file";

-(void)postRequestWithURL: (NSString *)url picFileName: (NSString *)picFileName dataimage:(UIImage *)image;
{
    NSString *TWITTERFON_FORM_BOUNDARY = @"AaB03x";
    
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]
                                                           cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                                       timeoutInterval:10];
    //分界线 --AaB03x
    NSString *MPboundary=[[NSString alloc]initWithFormat:@"--%@",TWITTERFON_FORM_BOUNDARY];
    //结束符 AaB03x--
    NSString *endMPboundary=[[NSString alloc]initWithFormat:@"%@--",MPboundary];
    //得到图片的data
    NSData* data;

    data = UIImageJPEGRepresentation(image, 0.01);
    
    NSMutableString *body=[[NSMutableString alloc]init];
    
    //参数的集合的所有key的集合
    NSArray *keys = @[@"file",@"P"];
    
    //遍历keys
    for(int i=0;i<[keys count];i++)
    {
        //得到当前key
        NSString *key=[keys objectAtIndex:i];
        //如果key不是imgfile，说明value是字符类型，比如name：Boris
        if(![key isEqualToString:@"file"])
        {
            //得到当前key
            NSString *key=[keys objectAtIndex:i];
            //添加分界线，换行
            [body appendFormat:@"%@\r\n",MPboundary];
            //添加字段名称，换2行
            [body appendFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n",key];
            //添加字段的值
            NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
            
            [dic setObject:@"" forKey:@"userId"];//上传需要的参数
            
            NSData *datadic=[NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
            NSString *jsonStr=[[NSString alloc]initWithData:datadic encoding:NSUTF8StringEncoding];
            [body appendFormat:@"%@\r\n",jsonStr];
            
        }
    }
    //添加文件
    [body appendFormat:@"%@\r\n",MPboundary];
    
    //声明pic字段，文件名为boris.png
    [body appendFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n",FORM_FLE_INPUT,picFileName];
    //声明上传文件的格式
    [body appendFormat:@"Content-Type:image/png\r\n\r\n"];
    
    //声明结束符：--AaB03x--
    NSString *end=[[NSString alloc]initWithFormat:@"\r\n%@",endMPboundary];
    //声明myRequestData，用来放入http body
    NSMutableData *myRequestData=[NSMutableData data];
    //将body字符串转化为UTF8格式的二进制
    [myRequestData appendData:[body dataUsingEncoding:NSUTF8StringEncoding]];
    //将image的data加入
    [myRequestData appendData:data];
    // [myRequestData appendData:[body dataUsingEncoding:NSUTF8StringEncoding]];
    //加入结束符--AaB03x--
    [myRequestData appendData:[end dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSLog(@"%@",myRequestData);
    
    //设置HTTPHeader中Content-Type的值
    NSString *content=[[NSString alloc]initWithFormat:@"multipart/form-data; boundary=%@",TWITTERFON_FORM_BOUNDARY];
    [request setValue:content forHTTPHeaderField:@"Content-Type"];
    //设置Content-Length
    [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[myRequestData length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:myRequestData];
    [request setHTTPMethod:@"POST"];

    [NSURLConnection sendAsynchronousRequest:request  queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {

        if (data) {
            NSLog(@"response_%@",[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);
            NSDictionary* json = [NSJSONSerialization
                                  JSONObjectWithData:data
                                  options:kNilOptions
                                  error:&connectionError];
            
            NSLog(@"%@",json);
            
        }else{

        }
        
    }];
}


@end
