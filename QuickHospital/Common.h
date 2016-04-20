//
//  Common.h
//  QuickHospital
//
//  Created by zmx on 16/3/23.
//  Copyright © 2016年 zmx. All rights reserved.
//


#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "Masonry.h"

#import "NetworkManager.h"
#import "NavigationController.h"
#import "UIView+IFS.h"
#import "MBProgressHUD+IFS.h"
#import "NSString+IFS.h"

#define BaseUrlStr @"https://api.carelink.cn"

#define SharedNetworkManager [NetworkManager sharedManager]

#define ScreenBounds ([UIScreen mainScreen].bounds)
#define ScreenSize (ScreenBounds.size)
#define ScreenW (ScreenSize.width)
#define ScreenH (ScreenSize.height)

#define BaiduApiKey @"2a80593d01fdd89c16668165c67a88e2"

#define NotificationCenter [NSNotificationCenter defaultCenter]
#define DidChooseCityNotificationName @"DidChooseCityNotificationName"
#define CityUserInfoKey @"city"

#define Color(r, g, b) [UIColor colorWithRed:(r) / 255.0 green:(g) / 255.0 blue:(b) / 255.0 alpha:1.0]
#define ThemeColor Color(20, 163, 155)
#define ThemeFontColor Color(38, 188, 185)

#define Nav ((NavigationController *)self.navigationController)