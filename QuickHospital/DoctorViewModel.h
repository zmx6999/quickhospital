//
//  DoctorViewModel.h
//  QuickHospital
//
//  Created by zmx on 16/3/27.
//  Copyright © 2016年 zmx. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Disease;
@class Doctor;

@interface DoctorViewModel : NSObject

+ (void)getDoctorWithDisease:(Disease *)disease completionHandler:(void (^)(NSArray *doctors))completionHandler;
+ (void)getDepartmentNameOfDoctor:(Doctor *)doctor completionHandler:(void (^)(NSString *department))completionHandler;
+ (void)getReceivingSettingOfDoctor:(Doctor *)doctor completionHandler:(void (^)(NSArray *receivingSettings))completionHandler;
+ (void)getIntroductionOfDoctor:(Doctor *)doctor completionHandler:(void (^)(NSString *introduction))completionHandler;

@end
