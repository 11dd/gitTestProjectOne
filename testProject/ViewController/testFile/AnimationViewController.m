//
//  AnimationViewController.m
//  testProject
//
//  Created by mac3 on 17/3/23.
//  Copyright © 2017年 test. All rights reserved.
//

#import "AnimationViewController.h"

@interface AnimationViewController ()
@property (nonatomic , strong) UIView *demoView;
@property (nonatomic , strong) UIView *demoView1;

@property (nonatomic , strong) UIButton* editButton;
@end

@implementation AnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self drawNavWithTitle:@"测试动画效果"];
    [self drawBackButton];
    
    [self.view addSubview:self.editButton];
    [self.view addSubview:self.demoView];
    
    [self.view addSubview:self.demoView1];
    
    float centerX = self.view.bounds.size.width/2;
    float centerY = self.view.bounds.size.height/2;
    float x = self.view.bounds.size.width/2;
    float y = self.view.bounds.size.height;
    
    x = x - centerX; //计算(x,y)从(0,0)为原点的坐标系变换到(CenterX ，CenterY)为原点的坐标系下的坐标
    y = y - centerY; //(0，0)坐标系的右横轴、下竖轴是正轴,(CenterX,CenterY)坐标系的正轴也一样
    
    CGAffineTransform  trans = CGAffineTransformMakeTranslation(x, y);
    
    trans = CGAffineTransformRotate(trans,90.0/180.0*M_PI);
    
    trans = CGAffineTransformTranslate(trans,-x, -y);
    
    _demoView1.transform = CGAffineTransformIdentity;
    
    _demoView1.transform = trans;
        
        
  


}

-(UIButton *)editButton
{
    if (!_editButton) {
        
        _editButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _editButton.frame = CGRectMake(KScreenWidth - kw(44), 30, kw(44), kh(34));
        _editButton.backgroundColor = [UIColor lightGrayColor];
        [_editButton setTitle:@"点我" forState:UIControlStateNormal];
        [_editButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        
        [_editButton addTarget:self action:@selector(rotateAnimation) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _editButton;
}

- (UIView *)demoView{
    if (!_demoView) {
        _demoView = ({
            UIView *demoView = [[UIView alloc] initWithFrame:({
                CGRect rect = CGRectMake(0, 64,KScreenWidth ,KScreenHeight/2-32);
                rect;
            })];
            demoView.backgroundColor = [UIColor redColor];
            demoView;
        });
    }
    return _demoView;
}

- (UIView *)demoView1{
    if (!_demoView1) {
        _demoView1 = ({
            UIView *demoView1 = [[UIView alloc] initWithFrame:({
                CGRect rect = CGRectMake(0, 64,KScreenWidth ,KScreenHeight/2-32);
                rect;
            })];
            demoView1.backgroundColor = [UIColor blueColor];
            demoView1;
        });
    }
    return _demoView1;
}


-(void)rotateAnimation{
    
    float centerX = self.view.bounds.size.width/2;
    float centerY = self.view.bounds.size.height/2;
    float x = self.view.bounds.size.width/2;
    float y = self.view.bounds.size.height;
    

    x = x - centerX; //计算(x,y)从(0,0)为原点的坐标系变换到(CenterX ，CenterY)为原点的坐标系下的坐标
    y = y - centerY; //(0，0)坐标系的右横轴、下竖轴是正轴,(CenterX,CenterY)坐标系的正轴也一样
    
    [UIView animateWithDuration:5.0f animations:^{
        
        CGAffineTransform  trans = CGAffineTransformMakeTranslation(x, y);
        
        trans = CGAffineTransformRotate(trans,190.0/180.0*M_PI);
        
        trans = CGAffineTransformTranslate(trans,-x, -y);
        
        _demoView.transform = CGAffineTransformIdentity;
        
        _demoView.transform = trans;
        
        
    }];

    
    [UIView animateWithDuration:10.0f animations:^{
       
        CGAffineTransform  trans = CGAffineTransformMakeTranslation(x, y);
        
        trans = CGAffineTransformRotate(trans,90.0/180.0*M_PI);
        
        trans = CGAffineTransformTranslate(trans,-x, -y);
        
        _demoView1.transform = CGAffineTransformIdentity;
        
        _demoView1.transform = trans;

    
    }];
}

@end
