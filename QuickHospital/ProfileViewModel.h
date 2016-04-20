//
//  ProfileViewModel.h
//  QuickHospital
//
//  Created by zmx on 16/4/4.
//  Copyright © 2016年 zmx. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RegisterProfile;

@interface ProfileViewModel : NSObject

+ (void)getSmsCodeWithMobileNumber:(NSString *)mobileNumber completionHandler:(void (^)(NSString *msg))completionHandler;
+ (void)registerS1WithProfileInfo:(RegisterProfile *)registerProfile completionHandler:(void (^)(NSString *msg))completionHandler;

@end
