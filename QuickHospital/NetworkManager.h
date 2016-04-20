//
//  NetworkManager.h
//  QuickHospital
//
//  Created by zmx on 16/3/23.
//  Copyright © 2016年 zmx. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface NetworkManager : AFHTTPSessionManager

+ (instancetype)sharedManager;

@end
