//
//  CustomttCollectionViewCell.m
//  testProject
//
//  Created by dlrj on 17/3/27.
//  Copyright © 2017年 test. All rights reserved.
//

#import "CustomttCollectionViewCell.h"

@implementation CustomttCollectionViewCell
//在UICollectionViewCell.m文件中重写
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        _labname = [[UILabel alloc]initWithFrame:CGRectMake(kw(0), kh(0) ,kw(60), kh(30))];
        _labname.font =kFont(11);
        _labname.textAlignment=NSTextAlignmentCenter;
        _labname.backgroundColor=kwhitecolor;
        _labname.textColor = ktextColor1;
        [self.contentView addSubview:_labname];
    }
    return self;
}
@end
