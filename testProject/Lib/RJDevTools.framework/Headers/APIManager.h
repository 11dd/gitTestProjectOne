//
//  APIManager.h
//  RWUIControls
//
//  Created by shenchengcai on 15/3/3.
//  Copyright (c) 2015年 QM. All rights reserved.
//

/*******************************************************
 类名：APIManager.h
 功能描述：接口处理类，实现从接口请求数据的方法
 
 */

#import <UIKit/UIKit.h>
@class AFHTTPRequestOperation;

@interface APIManager : NSObject

+ (id)sharedInstance;
+ (id)loginInstance;

- (id) cachedContent:(NSString *)key;
- (void) setCachedContent:(id)content withKey:(NSString *)key;

//设置IP
+(void)sheZhiIP:(NSString *)IPString;
//设置加密解密key
+(void)sheZhiKey:(NSString *)keyString;
//设置加密解密key－小明，默认值q0m3sd8l
+(void)sheZhiKey2:(NSString *)keyString;
//获取加密解密key
+(NSString *)getKeyString;
//获取加密解密key－小明
+(NSString *)getKeyString2;


/**3DES加密解密 */
/**字符串加密 */
+(NSString *)doEncryptStr:(NSString *)originalStr;
/**字符串解密 */
+(NSString*)doDecEncryptStr:(NSString *)encryptStr;


+ (APIManager *)httpsInstance;
//http或https请求方法
- (void)httporsPost:(NSString *)path
       parameters:(NSDictionary *)parameters
          success:(void (^)(NSData *data))success
          failure:(void (^)(NSError *error))failure;

//请求方法。向接口请求数据，并接收返回值。path方法路径；parameters参数；success请求成功时处理方法；failure请求失败时处理方法
- (void)getPath:(NSString *)path
     parameters:(NSDictionary *)parameters
        success:(void (^)(NSURLSessionDataTask *dataTask, id responseObject))success
        failure:(void (^)(NSURLSessionDataTask *dataTask, NSError *error))failure;

//请求方法。向接口请求数据，并接收返回值。path方法路径；parameters参数；success请求成功时处理方法；failure请求失败时处理方法
//- (void)getPath:(NSString *)path
//      parameters:(NSDictionary *)parameters
//         success:(void (^)(NSURLSessionDataTask *dataTask, id responseObject))success
//         failure:(void (^)(NSURLSessionDataTask *dataTask, NSError *error))failure;

//请求方法。向接口请求数据，并接收返回值。path方法路径；parameters参数；success请求成功时处理方法；failure请求失败时处理方法
- (void)postPath:(NSString *)path
      parameters:(NSDictionary *)parameters
         success:(void (^)(NSURLSessionDataTask *dataTask, id responseObject))success
         failure:(void (^)(NSURLSessionDataTask *dataTask, NSError *error))failure;

//请求方法。向接口请求数据，并接收返回值。path方法路径；parameters参数；dataDic需上传的数据；dataType数据类型；success请求成功时处理方法；failure请求失败时处理方法
- (void)postPath:(NSString *)path
      parameters:(NSDictionary *)parameters
         dataDic:(NSDictionary *)dataDic
        dataType:(NSString *)dataType
         success:(void (^)(NSURLSessionUploadTask *uploadTask, id responseObject))success
         failure:(void (^)(NSURLSessionUploadTask *uploadTask, NSError *error))failure;

//获取加密字符串；paramsDic参数字典
+ (NSString *)encryptionJsonEncodeStringFrom:(NSDictionary *)paramsDic;

//解密字符串为字典；string待解密的字符串
+ (NSDictionary *)getDecodeDictionaryFrom:(NSString *)string;

//请求方法。加密向接口请求数据，并接收返回值。path方法路径；parameters参数；success请求成功时处理方法；failure请求失败时处理方法
- (void)EncryptionpostPath:(NSString *)path
                parameters:(NSDictionary *)parameters
                   success:(void (^)(NSURLSessionDataTask *dataTask, id responseObject))successEnc
                   failure:(void (^)(NSURLSessionDataTask *dataTask, NSError *error))failureEnc;

