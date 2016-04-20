//
//  WeatherViewModel.h
//  QuickHospital
//
//  Created by zmx on 16/3/25.
//  Copyright © 2016年 zmx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeatherViewModel : NSObject

+ (void)getWeatherWithCityName:(NSString *)cityName responseHandler:(void (^)(NSString *cond, NSString *tmp))responseHandler;

@end