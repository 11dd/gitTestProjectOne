//
//  AppDelegate.h
//  testProject
//
//  Created by mac3 on 17/2/10.
//  Copyright © 2017年 test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTabbarViewController.h"


//#ifdef DEBUG
////个人

//#else
////公司

//#endif

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (nonatomic, strong) UIWindow *window;
@property (nonatomic, strong) CustomTabbarViewController *tab;


@end

