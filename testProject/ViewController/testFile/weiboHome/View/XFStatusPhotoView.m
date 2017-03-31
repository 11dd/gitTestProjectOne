//
//  XFStatusPhotoView.m
//  Weibo
//
//  Created by Fay on 15/10/4.
//  Copyright (c) 2015年 Fay. All rights reserved.
//

#import "XFStatusPhotoView.h"
#import "XFPhoto.h"
#import "UIView+Extension.h"
#import "UIImageView+WebCache.h"

@interface XFStatusPhotoView()
@property (nonatomic, weak) UIImageView *gifView;
@end

@implementation XFStatusPhotoView

- (UIImageView *)gifView
{
    if (!_gifView) {
        UIImage *image = [UIImage imageNamed:@"timeline_image_gif"];
        UIImageView *gifView = [[UIImageView alloc] initWithImage:image];
        [self addSubview:gifView];
        self.gifView = gifView;
    }
    return _gifView;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       
        // 内容模式
        self.contentMode = UIViewContentModeScaleAspectFill;
        // 超出边框的内容都剪掉
        self.clipsToBounds = YES;
    }
    return self;
}

- (void)setPhoto:(XFPhoto *)photo
{
    _photo = photo;

    if (_photo == nil) {
        
    }else{
        NSDictionary*dic = (NSDictionary*)photo;

        // 设置图片photo.thumbnail_pic
        [self sd_setImageWithURL:[NSURL URLWithString:dic[@"thumbnail_pic"]]
                placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    }
    
    //self.gifView.hidden = ![photo.thumbnail_pic.lowercaseString hasSuffix:@"gif"];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.gifView.x = self.width - self.gifView.width;
    self.gifView.y = self.height - self.gifView.height;
}

@end
