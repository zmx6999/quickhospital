//
//  Disease.m
//  QuickHospital
//
//  Created by zmx on 16/3/27.
//  Copyright © 2016年 zmx. All rights reserved.
//

#import "Disease.h"
#import <objc/runtime.h>

@implementation Disease

- (NSArray *)getProperties {
    uint count = 0;
    objc_property_t *propertyArr = class_copyPropertyList([self class], &count);
    NSMutableArray *arrM = [NSMutableArray array];
    for (int i = 0; i < count; i++) {
        const char *propertyName = property_getName(propertyArr[i]);
        NSString *property = [[NSString alloc] initWithCString:propertyName encoding:NSUTF8StringEncoding];
        [arrM addObject:property];
    }
    return arrM;
}

@end
