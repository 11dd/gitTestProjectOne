//
//  Helper.m
//  testProject
//
//  Created by mac3 on 17/2/13.
//  Copyright © 2017年 test. All rights reserved.
//

#import "Helper.h"

NSString* const kKeyUserId = @"UserId";
NSString* const kKeyUserName = @"UserName";
NSString* const kKeyUserToken = @"UserToken";

UITabBarController *rootcontroller;

@implementation Helper

+(CGFloat)returnHeight{
    
    CGRect statusBarRect = [[UIApplication sharedApplication] statusBarFrame];
    
    if (statusBarRect.size.height == 40){
        
        return  KScreenHeight - 64 - 20;
    }else{
        return KScreenHeight - 64;
    }
}

+(void)showLoadingWithView:(UIView *)aView
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:aView animated:YES];
    hud.labelText = @"加载中…";
    //hud.color = [UIColor redColor];
    hud.labelFont = [UIFont systemFontOfSize:14.0f];
    
}

+(void)hiddonLoadingWithView:(UIView *)aView
{
    [MBProgressHUD hideAllHUDsForView:aView animated:YES];
}

+ (void)showReturnAlert:(NSString *)alert
{
    [self showMessageWithHud:alert addTo:rootcontroller yOffset:kh(40)];
}

#pragma - mark - 显示提示框

+ (void)showMessageWithHud:(NSString*)message
                     addTo:(UIViewController*)controller
                   yOffset:(CGFloat)yoffset
{
    MBProgressHUD* hud = nil;
    if (controller.view) {
        hud = [MBProgressHUD showHUDAddedTo:controller.view animated:YES];
    }
    hud.yOffset = yoffset;
    //  hud.offset = CGPointMake(0.f, 1000000.f);
    hud.mode = MBProgressHUDModeText;
    hud.detailsLabelText = message;
    hud.margin = 10.f;
    hud.removeFromSuperViewOnHide = YES;
    
    [hud hide:YES afterDelay:1];
}

//解决键盘遮挡住输入框的问题
+ (void)setKeyboardManagerEnable:(BOOL)enable
{
    [[IQKeyboardManager sharedManager] setEnable:enable];
}

+ (BOOL)isKeyboardManagerEnabled
{
    return [[IQKeyboardManager sharedManager] isEnabled];
}


#pragma - mark - 属性字符串

+ (NSMutableAttributedString *)stringToAttributedString:(NSString*)tempStr NSMakeRange:(int)num
{
    //num表示多少位,不是第几位
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:tempStr];
    //颜色
    [attrString addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0,num)];
    [attrString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(num,tempStr.length-num)];
    //字体
    [attrString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:kh(35)] range:NSMakeRange(0,num)];
    [attrString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:kh(25)] range:NSMakeRange(num,tempStr.length-num)];
    
    return attrString;
}

#pragma - mark - 获取当前时间，日期

+ (NSString *)stringToNowDateTime:(NSString *)Str
{
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    if ([Str isEqualToString:@"-"]) {
        [dateFormatter setDateFormat:@"YYYY-MM-dd-HH-mm"];

    }else if ([Str isEqualToString:@":"]){
        [dateFormatter setDateFormat:@"YYYY:MM:dd:HH:mm"];

    }else{
        [dateFormatter setDateFormat:@"YYYYMMddHHmm"];
 
    }
    NSString *nowTime = [dateFormatter stringFromDate:currentDate];

    return nowTime;
}

//比较时间大小
+(NSString *)timeCompareNowTime:(NSString *)time
{
    //当前时间
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYYMMddHHmm"];
    NSString *nowTime = [dateFormatter stringFromDate:currentDate];
    
    //指定时间time去掉:或者- 等间隔符号
    NSString* timeStr = [time stringByReplacingOccurrencesOfString:@":" withString:@""];
    NSString* timeStr1 = [timeStr stringByReplacingOccurrencesOfString:@"-" withString:@""];
    
    long long x = [timeStr1 longLongValue] - [nowTime longLongValue];
    
    NSString * tempStr;
    if (x>0) {
        //当前时间还没有到指定时间time
        tempStr = @"0";
    }else{
        //当前时间超过了指定时间
        tempStr = @"1";
    }
    
    return tempStr;
}

//计算时间差,刚刚,几分钟,几小时,昨天,前天

