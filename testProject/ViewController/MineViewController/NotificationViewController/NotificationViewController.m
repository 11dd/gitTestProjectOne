//
//  NotificationViewController.m
//  testProject
//
//  Created by mac3 on 17/2/13.
//  Copyright © 2017年 test. All rights reserved.
//

#import "NotificationViewController.h"
#import "AppDelegate.h"

@interface NotificationViewController ()

@end

@implementation NotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = rgba(233, 233, 233, 1);
    [self drawNavWithTitle:@"消息中心"];
    [self drawBackButton];

}




@end
