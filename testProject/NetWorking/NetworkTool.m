//
//  NetworkTool.m
//  testProject
//
//  Created by mac3 on 17/3/13.
//  Copyright © 2017年 test. All rights reserved.
//

#import "NetworkTool.h"
#import "AFNetworking.h"

@implementation NetworkTool

+ (instancetype)sharedNetworkTool
{
    static NetworkTool *instance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        // 设置相对路径
        NSURL *BaseURL = [NSURL URLWithString:@""];
        // 实例化Manager
        instance = [[self alloc] initWithBaseURL:BaseURL];
        
        // 增加AFN支持的文件类型
        instance.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain", nil];
    });
    
    return instance;
}


//网络请求方法
+ (void)POSTWithURLString:(NSString *)URLString parameters:(NSMutableDictionary *)parameters isLoading:(UIView*)loadView
                  success:(void(^)(id responseObject))success faile:(void(^)(NSError *error))failure
{

    if (loadView == nil) {
    }else{
        [Helper showLoadingWithView:loadView];
    }
    //大P为key,由接口决定,也有可能不需要该三行代码
    NSString *JsonStr = parameters.mj_JSONString;//转json字符串
    
    //    NSData *data = [NSJSONSerialization dataWithJSONObject:parameters options:NSJSONWritingPrettyPrinted error:nil];
    //    NSString *JsonStr=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    
    NSMutableDictionary *parameterDic = [[NSMutableDictionary alloc]init];
    [parameterDic setObject:JsonStr forKey:@"P"];
    
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    sessionManager.requestSerializer.timeoutInterval = 10.f;
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [sessionManager POST:URLString parameters:parameterDic progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (loadView == nil) {
        }else{
            [Helper hiddonLoadingWithView:loadView];
        }
        
        success(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (loadView == nil) {
        }else{
            [Helper hiddonLoadingWithView:loadView];
        }
        
        failure(error);
        NSLog((@"该接口返回错误==%@\n参数是==%@\n错误是==%@\n"),URLString,parameters,error);
        
    }];

}

#pragma - mark - 以下方法都没有使用,仅供学习参考
//加载网页数据时
- (void)loadData
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    //修改AFN支持接收的文本类型 : text/html
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    
    //修改AFN默认的返回的数据类型,设置默认为只返回原始的二进制数据,程序猿自己解析
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    // 网络请求地址
    NSString *URLStr = @"http://www.baidu.com";
    
    // 发送网络请求
    [manager GET:URLStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //NSLog(@"%@ %@",[responseObject class],responseObject);
        
        NSString *html = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"%@",html);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"出错 %@",error);
    }];
}

//向服务器发送JSON数据时

- (void)postJSON
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    //修改AFN支持接收的文本类型 : text/plian
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain", nil];
    
    //修改AFN默认的返回的数据类型,设置默认为只返回原始的二进制数据,程序猿自己解析
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    //修改AFN支持向服务器发送JSON形式的二进制数据
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    // 网络请求地址
    NSString *URLStr = @"http://localhost/php/upload/postjson.php";
    
    // 请求参数
    NSDictionary *parameters = @{
                                 @"name":@"zhangsan"
                                 };
    
    // 发送网络请求
    [manager POST:URLStr parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //NSLog(@"%@ %@",[responseObject class],responseObject);
        
        NSString *html = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"%@",html);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"出错 %@",error);
    }];
}
/*
 
 文件数据拼接的方法
 [formData appendPartWithFileData:data name:@"" fileName:@"" mimeType:@""];
 
 文件数据拼接的四个参数
 参数1：上传文件的二进制信息
 参数2：服务器接收二进制数据的字段名（跟服务器要）
 参数3：文件保存到服务器的名字
 参数4：上传的文件的类型
 
 文件上传的主方法

 */

//文件上传的主方法
- (void)uploadFile
{
    // 网络请求地址
    NSString *URLStr = @"http://xxxx/php/upload/upload-m.php";
    
    // 文件上传的附带信息
    NSDictionary *textDict = @{
                               @"status":@"zhangsan"
                               };
    
    // 网络请求manager
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 发送POST请求
    [manager POST:URLStr parameters:textDict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        // 获取文件路径1
        NSString *filePath1 = [[NSBundle mainBundle] pathForResource:@"mm01.jpg" ofType:nil];
        NSData *fileData1 = [NSData dataWithContentsOfFile:filePath1];
        // 拼接数据1
        [formData appendPartWithFileData:fileData1 name:@"userfile[]" fileName:[filePath1 lastPathComponent] mimeType:@"image/jpg"];
        
        // 获取文件路径2
        NSString *filePath2 = [[NSBundle mainBundle] pathForResource:@"mm02.jpg" ofType:nil];
        NSData *fileData2 = [NSData dataWithContentsOfFile:filePath2];
        // 拼接数据2
        [formData appendPartWithFileData:fileData2 name:@"userfile[]" fileName:[filePath2 lastPathComponent] mimeType:@"image/jpg"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        NSLog(@"进度 %f",uploadProgress.fractionCompleted);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"%@ %@",[responseObject class],responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"出错 %@",error);
    }];
}

//文件下载
- (void)downloadFile
{
    // 下载地址
    NSString *URLString = @"http://xxxx/xcode.zip";
    // 请求
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:URLString]];
    // 管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 发起下载任务
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        
        NSLog(@"进度 %f",downloadProgress.fractionCompleted);
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        // AFN提供的文件保存路径,在tmp文件中,下载完成之后就会被删除
        NSLog(@"%@",targetPath);
        
        // 自己获取文件保存的路径
        NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:response.suggestedFilename];
        
        // 带file:// 协议头
        NSURL *locationURL = [NSURL fileURLWithPath:filePath];
        
        // 把文件缓存路径剪切出去
        return locationURL;
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        // 文件最终保存的路径 : 从上面自动剪切过来的
        NSLog(@"%@",filePath.path);
    }];
    // 开启下载任务
    [downloadTask resume];
}

//AFN之HTTPS
-(void)AFN_HTPPS
{
    // 创建网络请求mansger
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    // 允许无效的证书
    // manager.securityPolicy.allowInvalidCertificates = YES;
    // 不验证域名
    manager.securityPolicy.validatesDomainName = NO;
    
    // 修改AFN默认支持接收的文本类型
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html" ,nil];
    
    // 修改AFN默认处理数据的方式 : 设置成只返回原始的二进制数据,程序猿自己反序列化
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    // 网络请求地址
    NSString *URLStr = @"https://www.baidu.com";
    
    [manager GET:URLStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        // NSLog(@"%@ %@",[responseObject class],responseObject);
        
        // 反序列化
        NSString *html = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"%@",html);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"出错 %@",error);
    }];
}


@end
