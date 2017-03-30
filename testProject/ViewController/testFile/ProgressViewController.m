//
//  ProgressViewController.m
//  testProject
//
//  Created by mac3 on 17/3/23.
//  Copyright © 2017年 test. All rights reserved.
//

#import "ProgressViewController.h"
#import "LDProgressBar.h"

@interface ProgressViewController ()
@property (nonatomic, strong) LDProgressBar *progressView; //环形进度条

@end

@implementation ProgressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor purpleColor];
    [self drawNavWithTitle:@"测试环形进度"];
    [self drawBackButton];
    
    [self.view addSubview:self.progressView];

}

#pragma - mark - 环行进度条

-(LDProgressBar*)progressView
{
    if (!_progressView) {
        
        _progressView = [[LDProgressBar alloc]initWithFrame:CGRectMake((KScreenWidth- 200)/2,100, 200, 200)];
        _progressView.backgroundColor = [UIColor clearColor];
        //_progressView.num = 80;
        
    }
    
    return _progressView;
    
}


@end
