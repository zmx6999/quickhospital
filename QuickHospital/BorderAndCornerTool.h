//
//  BorderAndCornerTool.h
//  QuickHospital
//
//  Created by zmx on 16/3/29.
//  Copyright © 2016年 zmx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BorderAndCornerTool : NSObject

+ (void)setBorderAndCornerWithView:(UIView *)view;
+ (void)setBorderAndCornerWithView:(UIView *)view borderColor:(UIColor *)borderColor;

@end
