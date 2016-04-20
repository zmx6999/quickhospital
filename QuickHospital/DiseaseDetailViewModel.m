//
//  DiseaseDetailViewModel.m
//  QuickHospital
//
//  Created by zmx on 16/3/25.
//  Copyright © 2016年 zmx. All rights reserved.
//

#import "DiseaseDetailViewModel.h"
#import "DiseaseDetail.h"
#import "Complication.h"
#import "Diagnose.h"

@implementation DiseaseDetailViewModel

+ (void)getDiseaseDetailWithCi1Id:(NSInteger)ci1Id page:(NSInteger)page completionHandler:(void (^)(NSArray *))completionHandler {
    NSDictionary *params = @{
                             @"page": @(page),
                             @"page_size": @(DiseaseDetailPageSize),
                             @"ci1_id": @(ci1Id),
                             @"keyword": @""
                             };
    [SharedNetworkManager POST:@"v1/ci/searchCI3List.json" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *details = [responseObject objectForKey:@"data"];
        NSMutableArray *arrM = [NSMutableArray array];
        for (NSDictionary *dict in details) {
            DiseaseDetail *detail = [DiseaseDetail dataWithDict:dict];
            [arrM addObject:detail];
        }
        completionHandler(arrM);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completionHandler(nil);
        NSLog(@"%@", error);
    }];
}

+ (void)getComplicationWithCi2Id:(NSInteger)ci2Id page:(NSInteger)page completionHandler:(void (^)(NSArray *))completionHandler {
    NSDictionary *params = @{
                             @"page": @(page),
                             @"page_size": @(DiseaseDetailPageSize),
                             @"ci2_id": @(ci2Id)
                             };
    [SharedNetworkManager POST:@"v1/ci/complicationList.json" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *complications = [responseObject objectForKey:@"data"];
        NSMutableArray *arrM = [NSMutableArray array];
        for (NSDictionary *dict in complications) {
            Complication *complication = [Complication complicationWithDict:dict];
            [arrM addObject:complication];
        }
        completionHandler(arrM);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completionHandler(nil);
        NSLog(@"%@", error);
    }];
}

+ (void)getDiagnoseMethodWithCompletionHandler:(void (^)(NSArray *))completionHandler {
    NSDictionary *params = @{};
    [SharedNetworkManager POST:@"v1/ci/diagnosisTypeList.json" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *diagnoses = [responseObject objectForKey:@"data"];
        NSMutableArray *arrM = [NSMutableArray array];
        for (NSDictionary *dict in diagnoses) {
            Diagnose *diagnose = [Diagnose diagnoseWithDict:dict];
            [arrM addObject:diagnose];
        }
        completionHandler(arrM);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completionHandler(nil);
        NSLog(@"%@", error);
    }];
}

@end
