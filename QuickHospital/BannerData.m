//
//  BannerData.m
//  QuickHospital
//
//  Created by zmx on 16/3/23.
//  Copyright © 2016年 zmx. All rights reserved.
//

#import "BannerData.h"

@implementation BannerData

+ (instancetype)dataWithDict:(NSDictionary *)dict {
    BannerData *data = [[self alloc] init];
    [data setValuesForKeysWithDictionary:dict];
    return data;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

@end
