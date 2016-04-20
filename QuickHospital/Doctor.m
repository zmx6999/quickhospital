//
//  Doctor.m
//  QuickHospital
//
//  Created by zmx on 16/3/27.
//  Copyright © 2016年 zmx. All rights reserved.
//

#import "Doctor.h"

@implementation Doctor

+ (instancetype)doctorWithDict:(NSDictionary *)dict {
    Doctor *doctor = [[self alloc] init];
    [doctor setValuesForKeysWithDictionary:dict];
    return doctor;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

@end
