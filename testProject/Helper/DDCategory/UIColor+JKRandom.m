//
//  UIColor+Random.m
//  JKCategories 
//
//  Created by Jakey on 14/12/15.
//  Copyright (c) 2014年 . All rights reserved.
//

#import "UIColor+JKRandom.h"

@implementation UIColor (JKRandom)

+ (UIColor *)jk_randomColor {
    
    NSInteger aRedValue = arc4random() % 255;
    NSInteger aGreenValue = arc4random() % 255;
    NSInteger aBlueValue = arc4random() % 255;
    UIColor *randColor = [UIColor colorWithRed:aRedValue / 255.0f green:aGreenValue / 255.0f blue:aBlueValue / 255.0f alpha:1.0f];
    
    return randColor;
}

@end
