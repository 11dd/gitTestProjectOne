//
//  CommonTableViewCell.h
//  testProject
//
//  Created by mac3 on 17/3/17.
//  Copyright © 2017年 test. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommonTableViewCell : UITableViewCell

@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *detailLabel;

@property (nonatomic,strong) UILabel *leftLabel;
@property (nonatomic,strong) UILabel *rightLabel;

@property (nonatomic,strong) UIButton *editButton;
@property (nonatomic,strong) UIImageView *imgView;


+ (instancetype)cellWithTableView:(UITableView *)tableview;


@end
