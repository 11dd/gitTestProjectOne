//
//  LoginViewController.m
//  testProject
//
//  Created by mac3 on 17/2/13.
//  Copyright © 2017年 test. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "DDForgetViewController.h"

@interface LoginViewController ()<UITextFieldDelegate>
{
    UITextField *_text_username;
    UITextField *_text_password;
}
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = rgba(233, 233, 233, 1);
    [self drawNavWithTitle:@"登录"];
    [self drawBackButton];
    
    UIButton *btn_zhuce = [[UIButton alloc]initWithFrame:CGRectMake(kw(270), 22, kw(40), 44)];
    [btn_zhuce setTitle:@"注册" forState:UIControlStateNormal];
    [btn_zhuce setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn_zhuce addTarget:self action:@selector(clickzhuce) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn_zhuce];
    
    //解决键盘遮挡住输入框的问题
    [Helper setKeyboardManagerEnable:YES];
    
    [self initUI];
    [self loginButton];
    
}

#pragma - mark - 注册
-(void)clickzhuce
{
    RegisterViewController * regVC = [[RegisterViewController alloc]init];
    [self.navigationController pushViewController:regVC animated:YES];
}

#pragma - mark - 忘记密码
-(void)clickwangji
{
    DDForgetViewController * forgetVC = [[DDForgetViewController alloc]init];
    [self.navigationController pushViewController:forgetVC animated:YES];

}

#pragma - mark - 登录
-(void)clickdenglu
{
    NSString *URLString = @"http://xxxx/php/login/login.php";

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"username"] = @"zhangsan";
    parameters[@"password"] = @"zhang";
    
    // 发送POST请求
    [manager POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"%@",responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
}

#pragma - mark - qq登录
-(void)clickQQ
{
    
}

#pragma - mark - 微信登陆
-(void)clickWeixin
{
    
}

#pragma - mark - 微博
-(void)clickWebo
{
    
}

#pragma - mark - 键盘代理方法


#pragma - mark - 界面布局

-(void)initUI{
    
    UIView *view_username  = [[UIView alloc]initWithFrame:CGRectMake(0, kh(75), KScreenWidth, kh(44))];
    view_username.backgroundColor = [UIColor whiteColor];
    
    UIImageView * image1 = [[UIImageView alloc]init];
    image1.frame = CGRectMake(kw(13),kh(13),kw(16), kh(18));
    image1.image = [UIImage imageNamed:@"zdd_login1"];
    [view_username addSubview:image1];
    
    UILabel *lab_username = [[UILabel alloc]initWithFrame:CGRectMake(kw(45), kh(7), kw(40),kh(30))];
    lab_username.text = @"账号";
    lab_username.font = [UIFont systemFontOfSize:kh(14)];
    lab_username.textColor = DDTextFieldColor;
    [view_username addSubview:lab_username];
    
    _text_username = [[UITextField alloc]initWithFrame:CGRectMake(kw(90), kh(7),kw(210), kh(30))];
    _text_username.delegate = self;
    _text_username.keyboardType = UIKeyboardTypeNumberPad;
    _text_username.placeholder = @"请输入手机号码";
    _text_username.font = [UIFont systemFontOfSize:kh(14)];
    _text_username.clearButtonMode = UITextFieldViewModeAlways;
    [view_username  addSubview:_text_username];
    
    [self.view addSubview:view_username];
    
    UIView * lineView = [[UIView alloc]init];
    lineView.frame = CGRectMake(kw(20),view_username.frame.size.height - 1, kw(300), 1);
    lineView.backgroundColor = DDColor;
    [view_username addSubview:lineView];
    
    UIView *view_password  = [[UIView alloc]initWithFrame:CGRectMake(0, kh(119), KScreenWidth, kh(44))];
    view_password.backgroundColor = [UIColor whiteColor];
    
    UIImageView * image2 = [[UIImageView alloc]init];
    image2.frame = CGRectMake(kw(13), kh(13), kw(16), kh(18));
    image2.image = [UIImage imageNamed:@"zdd_login2"];
    [view_password addSubview:image2];
    
    UILabel *lab_password = [[UILabel alloc]initWithFrame:CGRectMake(kw(45), kh(7), kw(40),kh(30))];
    lab_password.text = @"密码";
    lab_password.font = [UIFont systemFontOfSize:kh(14)];
    lab_password.textColor = DDTextFieldColor;
    [view_password addSubview:lab_password];
    
    _text_password = [[UITextField alloc]initWithFrame:CGRectMake(kw(90), kh(7), kw(210), kh(30))];
    _text_password.delegate = self;
    _text_password.placeholder = @"请输入密码";
    _text_password.font = [UIFont systemFontOfSize:kh(14)];
    [_text_password setSecureTextEntry:YES];
    _text_password.clearButtonMode = UITextFieldViewModeAlways;
    [view_password  addSubview:_text_password];
    [self.view addSubview:view_password];
    
}

