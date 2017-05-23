//
//  cusuiwindow.m
//  米哈健身
//
//  Created by dlrj on 17/4/18.
//  Copyright © 2017年 test. All rights reserved.
//

#import "cusuiwindow.h"

@implementation cusuiwindow
single_implementation(cusuiwindow)

- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

-(void)createButton
{
    
    if (!_button) {
        _window = [[UIApplication sharedApplication] keyWindow];
        _window.backgroundColor = [UIColor whiteColor];
        [_window addSubview:self.button];
        
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(locationChange:)];
        pan.delaysTouchesBegan = YES;
        [_button addGestureRecognizer:pan];
    }
}

-(UIButton*)button
{
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.backgroundColor = rgba(235, 235, 235, 1);
        [_button setTextColor:rgba(0, 203, 145, 1)];
        
        _button.frame = CGRectMake(0, 200, kw(50), kw(66));
        _button.titleLabel.font=kFont(10);
        
        //_button.layer.cornerRadius = 30;
        //_button.layer.masksToBounds = YES;
        //[_button addTarget:self action:@selector(removeButton) forControlEvents:UIControlEventTouchUpInside];

        UIImageView * imgView = [[UIImageView alloc]init];
        imgView.image = [UIImage imageNamed:@"jianshenzhonging"];
        imgView.frame = CGRectMake(0, 0, kw(50), kw(66));
        [_button addSubview:imgView];
    }
    return _button;
}

//改变位置
-(void)locationChange:(UIPanGestureRecognizer*)p
{
    
    CGFloat HEIGHT=_button.frame.size.height;
    CGFloat WIDTH=_button.frame.size.width;

    CGPoint panPoint = [p locationInView:[UIApplication sharedApplication].windows[0]];
    
    if(p.state == UIGestureRecognizerStateChanged)
    {
        _button.center = CGPointMake(panPoint.x, panPoint.y);
    }
    else if(p.state == UIGestureRecognizerStateEnded)
    {
        if(panPoint.x <= KScreenWidth/2)
        {
            if(panPoint.y <= 40+HEIGHT/2 && panPoint.x >= 20+WIDTH/2)
            {
                [UIView animateWithDuration:0.2 animations:^{
                    _button.center = CGPointMake(panPoint.x, HEIGHT/2);
                }];
            }
            else if(panPoint.y >= KScreenHeight-HEIGHT/2-40 && panPoint.x >= 20+WIDTH/2)
            {
                [UIView animateWithDuration:0.2 animations:^{
                    _button.center = CGPointMake(panPoint.x, KScreenHeight-HEIGHT/2);
                }];
            }
            else if (panPoint.x < WIDTH/2+15 && panPoint.y > KScreenHeight-HEIGHT/2)
            {
                [UIView animateWithDuration:0.2 animations:^{
                    _button.center = CGPointMake(WIDTH/2, KScreenHeight-HEIGHT/2);
                }];
            }
            else
            {
                CGFloat pointy = panPoint.y < HEIGHT/2 ? HEIGHT/2 :panPoint.y;
                [UIView animateWithDuration:0.2 animations:^{
                    _button.center = CGPointMake(WIDTH/2, pointy);
                }];
            }
        }
        else if(panPoint.x > KScreenWidth/2)
        {
            if(panPoint.y <= 40+HEIGHT/2 && panPoint.x < KScreenWidth-WIDTH/2-20 )
            {
                [UIView animateWithDuration:0.2 animations:^{
                    _button.center = CGPointMake(panPoint.x, HEIGHT/2);
                }];
            }
            else if(panPoint.y >= KScreenHeight-40-HEIGHT/2 && panPoint.x < KScreenWidth-WIDTH/2-20)
            {
                [UIView animateWithDuration:0.2 animations:^{
                    _button.center = CGPointMake(panPoint.x, KScreenHeight-HEIGHT/2);
                }];
            }
            else if (panPoint.x > KScreenWidth-WIDTH/2-15 && panPoint.y < HEIGHT/2)
            {
                [UIView animateWithDuration:0.2 animations:^{
                    _button.center = CGPointMake(KScreenWidth-WIDTH/2, HEIGHT/2);
                }];
            }
            else
            {
                CGFloat pointy = panPoint.y > KScreenHeight-HEIGHT/2 ? KScreenHeight-HEIGHT/2 :panPoint.y;
                [UIView animateWithDuration:0.2 animations:^{
                    _button.center = CGPointMake(KScreenWidth-WIDTH/2, pointy);
                }];
            }
        }
    }
}


- (void)removeButton
{
    
    [_button removeFromSuperview];
    _button = nil;
    
}

@end
