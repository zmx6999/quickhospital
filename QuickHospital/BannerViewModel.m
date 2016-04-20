//
//  BannerViewModel.m
//  QuickHospital
//
//  Created by zmx on 16/3/23.
//  Copyright © 2016年 zmx. All rights reserved.
//

#import "BannerViewModel.h"
#import "BannerData.h"

@implementation BannerViewModel

+ (void)getBannerDataWithResponseHandler:(void (^)(NSArray *))responseHandler {
    NSDictionary *params = @{
                             @"page_size": @(10),
                             @"page": @(1)
                             };
    [SharedNetworkManager POST:@"v1/common/banners.json" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *dataArr = [[responseObject objectForKey:@"data"] objectForKey:@"banners"];
        NSMutableArray *arrM = [NSMutableArray array];
        for (NSDictionary *dict in dataArr) {
            BannerData *data = [BannerData dataWithDict:dict];
            [arrM addObject:data];
        }
        responseHandler(arrM);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        responseHandler(nil);
        NSLog(@"%@", error);
    }];
}

@end
