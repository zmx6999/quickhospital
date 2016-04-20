//
//  Province.h
//  QuickHospital
//
//  Created by zmx on 16/3/23.
//  Copyright © 2016年 zmx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Province : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSArray *cities;

+ (instancetype)provinceWithDict:(NSDictionary *)dict;

@end
