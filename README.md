# gitTestProjectOne

项目名字起的有点low 👎  

大神请绕道,对此你一定嗤之以鼻;  
初学者请绕道,不然你会误入歧途;  
如果你正在一个外包公司入职,欢迎补充;  

该项目想打造的是一个不需学习成本的开发示例;  
导入各种主流的开源框架;不需要你懂什么原理,程序里写出示例类,会用即可;  

下载去看,没用到三方管理工具cocoapods;  
可能你会问:cocoapods安装没难度啊,为什么不用,  
因为很多外包公司都是只用最熟悉的东西,不用最新最好用的东西;  
这时你一定会说,卧槽,外包人员开发的东西真坑;  
外包公司就好比小餐馆,你来吃饭,想花钱少(钱),还想吃的好(需求),  
还想环境干净(代码质量),服务到位(需求随便改);  

这样做减少了开发时间并且对开发人员自身的能力要求不高,只要肯加班就够了;😄  
那自身岂不是没什么提高,  
这就好比重点学校与普通院校,基础设施与师资力量差了很多,就靠自己啦;  

这里算是一个做项目的模板吧;  
由于从北京来到大连工作,在一家外包公司做ios开发;  
不得不为了项目的时间问题,来解决一下每次创建项目需要导入的类库;  
又不需开发人员投入太多学习成本,所以该工程参考,补充,改进了公司里的几个项目;  
没有逼格,无限逼近下线;

尽可能的让开发傻瓜式粘帖复制,写一写简单tableView与简单控件来完成一个项目的开发;  
新项目已开始使用这套东西,这样也许你也想下载看看了,然后了解一下外包公司的技术水平;  
希望得到更多人的意见,虽然外包开发在开发从业者中档次比较低,  
但是如果你的意见对开发效率有所提高,学习成本还低的话(PS这句话是重点,真的,  
难度高的话,可能开发的时候,直接被pass了,毕竟外包从业久了的人员很难改掉习惯的东西,  
至少短期不会),那么欢迎打脸;  

五一之后更新更加适合开发进阶的栗子:  

/*****************(一)常用的第三方库*******************/  

*集成了个推GtSdk  
*AFNetWorking     --网络请求--                     https://github.com/AFNetworking/AFNetworking  
*MJRefresh        --刷新--                         https://github.com/CoderMJLee/MJRefresh  
*MJExtension      --字典模型转换工具--              https://github.com/CoderMJLee/MJExtension  
*SDWebImage       --图片加载--                     https://github.com/rs/SDWebImage  
*MBProgressHUD    --用于加载的loading和提示框--     https://github.com/jdg/MBProgressHUD  
*IQKeyBoardManager--用于解决输入框被键盘遮挡的问题-- https://github.com/hackiftekhar/IQKeyboardManager  
*Masonry             --用于布局约束--              https://github.com/SnapKit/Masonry  

/*****************(二)我是第二梯队*******************/  

*UITableView+FDTemplateLayoutCell      --用于动态计算cell高度(由于你名字太长被第一梯队挤下边来了)  
                                       -- https://github.com/forkingdog/UITableView-FDTemplateLayoutCell  
优化UITableViewCell高度计算的那些事地址  -- http://blog.sunnyxx.com/2015/05/17/cell-height-calculation/  

已添加如下功能:  
--添加轮播  
--(支付工具合集)查看该类,集成苹果支付,支付宝,微信支付,银联支付  
--(分页)查看SegmentPageHead.h可查看使用示例  
--加在程序中,解决NUll问题  
--宏定义单例,使用示例:查看DDSingleData.h与DDSingleData.m 直接创建出单例  

**Helper.h --工具帮助类,将常用方法写在这里方便调用  

/*****************(三)常用宏合集提示*******************/  

*testProject.pch--程序启动  

/*****************(三)(1)*******************/  

1.存放一些全局的宏(整个项目中都用得上的宏)  

