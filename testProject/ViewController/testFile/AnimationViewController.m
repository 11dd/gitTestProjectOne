//
//  AnimationViewController.m
//  testProject
//
//  Created by mac3 on 17/3/23.
//  Copyright © 2017年 test. All rights reserved.
//

#import "AnimationViewController.h"
#import "LDProgressBar.h"

@interface AnimationViewController ()
{
    NSInteger signMove;
}

@property (nonatomic , strong) UIView *demoView;
@property (nonatomic , strong) UIView *demoView1;

@property (nonatomic, strong) LDProgressBar *progressView; //环形进度条

@property (nonatomic, strong) LDProgressBar *progressView1; //环形进度条

@end

@implementation AnimationViewController

-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:YES];
    
    [_demoView removeFromSuperview];
    [_demoView1 removeFromSuperview];
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    [self drawNavWithTitle:@"测试动画效果"];
    [self drawBackButton];
    
    signMove = 0;
    

    [self.view addSubview:self.demoView];
    [self.view addSubview:self.demoView1];
    
    
    _progressView = [[LDProgressBar alloc]initWithFrame:CGRectMake(60,0, 200, 200)];
    _progressView.backgroundColor = [UIColor clearColor];
    
    _progressView1 = [[LDProgressBar alloc]initWithFrame:CGRectMake(60,0, 200, 200)];
    _progressView1.backgroundColor = [UIColor clearColor];
    
    [self.demoView addSubview:self.progressView];
    
    [self.demoView1 addSubview:self.progressView1];
    
    
    UISwipeGestureRecognizer * recognizer;
    
    recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [self.view addGestureRecognizer:recognizer];

    
    recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    [self.view addGestureRecognizer:recognizer];
    
}

- (void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer{
   
    if(recognizer.direction == UISwipeGestureRecognizerDirectionLeft) {
        
        if (signMove == 0) {
            
            //触点移动的绝对距离
            CGPoint location = [recognizer locationInView:self.view];
            [self temp1:location.x];
            signMove =1;
        }
    }
    if(recognizer.direction == UISwipeGestureRecognizerDirectionRight) {

        if (signMove == 1) {
            CGPoint location = [recognizer locationInView:self.view];
            [self temp2:location.x];
            signMove = 0;
        }
    }
}




- (UIView *)demoView{
    if (!_demoView) {
        _demoView = ({
            UIView *demoView = [[UIView alloc] initWithFrame:({
                CGRect rect = CGRectMake(0, 64,KScreenWidth ,KScreenHeight/2-36);
                rect;
            })];
            demoView.backgroundColor = [UIColor lightGrayColor];
            demoView;
        });
    }
    return _demoView;
}

- (UIView *)demoView1{
    if (!_demoView1) {
        _demoView1 = ({
            UIView *demoView1 = [[UIView alloc] initWithFrame:({
                CGRect rect = CGRectMake(KScreenWidth, 64,KScreenWidth ,KScreenHeight/2-36);
                rect;
            })];
            demoView1.backgroundColor = [UIColor lightGrayColor];
            demoView1;
        });
    }
    return _demoView1;
}



-(void)temp1:(CGFloat)x
{
    
    //创建运动的轨迹动画
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    pathAnimation.calculationMode = kCAAnimationPaced;
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.removedOnCompletion = NO;
    pathAnimation.duration = 1.0;
    pathAnimation.repeatCount = 1;
    
    CGFloat radiusX = 360;

    
    CGMutablePathRef ovalfromarc = CGPathCreateMutable();
    CGPathAddArc(ovalfromarc, NULL, self.view.frame.size.width/2, self.view.frame.size.height, radiusX, 2*M_PI - M_PI/2, M_PI , 1);
    pathAnimation.path = ovalfromarc;
    CGPathRelease(ovalfromarc);
    [_demoView.layer addAnimation:pathAnimation forKey:@"moveTheCircle"];
    
    
    CGMutablePathRef ovalfromarc1 = CGPathCreateMutable();
    CGPathAddArc(ovalfromarc1, NULL, self.view.frame.size.width/2, self.view.frame.size.height, radiusX, 0, 2*M_PI - M_PI/2 , 1);
    pathAnimation.path = ovalfromarc1;
    CGPathRelease(ovalfromarc1);
    //设置运转的动画
    [_demoView1.layer addAnimation:pathAnimation forKey:@"moveTheCircleOne"];
    
}


-(void)temp2:(CGFloat)x
{
    
    //创建运动的轨迹动画
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    pathAnimation.calculationMode = kCAAnimationPaced;
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.removedOnCompletion = NO;
    pathAnimation.duration = 1.0;
    pathAnimation.repeatCount = 1;
    
    CGFloat radiusX = 360;
    
    
    CGMutablePathRef ovalfromarc = CGPathCreateMutable();
    CGPathAddArc(ovalfromarc, NULL, self.view.frame.size.width/2, self.view.frame.size.height, radiusX, M_PI,2*M_PI - M_PI/2 , 0);
    pathAnimation.path = ovalfromarc;
    CGPathRelease(ovalfromarc);
    [_demoView.layer addAnimation:pathAnimation forKey:@"moveTheCircle"];
    
    
    CGMutablePathRef ovalfromarc1 = CGPathCreateMutable();
    CGPathAddArc(ovalfromarc1, NULL, self.view.frame.size.width/2, self.view.frame.size.height, radiusX, 2*M_PI - M_PI/2, 0 , 0);
    pathAnimation.path = ovalfromarc1;
    CGPathRelease(ovalfromarc1);
    //设置运转的动画
    [_demoView1.layer addAnimation:pathAnimation forKey:@"moveTheCircleOne"];
    
   
}

#pragma - mark - 未使用

-(void)temp{
    
    float centerX = self.view.bounds.size.width/2;
    float centerY = self.view.bounds.size.height/2;
    float x = self.view.bounds.size.width/2;
    float y = self.view.bounds.size.height;
    
    
    x = x - centerX; //计算(x,y)从(0,0)为原点的坐标系变换到(CenterX ，CenterY)为原点的坐标系下的坐标
    y = y - centerY; //(0，0)坐标系的右横轴、下竖轴是正轴,(CenterX,CenterY)坐标系的正轴也一样
    
    [UIView animateWithDuration:3.0f animations:^{
        
        CGAffineTransform  trans = CGAffineTransformMakeTranslation(x, y);
        
        trans = CGAffineTransformRotate(trans,-90.0/180.0*M_PI);
        
        trans = CGAffineTransformTranslate(trans,-x, -y);
        
        _demoView.transform = CGAffineTransformIdentity;
        
        _demoView.transform = trans;
        
        
    }];
    
    [UIView animateWithDuration:3.0f animations:^{
        
        CGAffineTransform  trans = CGAffineTransformMakeTranslation(x, y);
        
        trans = CGAffineTransformRotate(trans,0.0/180.0*M_PI);
        
        trans = CGAffineTransformTranslate(trans,-x, -y);
        
        _demoView1.transform = CGAffineTransformIdentity;
        
        _demoView1.transform = trans;
        
        
    }];

}


@end
