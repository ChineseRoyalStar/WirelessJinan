//
//  CycleImageCell.m
//  PocketKitchen
//
//  Created by 夏婷 on 15/10/15.
//  Copyright (c) 2015年 夏婷. All rights reserved.
//

#import "CycleImageCell.h"
#import "UIImageView+WebCache.h"

@implementation CycleImageCell
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createSubViews];
    }
    return self;
}
-(void)createSubViews
{
    _imageView = [[UIImageView alloc]initWithFrame:self.bounds];
    [self.contentView addSubview:_imageView];
}
-(void)setPlaceHolderImageName:(NSString *)placeHolderImageName
{
    _placeHolderImageName = placeHolderImageName;
}
-(void)setImageURL:(NSURL *)imageURL
{
    _imageURL = imageURL;
    //实现异步加载图片，本地缓存，网络下载，设置占位图片
    [_imageView sd_setImageWithURL:_imageURL placeholderImage:[UIImage imageNamed:_placeHolderImageName]];
}
-(void)setImageName:(NSString *)imageName
{
    _imageName = imageName;
    _imageView.image = [UIImage imageNamed:_imageName];
}

@end
