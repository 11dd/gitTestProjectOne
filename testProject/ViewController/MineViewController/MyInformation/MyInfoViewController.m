//
//  MyInfoViewController.m
//  testProject
//
//  Created by mac3 on 17/2/13.
//  Copyright © 2017年 test. All rights reserved.
//

#import "MyInfoViewController.h"

@interface MyInfoViewController ()

@end

@implementation MyInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = rgba(233, 233, 233, 1);
    [self drawNavWithTitle:@"个人信息"];
    [self drawBackButton];
    
}



@end
