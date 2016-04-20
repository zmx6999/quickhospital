//
//  NetworkManager.m
//  QuickHospital
//
//  Created by zmx on 16/3/23.
//  Copyright © 2016年 zmx. All rights reserved.
//

#import "NetworkManager.h"

static NetworkManager *_instance;

@implementation NetworkManager

+ (instancetype)sharedManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] initWithBaseURL:[NSURL URLWithString:BaseUrlStr]];
        
        _instance.requestSerializer = [AFJSONRequestSerializer serializer];
        [_instance.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        
        _instance.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain", nil];
    });
    return _instance;
}

@end
