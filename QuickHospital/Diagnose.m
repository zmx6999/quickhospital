//
//  Diagnose.m
//  QuickHospital
//
//  Created by zmx on 16/3/26.
//  Copyright © 2016年 zmx. All rights reserved.
//

#import "Diagnose.h"

@implementation Diagnose

+ (instancetype)diagnoseWithDict:(NSDictionary *)dict {
    Diagnose *diagnose = [[self alloc] init];
    [diagnose setValuesForKeysWithDictionary:dict];
    return diagnose;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

@end
