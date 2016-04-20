//
//  DoctorViewModel.m
//  QuickHospital
//
//  Created by zmx on 16/3/27.
//  Copyright © 2016年 zmx. All rights reserved.
//

#import "DoctorViewModel.h"
#import "Disease.h"
#import "Doctor.h"

@implementation DoctorViewModel

+ (void)getDoctorWithDisease:(Disease *)disease completionHandler:(void (^)(NSArray *))completionHandler {
    NSDictionary *params = [disease dictionaryWithValuesForKeys:[disease getProperties]];
    [SharedNetworkManager POST:@"v1/puser/order/matchDoctors.json" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *doctors = [responseObject objectForKey:@"data"];
        NSMutableArray *arrM = [NSMutableArray array];
        for (NSDictionary *dict in doctors) {
            Doctor *doctor = [Doctor doctorWithDict:dict];
            [arrM addObject:doctor];
        }
        completionHandler(arrM);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completionHandler(nil);
        NSLog(@"%@", error);
    }];
}

+ (void)getDepartmentNameOfDoctor:(Doctor *)doctor completionHandler:(void (^)(NSString *))completionHandler {
    NSDictionary *params = @{
                             @"doctor_id": @(doctor.doctor_id)
                             };
    [SharedNetworkManager POST:@"v1/puser/getDoctorInfo.json" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *department = [[responseObject objectForKey:@"data"] objectForKey:@"department_name"];
        completionHandler(department);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completionHandler(nil);
        NSLog(@"%@", error);
    }];
}

+ (void)getReceivingSettingOfDoctor:(Doctor *)doctor completionHandler:(void (^)(NSArray *))completionHandler {
    NSDictionary *params = @{
                             @"doctor_id": @(doctor.doctor_id)
                             };
    [SharedNetworkManager POST:@"v1/puser/order/doctorReceivingSetting.json" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *receivingSettings = [[responseObject objectForKey:@"data"] objectForKey:@"receiving_settings"];
        completionHandler(receivingSettings);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completionHandler(nil);
        NSLog(@"%@", error);
    }];
}

+ (void)getIntroductionOfDoctor:(Doctor *)doctor completionHandler:(void (^)(NSString *))completionHandler {
    NSDictionary *params = @{
                             @"doctor_id": @(doctor.doctor_id)
                             };
    [SharedNetworkManager POST:@"v1/pdoctor/basic/getIntroduction.json" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *introduction = [[responseObject objectForKey:@"data"] objectForKey:@"introduction"];
        completionHandler(introduction);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completionHandler(nil);
        NSLog(@"%@", error);
    }];
}

@end