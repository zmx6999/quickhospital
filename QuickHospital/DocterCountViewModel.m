//
//  DocterCountViewModel.m
//  QuickHospital
//
//  Created by zmx on 16/3/23.
//  Copyright © 2016年 zmx. All rights reserved.
//

#import "DocterCountViewModel.h"

@implementation DocterCountViewModel

+ (void)getDocterCountWithCi1Id:(NSInteger)ci1Id responseHandler:(void (^)(NSInteger))responseHandler {
    NSDictionary *parmas = @{
                             @"ci1_id": @(ci1Id)
                             };
    [SharedNetworkManager POST:@"v1/puser/order/matchedDoctorCount.json" parameters:parmas progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSInteger count = [[[responseObject objectForKey:@"data"] objectForKey:@"doctor_count"] integerValue];
        responseHandler(count);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        responseHandler(0);
        NSLog(@"%@", error);
    }];
}

@end
