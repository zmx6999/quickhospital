//
//  ProfileViewModel.m
//  QuickHospital
//
//  Created by zmx on 16/4/4.
//  Copyright © 2016年 zmx. All rights reserved.
//

#import "ProfileViewModel.h"
#import "RegisterProfile.h"

@implementation ProfileViewModel

+ (void)getSmsCodeWithMobileNumber:(NSString *)mobileNumber completionHandler:(void (^)(NSString *))completionHandler {
    NSDictionary *params = @{
                             @"mobile_number": mobileNumber
                             };
    [SharedNetworkManager POST:@"v1/sms/getSmsCode.json" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        completionHandler(responseObject[@"msg"]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completionHandler(@"网络不给力");
        NSLog(@"%@", error);
    }];
}

+ (void)registerS1WithProfileInfo:(RegisterProfile *)registerProfile completionHandler:(void (^)(NSString *))completionHandler {
    NSDictionary *params = @{
                             @"mobile_number": registerProfile.mobile_number,
                             @"sms_code": registerProfile.sms_code,
                             @"invite_code": registerProfile.invite_code
                             };
    [SharedNetworkManager POST:@"v1/user/carelinkRegisterS1.json" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        completionHandler(responseObject[@"msg"]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completionHandler(@"网络不给力");
        NSLog(@"%@", error);
    }];
}

@end