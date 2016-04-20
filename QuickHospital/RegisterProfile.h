//
//  RegisterProfile.h
//  QuickHospital
//
//  Created by zmx on 16/4/4.
//  Copyright © 2016年 zmx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RegisterProfile : NSObject

@property (nonatomic, copy) NSString *mobile_number;
@property (nonatomic, copy) NSString *sms_code;
@property (nonatomic, copy) NSString *invite_code;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *password_confirm;

@end