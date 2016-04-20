//
//  Disease.h
//  QuickHospital
//
//  Created by zmx on 16/3/27.
//  Copyright © 2016年 zmx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Disease : NSObject

@property (nonatomic, assign) NSInteger ci1_id;
@property (nonatomic, assign) NSInteger ci2_id;
@property (nonatomic, assign) NSInteger ci3_id;
@property (nonatomic, assign) NSInteger diagnosis_type;
@property (nonatomic, assign) NSInteger is_confirmed;
@property (nonatomic, strong) NSArray *complications;
@property (nonatomic, assign) NSInteger has_diagnosis;

@property (nonatomic, assign) NSInteger page_size;
@property (nonatomic, assign) NSInteger page;

- (NSArray *)getProperties;

@end