+(NSString *)CreatedTimeToNowTime:(NSString *)CreatTime
{
    //时间
    NSString *createdTimeStr = @"2017-03-19 21:05:10";
    
    //把字符串转为NSdate
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *timeDate = [dateFormatter dateFromString:createdTimeStr];
    
    //得到与当前时间差
    NSTimeInterval timeInterval = [timeDate timeIntervalSinceNow];
    timeInterval = -timeInterval;
    
    long temp = 0;
    
    NSString *result;
    
    if (timeInterval < 60) {
        result = [NSString stringWithFormat:@"刚刚"];
        
    }else if((temp = timeInterval/60) < 60){
        result = [NSString stringWithFormat:@"%ld分钟前",temp];
        
    }else if((temp = timeInterval/3600) > 1 && (temp = timeInterval/3600) <24){
        result = [NSString stringWithFormat:@"%ld小时前",temp];
        
    }else if ((temp = timeInterval/3600) > 24 && (temp = timeInterval/3600) < 48){
        result = [NSString stringWithFormat:@"昨天"];
        
    }else if ((temp = timeInterval/3600) > 48 && (temp = timeInterval/3600) < 72){
        result = [NSString stringWithFormat:@"前天"];
        
    }else{
        result = createdTimeStr;//返回具体时间日期
        
    }
    
    NSLog(@"%@",result);

    return result;
}


#pragma - mark - 示例,字符串操作

+(NSString *)stringToString:(NSString*)tempStr
{
    
    //-substringToIndex: 从字符串的开头一直截取到指定的位置，但不包括该位置的字符
//    NSString *string1 = @"This is a string";
//    NSString *string2 = [string1 substringToIndex:3];
//    NSLog(@"string2:%@",string2);
    
/***********************************/
   
    //-substringFromIndex: 以指定位置开始（包括指定位置的字符），并包括之后的全部字符
//    NSString *string1 = @"This is a string";
//    NSString *string2 = [string1 substringFromIndex:3];
//    NSLog(@"string2:%@",string2);
    
/***********************************/
    
    //-substringWithRange: //按照所给出的位置，长度，任意地从字符串中截取子串
//    NSString *string1 = @"This is a string";
//    NSString *string2 = [string1 substringWithRange:NSMakeRange(0, 4)];
//    NSLog(@"string2:%@",string2);
    
/***********************************/

    //替换字符串中字符
//    NSString* tempstr4 = [tempstr3 stringByReplacingOccurrencesOfString:@":" withString:@""];
//    NSString* tempstr5 = [tempstr4 stringByReplacingOccurrencesOfString:@" " withString:@""];
//    NSString* tempstr6 = [tempstr5 stringByReplacingOccurrencesOfString:@"/" withString:@""];

/***********************************/
    
    //将字符串分隔成数组
//    NSString* str = @"one,two,three,four,five";
//    //分割字符创为数组，下例以“，”分割
//    NSArray* array = [str componentsSeparatedByString:@","];
//    for(NSString* obj in array)
//    {
//        NSLog(@"%@", obj);
//    }
//    
//    //链接字符串,下例以空格连接
//    str = [array componentsJoinedByString:@" "];
//    NSLog(@"%@", str);
    
    
    return tempStr;
}

#pragma - mark - 示例,数组操作

+ (NSMutableArray *)arrayToArray:(NSMutableArray*)tempArr
{
    
    /***********************************/

    //遍历方法:快速枚举
//    for(NSString* obj in tempArr)
//    {
//        NSLog(@"%@", obj);
//    }
    
    /***********************************/
    //插入索引为几的位置
//    [tempArr insertObject:@"two" atIndex:1];
    
    //修改数组中得内容
//    [tempArr replaceObjectAtIndex:2 withObject:@"aaa"];
    
    //交换数组中得内容
//    [tempArr exchangeObjectAtIndex:1 withObjectAtIndex:3];
    
    // 获取数组的正序迭代器
//    NSEnumerator *enu1 = [tempArr objectEnumerator];
    
    // 获取数组的反序迭代器
//    NSEnumerator *enu2 = [tempArr reverseObjectEnumerator];
    
    //取出连续范围的元素作为子集内容
//    NSArray *sub1 = [tempArr subarrayWithRange:NSMakeRange(1, 3)];
    
    
    return tempArr;
}

//是否登录
+ (BOOL)isUserLogined {
    
    NSString* userId = [self fetchUserId];
    if (userId && ![@"0" isEqualToString:userId]&&![@"" isEqualToString:userId]) {
        return YES;
    }
    return NO;
}

#pragma - mark - id

+ (NSString*)fetchUserId {
    NSString* userId = @"";
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    if ([userDefaults stringForKey:kKeyUserId]) {
        userId = [userDefaults stringForKey:kKeyUserId];
    }
    return userId;
}

