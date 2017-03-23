//
//  GestureLockViewController.h
//  HuiliCai
//
//  Created by shenchengcai on 16/4/1.
//  Copyright © 2016年 ruijin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GestureLockViewController : UIViewController

@property (nonatomic, strong) NSString *source_id;/**< 跳转场景：1、注册成功-设置手势密码 2、注册成功-确认手势密码 3、登录验证 4、唤醒操作 5、修改手势密码 6、设置手势密码 */
@property (nonatomic, strong) NSString *firstTimeSetupPassword;
@property (nonatomic, strong) NSString *phone_text;/**< 手机号 */
@property (nonatomic, strong) NSString *pass_text;/**< 密码 */


@end
