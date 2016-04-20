//
//  DiseaseDetailData.m
//  QuickHospital
//
//  Created by zmx on 16/3/25.
//  Copyright © 2016年 zmx. All rights reserved.
//

#import "DiseaseDetail.h"

@implementation DiseaseDetail

+ (instancetype)dataWithDict:(NSDictionary *)dict {
    DiseaseDetail *data = [[self alloc] init];
    [data setValuesForKeysWithDictionary:dict];
    return data;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

@end