+ (void)saveUserId:(NSString*)userId {
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setValue:userId forKey:kKeyUserId];
    [userDefaults synchronize];
}


//存储用户姓名
+ (void)saveUserName:(NSString*)userName {
    
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setValue:userName forKey:kKeyUserName];
    [userDefaults synchronize];
}

//获取用户姓名
+ (NSString*)fetchUserName {
    
    NSString* userId = @"";
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    if ([userDefaults stringForKey:kKeyUserName]) {
        userId = [userDefaults stringForKey:kKeyUserName];
    }
    return userId;
}

//存储用户Token
+ (void)saveUserToken:(NSString*)userToken {
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setValue:userToken forKey:kKeyUserToken];
    [userDefaults synchronize];
}

//获取用户Token
+ (NSString*)fetchUserToken {
    
    NSString *userToken = nil;
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if ([userDefaults objectForKey:kKeyUserToken]) {
        userToken = [userDefaults objectForKey:kKeyUserToken];
    }
    return userToken;
}


////设置显示容器方法
//+ (void)saveRootController:(UINavigationController *)controller {
//    rootcontroller = controller;
//}
//
//+ (UINavigationController *)fetchRootController {
//    return rootcontroller;
//}


+ (void)saveRootController:(UITabBarController *)controller
{
    rootcontroller = controller;
}

+ (UITabBarController *)fetchRootController
{
    return rootcontroller;
}


#pragma mark 判空

+ (BOOL) isBlankString:(NSString *)string
{
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}


#pragma mark 正则判断快递单号

+ (BOOL) validateEMSnumber: (NSString *)EMSnumber
{
    BOOL flag;
    if (EMSnumber.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString * reg = @"^[0-9a-zA-Z]{10,}$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",reg];
    return [identityCardPredicate evaluateWithObject:EMSnumber];
}


#pragma mark 正则简单判断银行卡号是否正确(16-19位数字)

+ (BOOL)validateBankCardNumber:(NSString *)textString
{
    NSString* number=@"^([0-9]{16}|[0-9]{19})$";
    NSPredicate *numberPre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",number];
    return [numberPre evaluateWithObject:textString];
}


#pragma mark  正则判断手机号是否正确
+ (BOOL)validatephoneNumber:(NSString *) textString
{
    NSString* number=@"^1[3|4|5|7|8][0-9]\\d{8}$";
    NSPredicate *numberPre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",number];
    return [numberPre evaluateWithObject:textString];
}



#pragma mark 邮箱格式验证
+(BOOL)verifyemail:(NSString * )str
{
    NSString *regex = @"^[\\w!#$%&'*+/=?^_`{|}~-]+(?:\\.[\\w!#$%&'*+/=?^_`{|}~-]+)*@(?:[\\w](?:[\\w-]*[\\w])?\\.)+[\\w](?:[\\w-]*[\\w])?";
    // 创建谓词对象并设定条件的表达式
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:str];
}


#pragma mark 身份证格式验证

