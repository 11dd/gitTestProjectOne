//
//  MainTableViewCell.m
//  testProject
//
//  Created by mac3 on 17/3/13.
//  Copyright © 2017年 test. All rights reserved.
//

#import "MainTableViewCell.h"

@implementation MainTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
            [self.contentView addSubview:self.topLabel];
            [self.contentView addSubview:self.timeLabel];
            
            [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                //CGFloat top, CGFloat left, CGFloat bottom, CGFloat right
                make.edges.equalTo(self.contentView).with.insets(UIEdgeInsetsMake(kh(40), kw(50), 10, kw(10)));
            }];

        
    }
    return self;
}

-(UILabel *)topLabel
{
    if (!_topLabel) {
        
        _topLabel = [[UILabel alloc]init];
        _topLabel.frame = CGRectMake(kw(50), kh(10), kw(200), kh(20));
        _topLabel.backgroundColor = [UIColor clearColor];
        _topLabel.textAlignment = NSTextAlignmentLeft;
        _topLabel.font = [UIFont systemFontOfSize:kh(14)];
        _topLabel.numberOfLines = 1;
        
    }
    return _topLabel;
}


-(UILabel *)timeLabel
{
    if (!_timeLabel) {
        
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.frame = CGRectMake(0,0,0,0);
        _timeLabel.backgroundColor = [UIColor clearColor];
        _timeLabel.textAlignment = NSTextAlignmentLeft;
        _timeLabel.font = [UIFont systemFontOfSize:kh(14)];
        _timeLabel.numberOfLines = 0;
        
    }
    return _timeLabel;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}


@end