#pragma - mark - 登录按钮以及三方登录按钮

-(void)loginButton
{

    UIButton *btn_denglu = [[UIButton alloc]initWithFrame:CGRectMake(kw(15), kh(200), kw(290), kh(40))];
    [btn_denglu setTitle:@"登录" forState:UIControlStateNormal];
    [btn_denglu setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn_denglu setBackgroundColor:DDLoginColor];
    btn_denglu.layer.cornerRadius = kh(5);
    [btn_denglu addTarget:self action:@selector(clickdenglu) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn_denglu];
    
    UIButton *btn_wangjimima = [[UIButton alloc]initWithFrame:CGRectMake(kw(250), kh(168), kw(60), kh(15))];
    [btn_wangjimima setTitle:@"忘记密码" forState:UIControlStateNormal];
    btn_wangjimima.titleLabel.font = [UIFont systemFontOfSize:kh(13)];
    [btn_wangjimima setTitleColor:TEXTCOLOR forState:UIControlStateNormal];
    [btn_wangjimima addTarget:self action:@selector(clickwangji) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn_wangjimima];
    
    UIImageView *otherImage = [[UIImageView alloc]init];
    otherImage.frame = CGRectMake(kw(28), kh(440), kw(264), kh(15));
    otherImage.image = [UIImage imageNamed:@"zdd_otherImage"];
    [self.view addSubview:otherImage];
    
    UILabel *lab_hezuo = [[UILabel alloc]initWithFrame:CGRectMake(otherImage.frame.size.width /2 - 40, 0,80, otherImage.frame.size.height)];
    lab_hezuo.text = @"第三方登录";
    lab_hezuo.font = [UIFont systemFontOfSize:12];
    lab_hezuo.textColor = DDTextFieldColor;
    lab_hezuo.textAlignment = 1;
    [otherImage addSubview:lab_hezuo];
    
    UIButton *btn_QQ = [[UIButton alloc]initWithFrame:CGRectMake(kw(40), kh(480), kw(30), kh(30))];
    [btn_QQ setImage:[UIImage imageNamed:@"zdd_qq1"] forState:UIControlStateNormal];
    [btn_QQ addTarget:self action:@selector(clickQQ) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn_QQ];
    
    UILabel *lab_qq = [[UILabel alloc]initWithFrame:CGRectMake(kw(40), kh(520) , kw(30), kh(20))];
    lab_qq.text = @"QQ";
    lab_qq.font = [UIFont systemFontOfSize:12];
    lab_qq.textColor = DDTextFieldColor;
    lab_qq.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lab_qq];
    
    UIButton *btn_weixin = [[UIButton alloc]initWithFrame:CGRectMake(kw(145), kh(480) , kw(30), kh(30))];
    [btn_weixin setImage:[UIImage imageNamed:@"zdd_weixin2"] forState:UIControlStateNormal];
    [btn_weixin addTarget:self action:@selector(clickWeixin) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn_weixin];
    
    UILabel *lab_weixin = [[UILabel alloc]initWithFrame:CGRectMake(kw(145), kh(520) , kw(30), kh(20))];
    lab_weixin.text = @"微信";
    lab_weixin.font = [UIFont systemFontOfSize:12];
    lab_weixin.textColor = DDTextFieldColor;
    lab_weixin.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lab_weixin];
    
    
    UIButton *btn_Weibo = [[UIButton alloc]initWithFrame:CGRectMake(kw(250), kh(480) , kw(30), kh(30))];
    [btn_Weibo setImage:[UIImage imageNamed:@"zdd_weibo3"] forState:UIControlStateNormal];
    [btn_Weibo addTarget:self action:@selector(clickWebo) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn_Weibo];
    
    UILabel *lab_weibo = [[UILabel alloc]initWithFrame:CGRectMake(kw(250), kh(520), kw(30), kh(20))];
    lab_weibo.text = @"微博";
    lab_weibo.font = [UIFont systemFontOfSize:12];
    lab_weibo.textColor = DDTextFieldColor;
    lab_weibo.textAlignment = 1;
    [self.view addSubview:lab_weibo];
    
}

@end
