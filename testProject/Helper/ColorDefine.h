//
//  ColorDefine.h
//  HitPool
//
//  Created by jyzml_success on 16/5/10.
//  Copyright © 2016年 . All rights reserved.
//

#define ColorDefine_h

/** 定义颜色值 */
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define rgba(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

#define KNavColor   [UIColor colorWithRed:0/255 green:155.0/255 blue:250.0/255 alpha:1]

/** 登录注册按钮色值 */
#define DDLoginColor            UIColorFromRGB(0x56d277)

/** 登录注册文字色值 */
#define DDTextFieldColor        UIColorFromRGB(0x3e3e3e)

/** "第三方登录"字体颜色 */
#define DDOtherLoginColor       UIColorFromRGB(0xf0eff5)

/** 灰色字体颜色 */
#define DDCommonFontColor       UIColorFromRGB(0x7f7f7f)


#define DDColor [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0]

#define TEXTCOLOR [UIColor colorWithRed:140/255.0 green:140/255.0 blue:140/255.0 alpha:1]




























