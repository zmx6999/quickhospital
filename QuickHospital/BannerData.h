//
//  BannerData.h
//  QuickHospital
//
//  Created by zmx on 16/3/23.
//  Copyright © 2016年 zmx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BannerData : NSObject

@property (nonatomic, copy) NSString *banner_link;
@property (nonatomic, copy) NSString *banner_img_url;

+ (instancetype)dataWithDict:(NSDictionary *)dict;

@end
