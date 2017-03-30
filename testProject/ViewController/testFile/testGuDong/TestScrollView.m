//
//  TestScrollView.m
//  testProject
//
//  Created by mac3 on 17/3/24.
//  Copyright © 2017年 test. All rights reserved.
//

#import "TestScrollView.h"
#import "LDProgressBar.h"

@interface TestScrollView()<UIScrollViewDelegate>

@property(nonatomic,strong) LDProgressBar *progressView; //环形进度条
@property(nonatomic,strong) UIScrollView  *MoveScrollView;
@property(nonatomic,assign) NSInteger currentIndex;
@property(nonatomic,assign) CGFloat lastNum;

@end

@implementation TestScrollView

-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    if (_MoveScrollView == nil) {
        
        _MoveScrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        
        _MoveScrollView.showsHorizontalScrollIndicator = NO;
        _MoveScrollView.showsVerticalScrollIndicator = NO;
        _MoveScrollView.userInteractionEnabled=YES;
        _MoveScrollView.pagingEnabled=YES;
        _MoveScrollView.scrollsToTop = NO;
        _MoveScrollView.bounces=NO;
        _MoveScrollView.delegate = self;
        _MoveScrollView.backgroundColor = rgba(100, 180, 80, 1);
        
        [self addSubview:_MoveScrollView];
        
    }else{
        
        _MoveScrollView.frame = self.bounds;
        
    }
    
    self.currentIndex = 0 ;
    self.lastNum = 0;//记录上一次滑动完的尺寸
    
    
    CGRect rect = self.bounds;
    
    for (int i = 0; i<2; i++)
    {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        view.backgroundColor = [UIColor clearColor];
        view.tag = 200+i;
        
        rect.origin.x = rect.size.width*i;
        rect.size.height = self.frame.size.height;
        view.frame = rect;
        
        [_MoveScrollView addSubview:view];

        
        UIView *progressView = [[UIView alloc] init];
        progressView.frame = CGRectMake((self.frame.size.width-200)/2, 20, 200, 200);
        progressView.backgroundColor = [UIColor clearColor];
        progressView.tag = 100+i;
        [view addSubview:progressView];

        if (i == 0) {
            UILabel *label = [[UILabel alloc]init];
            label.frame = CGRectMake(0, 0, 200, 200);
            label.backgroundColor = [UIColor clearColor];
            label.text = @"0";
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [UIFont systemFontOfSize:160];
            label.textColor = [UIColor whiteColor];
            [progressView addSubview:label];

        }else{
            
            _progressView = [[LDProgressBar alloc]initWithFrame:CGRectMake(0,0, 200, 200)];
            _progressView.backgroundColor = [UIColor clearColor];
            [progressView addSubview:_progressView];
            
            UILabel *label = [[UILabel alloc]init];
            label.frame = CGRectMake(25, 50, 150, 100);
            label.backgroundColor = [UIColor clearColor];
            label.textAlignment = NSTextAlignmentCenter;
            label.attributedText = [Helper stringToAttributedString:@"124步" NSMakeRange:3];
            [progressView addSubview:label];
            
            //先让右边的view转出屏幕
            view.transform =CGAffineTransformMakeRotation(M_PI *0.5);
        }
        
    }
    
    [_MoveScrollView setContentSize:CGSizeMake(self.frame.size.width*2,self.bounds.size.height)];
    
}

//1.先是执行 停止拖住的代理
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat x =0;
    CGFloat contentOffsetX = scrollView.contentOffset.x-self.frame.size.width*self.currentIndex;
    if (_lastNum == 0){
        x = contentOffsetX;
    }else{
        x = contentOffsetX - _lastNum;
    }
    _lastNum = contentOffsetX;

    if (contentOffsetX>0) {
        
        UIView *view = [_MoveScrollView viewWithTag:200+self.currentIndex+1];
        view.transform = CGAffineTransformRotate(view.transform, -M_PI *x/(self.frame.size.width)*0.5);
        
        UIView *view2 = [_MoveScrollView viewWithTag:200+self.currentIndex];
        view2.transform = CGAffineTransformRotate(view2.transform, -M_PI *x/(self.frame.size.width)*0.5);

        [_MoveScrollView bringSubviewToFront:view];
        
    }else{
        
        UIView *view = [_MoveScrollView viewWithTag:200+self.currentIndex-1];
        view.transform = CGAffineTransformRotate(view.transform, -M_PI *x/self.frame.size.width*0.5);

        UIView *view2 = [_MoveScrollView viewWithTag:200+self.currentIndex];
        view2.transform = CGAffineTransformRotate(view2.transform, -M_PI *x/self.frame.size.width*0.5);

        [_MoveScrollView bringSubviewToFront:view];
    }
    
}

//2.然后执行 ,DidEndDecelerating 减速停止的时候开始执行
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGPoint offset = scrollView.contentOffset;
    CGRect bounds = self.bounds;
    
    self.currentIndex = offset.x / bounds.size.width;
    _lastNum = 0;
    
}




@end
