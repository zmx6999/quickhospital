//
//  Complication.m
//  QuickHospital
//
//  Created by zmx on 16/3/26.
//  Copyright © 2016年 zmx. All rights reserved.
//

#import "Complication.h"

@implementation Complication

+ (instancetype)complicationWithDict:(NSDictionary *)dict {
    Complication *complication = [[self alloc] init];
    [complication setValuesForKeysWithDictionary:dict];
    return complication;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

@end