+(BOOL)verifyIDCardNumber:(NSString *)value
{
    value = [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([value length] != 18) {
        return NO;
    }
    NSString *mmdd = @"(((0[13578]|1[02])(0[1-9]|[12][0-9]|3[01]))|((0[469]|11)(0[1-9]|[12][0-9]|30))|(02(0[1-9]|[1][0-9]|2[0-8])))";
    NSString *leapMmdd = @"0229";
    NSString *year = @"(19|20)[0-9]{2}";
    NSString *leapYear = @"(19|20)(0[48]|[2468][048]|[13579][26])";
    NSString *yearMmdd = [NSString stringWithFormat:@"%@%@", year, mmdd];
    NSString *leapyearMmdd = [NSString stringWithFormat:@"%@%@", leapYear, leapMmdd];
    NSString *yyyyMmdd = [NSString stringWithFormat:@"((%@)|(%@)|(%@))", yearMmdd, leapyearMmdd, @"20000229"];
    NSString *area = @"(1[1-5]|2[1-3]|3[1-7]|4[1-6]|5[0-4]|6[1-5]|82|[7-9]1)[0-9]{4}";
    NSString *regex = [NSString stringWithFormat:@"%@%@%@", area, yyyyMmdd  , @"[0-9]{3}[0-9Xx]"];
    NSPredicate *regexTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if (![regexTest evaluateWithObject:value]) {
        return NO;
    }
    int summary = ([value substringWithRange:NSMakeRange(0,1)].intValue + [value substringWithRange:NSMakeRange(10,1)].intValue) *7
    + ([value substringWithRange:NSMakeRange(1,1)].intValue + [value substringWithRange:NSMakeRange(11,1)].intValue) *9
    + ([value substringWithRange:NSMakeRange(2,1)].intValue + [value substringWithRange:NSMakeRange(12,1)].intValue) *10
    + ([value substringWithRange:NSMakeRange(3,1)].intValue + [value substringWithRange:NSMakeRange(13,1)].intValue) *5
    + ([value substringWithRange:NSMakeRange(4,1)].intValue + [value substringWithRange:NSMakeRange(14,1)].intValue) *8
    + ([value substringWithRange:NSMakeRange(5,1)].intValue + [value substringWithRange:NSMakeRange(15,1)].intValue) *4
    + ([value substringWithRange:NSMakeRange(6,1)].intValue + [value substringWithRange:NSMakeRange(16,1)].intValue) *2
    + [value substringWithRange:NSMakeRange(7,1)].intValue *1 + [value substringWithRange:NSMakeRange(8,1)].intValue *6
    + [value substringWithRange:NSMakeRange(9,1)].intValue *3;
    NSInteger remainder = summary % 11;
    NSString *checkBit = @"";
    NSString *checkString = @"10X98765432";
    checkBit = [checkString substringWithRange:NSMakeRange(remainder,1)];// 判断校验位
    return [checkBit isEqualToString:[[value substringWithRange:NSMakeRange(17,1)] uppercaseString]];
}


//上传图片文件
#pragma makr -- 上传图片到服务器

static NSString * const FORM_FLE_INPUT = @"file";//字段名  根据接口命名

+(void)postRequestWithURL: (NSString *)url picFileName: (NSString *)picFileName dataimage:(UIImage *)image andBlock:(void(^)(NSDictionary *retDic,NSError *error))block
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
    //判断图片是不是png格式的文件
    //    if (UIImagePNGRepresentation(image)) {
    //返回为png图像。
    //           data = UIImagePNGRepresentation(image,0.01);
    //        }else {
    //            //返回为JPEG图像。
    data = UIImageJPEGRepresentation(image, 0.01);
    //        }
    //http body的字符串
    
    NSMutableString *body=[[NSMutableString alloc]init];
    
    //参数的集合的所有key的集合
    //NSArray *keys= [postParems allKeys];
    //NSArray *keys = @[@"imgfile",@"userid"];
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
            NSMutableDictionary * dic=KcreateMuDic;
            
            [dic setObject:[Helper fetchUserId] forKey:@"userId"];
            
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
    //设置HTTPHeader
    [request setValue:content forHTTPHeaderField:@"Content-Type"];
    //设置Content-Length
    [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[myRequestData length]] forHTTPHeaderField:@"Content-Length"];
    //设置http body
    [request setHTTPBody:myRequestData];
    //http method
    [request setHTTPMethod:@"POST"];
    //  [Utils showLoding:self.view];
    [NSURLConnection sendAsynchronousRequest:request  queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        //  [Utils hideLoding:self.view];
        if (data) {
            NSLog(@"response_%@",[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);
            NSDictionary* json = [NSJSONSerialization
                                  JSONObjectWithData:data
                                  options:kNilOptions
                                  error:&connectionError];
            NSLog(@"%@",json);
            block(json,nil);
            
        }else{
            block(nil,connectionError);
        }
        
    }];
}
@end


#pragma mark ---自定义UIButton

@implementation UIButton (custom)

-(void)settitlebuttomandImagetop
{
    [self setTitleEdgeInsets:UIEdgeInsetsMake(self.imageView.frame.size.height+kh(5) ,-self.imageView.frame.size.width, 0.0,0.0)];//文字距离上边框的距离增加imageView的高度，距离左边框减少imageView的宽度，距离下边框和右边框距离不变
    [self setImageEdgeInsets:UIEdgeInsetsMake(-(self.titleLabel.bounds.size.height+kh(5)),(self.frame.size.width-self.imageView.bounds.size.width)/2.0,0.0,(self.frame.size.width-self.imageView.bounds.size.width)/2.0)];
}

- (void)setTextSize:(CGFloat)size
{
    [[self titleLabel] setFont:[UIFont systemFontOfSize:size]];
}

- (void)setText:(NSString*)text
{
    [self setTitle:text forState:UIControlStateNormal];
}

- (void)setTextColor:(UIColor*)color
{
    [self setTitleColor:color  forState:UIControlStateNormal];
}

- (void)setImgv:(NSString *)imgvstr
{
    [self setImage:[UIImage imageNamed:imgvstr]  forState:UIControlStateNormal];
}

- (void)addClick:(id)target selector:(SEL)selector
{
    [self addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
}


@end