**做项目前先查看.pch文件,一些常用宏,无需自己重新再定义一遍  

//*打开或者关闭日志输出功能  
#ifdef DEBUG  
#define DLLog(...) NSLog(__VA_ARGS__)  
#else  
#define DLLog(...)  
#endif  

//解决xcode8打印出一些乱码或者不完整的情况  
#define NSLog(FORMAT, ...) printf("%s\n", [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);  

//获取屏幕宽高  
#define KScreenWidth [UIScreen mainScreen].bounds.size.width  
#define KScreenHeight [UIScreen mainScreen].bounds.size.height  

//适配可能很多人还习惯性的frame比例,但是不要计算的所有的坐标都加上比例真的很丑,看了几个这样的项目    
#define kw(R)               (R) * (KScreenWidth) / 320.0  
#define kh(R)               (R) * (KScreenHeight) / 568.0  

//保存个人信息  
//为NSUserDefaults 添加object和key  
#define Kusersave(object,key) [[NSUserDefaults standardUserDefaults] setObject:object forKey:key]  
//读取NSUserDefaults中key的元素  
#define Kuserread(key) [[NSUserDefaults standardUserDefaults] objectForKey:key]  
//删除NSUserDefaults中key的元素  
#define Kuserdelete(key) [[NSUserDefaults standardUserDefaults] removeObjectForKey:key]  

//沙盒路径  
//获取temp  
#define kPathTemp NSTemporaryDirectory()  
//获取沙盒 Document  
#define kPathDocument [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]  
//获取沙盒 Cache  
#define kPathCache [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]  

/*****判空******/  
//字符串是否为空  
#define kStringIsEmpty(str) ([str isKindOfClass:[NSNull class]] || str == nil || [str length] < 1 ? YES : NO )  

//数组是否为空  
#define kArrayIsEmpty(array) (array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0)  

//字典是否为空  
#define kDictIsEmpty(dic) (dic == nil || [dic isKindOfClass:[NSNull class]] || dic.allKeys == 0)  

//是否是空对象  
#define kObjectIsEmpty(_object) (_object == nil \  
|| [_object isKindOfClass:[NSNull class]] \  
|| ([_object respondsToSelector:@selector(length)] && [(NSData *)_object length] == 0) \  
|| ([_object respondsToSelector:@selector(count)] && [(NSArray *)_object count] == 0))  

/*****************(三)(2)*******************/  

2.用来包含一些全部的头文件(整个项目中都用得上的头文件,在使用以下类的时候不需要导入头文件)  

*HttpDefine--宏定义网络接口  
*ColorDefine--宏定义常用色值  

/*****************(四)常用方法合集提示*******************/  

/*****************(四)(1)*******************/  

1.//显示loading加载中  
[Helper showLoadingWithView:self.view];  
//隐藏loading
[Helper hiddonLoadingWithView:self.view];  

2.//提示语  
[Helper showMessageWithHud:@"我只是提示语" addTo:self yOffset:0];  

3.//解决键盘遮挡住输入框的问题  
[Helper setKeyboardManagerEnable:YES];  

/*****************(四)(2)*******************/  

//以下为类别各功能,全集请查看该git地址:https://github.com/shaojiankui/JKCategories  

1.UIButton+JKImagePosition   -- 用button的titleEdgeInsets和 imageEdgeInsets属性来实现button文字图片上下或者左右排列的  
2.UIView+JKScreenshot        -- 截图方法  
3.NSString+JKNormalRegex     -- 判断手机邮箱身份证等各种证件的有效性  
4.NSString+JKSize            -- 计算宽高  
5.NSString+JKTrims           -- 清除html标签  
6.  
NSDate+JKExtension  
NSDate+JKUtilities           -- 时间处理  

7.UIColor+JKGradient         -- 渐变色  
8.UIDevice+JKHardware        -- 硬件信息  

/*****************(四)(3)*******************/  

/*请求示例:后台PHP,我这里都是使用post请求*/  

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

*/  

