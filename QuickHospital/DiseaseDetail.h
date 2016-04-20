//
//  DiseaseDetailData.h
//  QuickHospital
//
//  Created by zmx on 16/3/25.
//  Copyright © 2016年 zmx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DiseaseDetail : NSObject

@property (nonatomic, assign) NSInteger ci2_id;
@property (nonatomic, assign) NSInteger ci3_id;
@property (nonatomic, copy) NSString *ci3_name;

+ (instancetype)dataWithDict:(NSDictionary *)dict;

@end
