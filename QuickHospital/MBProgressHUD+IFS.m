//
//  MBProgressHUD+IFS.m
//  QuickHospital
//
//  Created by zmx on 16/4/4.
//  Copyright © 2016年 zmx. All rights reserved.
//

#import "MBProgressHUD+IFS.h"

@implementation MBProgressHUD (IFS)

+ (void)showErrorWithStatus:(NSString *)status inView:(UIView *)view {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = status;
    [hud hide:YES afterDelay:1.0];
}

@end