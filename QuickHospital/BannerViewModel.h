//
//  BannerViewModel.h
//  QuickHospital
//
//  Created by zmx on 16/3/23.
//  Copyright © 2016年 zmx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BannerViewModel : NSObject

+ (void)getBannerDataWithResponseHandler:(void (^)(NSArray *dataArr))responseHandler;

@end
