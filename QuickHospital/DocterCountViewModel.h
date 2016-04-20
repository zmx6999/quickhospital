//
//  DocterCountViewModel.h
//  QuickHospital
//
//  Created by zmx on 16/3/23.
//  Copyright © 2016年 zmx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DocterCountViewModel : NSObject

+ (void)getDocterCountWithCi1Id:(NSInteger)ci1Id responseHandler:(void (^)(NSInteger count))responseHandler;

@end
