//
//  WeatherViewModel.m
//  QuickHospital
//
//  Created by zmx on 16/3/25.
//  Copyright © 2016年 zmx. All rights reserved.
//

#import "WeatherViewModel.h"

@implementation WeatherViewModel

+ (void)getWeatherWithCityName:(NSString *)cityName responseHandler:(void (^)(NSString *, NSString *))responseHandler {
    NSDictionary *params = @{
                             @"city": cityName
                             };
    [SharedNetworkManager.requestSerializer setValue:BaiduApiKey forHTTPHeaderField:@"apikey"];
    [SharedNetworkManager GET:@"http://apis.baidu.com/heweather/weather/free" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *services = [responseObject objectForKey:@"HeWeather data service 3.0"];
        NSDictionary *service = services.firstObject;
        NSArray *forcasts = [service objectForKey:@"daily_forecast"];
        NSDictionary *forcast = forcasts.firstObject;
        NSString *cond = [[forcast objectForKey:@"cond"] objectForKey:@"txt_d"];
        NSDictionary *tmp = [forcast objectForKey:@"tmp"];
        NSString *max = [tmp objectForKey:@"max"];
        NSString *min = [tmp objectForKey:@"min"];
        responseHandler(cond, [NSString stringWithFormat:@"%@ ~ %@", max, min]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        responseHandler(nil, nil);
        NSLog(@"%@", error);
    }];
}

@end
