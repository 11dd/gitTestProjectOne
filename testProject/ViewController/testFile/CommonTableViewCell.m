//
//  CommonTableViewCell.m
//  testProject
//
//  Created by mac3 on 17/3/17.
//  Copyright © 2017年 test. All rights reserved.
//

#import "CommonTableViewCell.h"

@implementation CommonTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableview
{
    static NSString *ID = @"CommonTableViewCell";
    CommonTableViewCell *cell = [tableview dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell = [[CommonTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.detailLabel];
        [self.contentView addSubview:self.leftLabel];
        [self.contentView addSubview:self.rightLabel];
        
        [self.contentView addSubview:self.editButton];
        [self.contentView addSubview:self.imgView];
        
    }
    return self;
}


-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.frame = CGRectMake(kw(15), kh(10), kw(215), kh(40));
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.font = [UIFont systemFontOfSize:kh(14)];
        _titleLabel.numberOfLines = 1;
        
    }
    return _titleLabel;
}

-(UILabel *)detailLabel
{
    if (!_detailLabel) {
        
        _detailLabel = [[UILabel alloc]init];
        _detailLabel.frame = CGRectMake(kw(15), kh(10), kw(215), kh(40));
        _detailLabel.backgroundColor = [UIColor clearColor];
        _detailLabel.textAlignment = NSTextAlignmentLeft;
        _detailLabel.font = [UIFont systemFontOfSize:kh(14)];
        _detailLabel.numberOfLines = 1;
        
    }
    return _detailLabel;
}

-(UILabel *)leftLabel
{
    if (!_leftLabel) {
        
        _leftLabel = [[UILabel alloc]init];
        _leftLabel.frame = CGRectMake(kw(15), kh(10), kw(215), kh(40));
        _leftLabel.backgroundColor = [UIColor clearColor];
        _leftLabel.textAlignment = NSTextAlignmentLeft;
        _leftLabel.font = [UIFont systemFontOfSize:kh(14)];
        _leftLabel.numberOfLines = 1;
        
    }
    return _leftLabel;
}

-(UILabel *)rightLabel
{
    if (!_rightLabel) {
        
        _rightLabel = [[UILabel alloc]init];
        _rightLabel.frame = CGRectMake(kw(15), kh(10), kw(215), kh(40));
        _rightLabel.backgroundColor = [UIColor clearColor];
        _rightLabel.textAlignment = NSTextAlignmentRight;
        _rightLabel.font = [UIFont systemFontOfSize:kh(14)];
        _rightLabel.numberOfLines = 1;
        
    }
    return _rightLabel;
}

//有图显示图
-(UIImageView *)imgView
{
    if (!_imgView) {
        _imgView = [[UIImageView alloc]init];
        _imgView.frame = CGRectMake(kw(10), kh(10), kw(40), kw(40));
        _imgView.backgroundColor = [UIColor clearColor];
        _imgView.layer.cornerRadius = 5;
    }
    return _imgView;
}

//有按钮显示按钮
-(UIButton *)editButton
{
    if (!_editButton) {
        
        _editButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _editButton.frame = CGRectMake(KScreenWidth - kw(34), kh(48), kw(34), kh(34));
        _editButton.backgroundColor = [UIColor lightGrayColor];
        [_editButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        //[_editButton addTarget:self action:@selector(editButtonAction) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _editButton;
}

@end
