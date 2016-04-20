//
//  NavigationController.h
//  QuickHospital
//
//  Created by zmx on 16/3/23.
//  Copyright © 2016年 zmx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NavigationController : UINavigationController

- (BOOL)popToViewControllerOfClass:(Class)viewControllerClass;

@end
