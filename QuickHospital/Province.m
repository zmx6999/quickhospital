//
//  Province.m
//  QuickHospital
//
//  Created by zmx on 16/3/23.
//  Copyright © 2016年 zmx. All rights reserved.
//

#import "Province.h"

@implementation Province

+ (instancetype)provinceWithDict:(NSDictionary *)dict {
    Province *province = [[self alloc] init];
    [province setValuesForKeysWithDictionary:dict];
    return province;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

@end
