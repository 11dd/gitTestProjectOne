 
testProject  

不看README可以点击查看项目中的说明文件  

已使用cocoapods导入主流的开源类库;  
算是一个项目的空模板吧,不用重新创建,下载即可使用;   
省去重新创建项目,重新去写每个项目必然存在的一些模块;  
例如登录注册,一些常用的宏,一些常用的工具类等等...   
这样做减少了开发时间    
没有逼格,仅仅是小项目常规的码代码;

(一)常用的第三方库  

*AFNetWorking     --网络请求--                     https://github.com/AFNetworking/AFNetworking  
*MJRefresh        --刷新--                         https://github.com/CoderMJLee/MJRefresh  
*SDWebImage       --图片加载--                     https://github.com/rs/SDWebImage  
*IQKeyBoardManager--用于解决输入框被键盘遮挡的问题-- https://github.com/hackiftekhar/IQKeyboardManager  
*Masonry             --用于布局约束--              https://github.com/SnapKit/Masonry  
*MBProgressHUD    --用于加载的loading和类似Android的toast提示框--     https://github.com/jdg/MBProgressHUD  

(二)我是第二梯队
已添加如下功能:  
--添加轮播  
--(支付工具合集)查看该类,集成苹果支付,支付宝,微信支付,银联支付  
--(分页)查看SegmentPageHead.h可查看使用示例  
--加在程序中,解决NUll问题  
--宏定义单例,使用示例:查看DDSingleData.h与DDSingleData.m 直接创建出单例  

**Helper.h --工具帮助类,将常用方法写在这里方便调用  

(三)常用宏合集提示
请查看:  
http://www.jianshu.com/p/dbd260b3eb8c  

(四)常用方法合集提示,  

1.//显示loading加载中  
[Helper showLoadingWithView:self.view];  
//隐藏loading
[Helper hiddonLoadingWithView:self.view];  

2.//提示语  
[Helper showMessageWithHud:@"我只是提示语" addTo:self yOffset:0];  

3.//解决键盘遮挡住输入框的问题  
[Helper setKeyboardManagerEnable:YES];  

***还有很多扩展类,程序里查看吧

/*请求示例:这里都是使用post请求*/  

    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];  
    [dic setValue:@"" forKey:@"username"];  

    [NetworkTool POSTWithURLString:@"URL" parameters:dic isLoading:self.view success:^(id responseObject) {  

    NSDictionary * dic = responseObject;  

    [self.tempTableView reloadData];  

    [self.tempTableView.mj_header endRefreshing];  
    [self.tempTableView.mj_footer endRefreshing];  

    }  

    } faile:^(NSError *error) {  

     //当出错时统一打印错误信息,无需再此打印报错信息  
    }];  
 

