//
//  Diagnose.h
//  QuickHospital
//
//  Created by zmx on 16/3/26.
//  Copyright © 2016年 zmx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Diagnose : NSObject

@property (nonatomic, assign) NSInteger diagnosis_type_id;
@property (nonatomic, copy) NSString *diagnosis_type_name;

+ (instancetype)diagnoseWithDict:(NSDictionary *)dict;

@end