//请求方法。加密向接口请求数据，并接收返回值。path方法路径；parameters参数；success请求成功时处理方法；failure请求失败时处理方法
- (void)EncryptionpostPath:(NSString *)path
                parameters:(NSDictionary *)parameters
                 urlEncode:(BOOL)urlEncode
                   success:(void (^)(NSURLSessionDataTask *dataTask, id responseObject))successEnc
                   failure:(void (^)(NSURLSessionDataTask *dataTask, NSError *error))failureEnc;

- (void)xinfangPostPath:(NSString *)path
             parameters:(NSDictionary *)parameters
                success:(void (^)(NSURLSessionDataTask *dataTask, id responseObject))successEnc
                failure:(void (^)(NSURLSessionDataTask *dataTask, NSError *error))failureEnc;

/**
 *  3DES加密请求
 *
 *  @param path       网址
 *  @param parameters 需要加密的body
 *  @param successEnc 解密后的返回值
 *  @param failureEnc 请求失败返回值
 */
- (void)Encryption3DESPostPath:(NSString *)path
                    parameters:(NSDictionary *)parameters
                       success:(void (^)(NSURLSessionDataTask *dataTask, id responseObject))successEnc
                       failure:(void (^)(NSURLSessionDataTask *dataTask, NSError *error))failureEnc;

- (void)Encryption3DESPostPath:(NSString *)path
                    parameters:(NSDictionary *)parameters
                       dataDic:(NSDictionary *)dataDic
                      dataType:(NSString *)dataType
                       success:(void (^)(NSURLSessionUploadTask *uploadTask, id responseObject))success
                       failure:(void (^)(NSURLSessionUploadTask *uploadTask, NSError *error))failure;


//请求方法。加密向接口请求数据，并返回未解密的数据。path方法路径；parameters参数；success请求成功时处理方法；failure请求失败时处理方法
- (void)EncryptionpostPath2:(NSString *)path
                 parameters:(NSDictionary *)parameters
                    success:(void (^)(NSURLSessionDataTask *dataTask, id responseObject))successEnc
                    failure:(void (^)(NSURLSessionDataTask *dataTask, NSError *error))failureEnc;

- (void)webServicePostMethod:(NSString *)method
                  parameters:(NSDictionary *)parameters
                     success:(void (^)(id responseObject))success
                     failure:(void (^)(NSError *error))failure;

/**
 *  调试webService接口的方法
 *
 *  @param method     请求的方法路径
 *  @param parameters 参数字典
 *  @param success    成功block
 *  @param failure    失败block
 */
- (void)webServicePostMethod2:(NSString *)method
                   parameters:(NSDictionary *)parameters
                      success:(void (^)(id responseObject))success
                      failure:(void (^)(NSError *error))failure;

/**
 *  @brief  下载文件
 *
 *  @param requestURL 文件地址
 *  @param savedPath  保存 在磁盘的位置
 *  @param success    下载成功回调
 *  @param failure    下载失败回调
 *  @param progress   实时下载进度回调
 */
- (void)downloadFileWithInferface:(NSString*)requestURL
                        savedPath:(NSString*)savedPath
                  downloadSuccess:(void (^)(NSURLSessionDownloadTask *downloadTask, id responseObject))success
                  downloadFailure:(void (^)(NSURLSessionDownloadTask *downloadTask, NSError *error))failure
                         progress:(void (^)(NSProgress *downloadProgress))progress;

/**
 *  @brief  下载文件
 *
 *  @param requestURL 文件地址
 *  @param savedPath  保存 在磁盘的位置
 *  @param success    下载成功回调
 *  @param failure    下载失败回调
 *  @param progress   实时下载进度回调
 */
//- (void)downloadFileWithUrl:(NSString*)requestURL
//                  savedPath:(NSString*)savedPath
//            downloadSuccess:(void (^)(NSURLSessionDataTask *dataTask, id responseObject))success
//            downloadFailure:(void (^)(NSURLSessionDataTask *dataTask, NSError *error))failure
//                   progress:(void (^)(float progress))progress;

@end
