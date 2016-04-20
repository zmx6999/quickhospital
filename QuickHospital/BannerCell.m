//
//  BannerCell.m
//  QuickHospital
//
//  Created by zmx on 16/3/23.
//  Copyright © 2016年 zmx. All rights reserved.
//

#import "BannerCell.h"

@interface BannerCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation BannerCell

- (void)setImgUrl:(NSString *)imgUrl {
    _imgUrl = imgUrl;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:imgUrl]];
}

@end
