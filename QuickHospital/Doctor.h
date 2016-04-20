//
//  Doctor.h
//  QuickHospital
//
//  Created by zmx on 16/3/27.
//  Copyright © 2016年 zmx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Doctor : NSObject

@property (nonatomic, assign) NSInteger doctor_id;
@property (nonatomic, assign) NSInteger doctor_gender;
@property (nonatomic, copy) NSString *doctor_name;
@property (nonatomic, copy) NSString *doctor_title_name;
@property (nonatomic, copy) NSString *doctor_hospital_name;
@property (nonatomic, assign) NSInteger operation_count;
@property (nonatomic, assign) NSInteger flower;
@property (nonatomic, assign) NSInteger banner;
@property (nonatomic, copy) NSString *accuracy;
@property (nonatomic, copy) NSString *department_name;

+ (instancetype)doctorWithDict:(NSDictionary *)dict;

@end
