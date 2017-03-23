//
//  AuthcodeView.h
//  Unity-iPhone
//
//  Created by shenchengcai on 15/11/22.
//
//

#import <UIKit/UIKit.h>

@interface AuthcodeView : UIView

@property (nonatomic, strong) NSArray *dataArray;/**< 字符素材数组 */
@property (nonatomic, strong) NSMutableString *authCodeStr;/**< 验证码字符串 */

/**
 *  切换验证码
 */
- (void)changeAuthCode;

@end
