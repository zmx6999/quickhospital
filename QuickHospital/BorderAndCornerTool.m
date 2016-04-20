//
//  BorderAndCornerTool.m
//  QuickHospital
//
//  Created by zmx on 16/3/29.
//  Copyright © 2016年 zmx. All rights reserved.
//

#import "BorderAndCornerTool.h"

@implementation BorderAndCornerTool

+ (void)setBorderAndCornerWithView:(UIView *)view {
    [self setBorderAndCornerWithView:view borderColor:Color(208, 208, 208)];
}

+ (void)setBorderAndCornerWithView:(UIView *)view borderColor:(UIColor *)borderColor {
    view.layer.cornerRadius = 5;
    view.layer.masksToBounds = YES;
    view.layer.borderColor = borderColor.CGColor;
    view.layer.borderWidth = 1;
}

@end
