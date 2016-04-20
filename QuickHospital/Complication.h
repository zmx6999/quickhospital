//
//  Complication.h
//  QuickHospital
//
//  Created by zmx on 16/3/26.
//  Copyright © 2016年 zmx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Complication : NSObject

@property (nonatomic, copy) NSString *complication_id;
@property (nonatomic, copy) NSString *complication_name;

+ (instancetype)complicationWithDict:(NSDictionary *)dict;

@end
