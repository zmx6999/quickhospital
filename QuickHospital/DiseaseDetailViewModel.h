//
//  DiseaseDetailViewModel.h
//  QuickHospital
//
//  Created by zmx on 16/3/25.
//  Copyright © 2016年 zmx. All rights reserved.
//

#import <Foundation/Foundation.h>
#define DiseaseDetailPageSize 15

@interface DiseaseDetailViewModel : NSObject

+ (void)getDiseaseDetailWithCi1Id:(NSInteger)ci1Id page:(NSInteger)page completionHandler:(void (^)(NSArray *diseaseDetails))completionHandler;
+ (void)getComplicationWithCi2Id:(NSInteger)ci2Id page:(NSInteger)page completionHandler:(void (^)(NSArray *complications))completionHandler;
+ (void)getDiagnoseMethodWithCompletionHandler:(void (^)(NSArray *diagnoses))completionHandler;

@end
