//
//  LDProgressBar.h
//  弧形进度条
//
//  Created by mac3 on 17/3/23.
//  Copyright © 2017年 test. All rights reserved.
//

#import "LDProgressBar.h"

#define kSW self.frame.size.width
#define kSH self.frame.size.height

@implementation LDProgressBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        if (!_timer) {
            _timer = [NSTimer scheduledTimerWithTimeInterval:.01 target:self selector:@selector(change) userInfo:nil repeats:YES];
        }
    }
    return self;
}

-(void)change
{
    _num +=1;
    
    if (_num > 100) {
        _num = 0;
        [_timer invalidate];
    }
    //    创建通知
    NSNotification *noti = [NSNotification notificationWithName:@"number" object:nil userInfo:nil];
    //    发送通知
    [[NSNotificationCenter defaultCenter]postNotification:noti];
    
}

-(void)numberChange:(NSNotification*)text
{
    [self setNeedsDisplay];
}

-(void)setNum:(int)num
{
    _num = num;
    
    [self setNeedsDisplay];
}

-(void)drawRect:(CGRect)rect {

    [self drawHuan1];//底
    [self drawHuan2];//进度
}


-(void)drawHuan1
{
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(ctx, 4);
    
    CGContextSetLineCap(ctx,kCGLineCapButt);
    
    CGFloat length[] = {4,8};
    
    CGContextSetLineDash(ctx, 0, length, 2);
    
    
    [[UIColor colorWithRed:77/255.0 green:77/255.0 blue:77/255.0 alpha:1.0]set];
    
    CGContextAddArc(ctx, kSW/2 , kSW/2, kSW/2-8, -2*M_PI_4, 6*M_PI_4, 0);
    
    CGContextStrokePath(ctx);
    
}

-(void)drawHuan2
{
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(ctx, 4);
    
    CGContextSetLineCap(ctx,kCGLineCapButt);
    
    CGFloat length[] = {4,8};
    
    CGContextSetLineDash(ctx, 0, length, 2);
    
    [[UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1.0] set];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(numberChange:) name:@"number" object:nil];
    
    CGFloat end = -2*M_PI_4+(8*M_PI_4*_num/100);
    
    CGContextAddArc(ctx, kSW/2 , kSW/2, kSW/2-8, -2*M_PI_4, end , 0);
    
    CGContextStrokePath(ctx);
    
}





@end
