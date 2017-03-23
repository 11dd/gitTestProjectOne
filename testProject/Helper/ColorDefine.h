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

//白色
#define kwhitecolor         [UIColor whiteColor]
//黑色
#define kblackcolor         [UIColor blackColor]
//清色透明
#define kclearcolor         [UIColor clearColor]

#define kBackGroundColor    [UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1]

#define kViewBackGroundColor    [UIColor colorWithRed:238/255.0 green:239/255.0 blue:240/255.0 alpha:1]

#define kViewBianGroundColor    [UIColor colorWithRed:197/255.0 green:197/255.0 blue:197/255.0 alpha:1]

#define kblueColor         [UIColor colorWithRed:60/255.0 green:178/255.0 blue:252/255.0 alpha:1]

#define ktextColor         [UIColor colorWithRed:88/255.0 green:88/255.0 blue:88/255.0 alpha:1]

#define ktextColor1         [UIColor colorWithRed:165/255.0 green:166/255.0 blue:167/255.0 alpha:1]

#define ktextColor2         [UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1]

#define kyellowColor        [UIColor colorWithRed:246/255.0 green:195/255.0 blue:15/255.0 alpha:1]

#define kshenheiColor        [UIColor colorWithRed:30/255.0 green:0/255.0 blue:0/255.0 alpha:1]

#define kredColor           [UIColor colorWithRed:233/255.0 green:61/255.0 blue:15/255.0 alpha:1]

#define kblackqianColor          [UIColor colorWithRed:72/255.0 green:73/255.0 blue:74/255.0 alpha:1]

#define kredcolor          [UIColor colorWithRed:219/255.0 green:0/255.0 blue:62/255.0 alpha:1]

#define klansecolor              [UIColor colorWithRed:27/255.0 green:50/255.0 blue:139/255.0 alpha:1.0]

#define kgreencolor           [UIColor colorWithRed:81/255.0 green:124/255.0 blue:12/255.0 alpha:1.0]

#define kyuanback           [UIColor colorWithRed:195/255.0 green:196/255.0 blue:197/255.0 alpha:1.0]













