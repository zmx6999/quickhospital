//
//  NavigationController.m
//  QuickHospital
//
//  Created by zmx on 16/3/23.
//  Copyright © 2016年 zmx. All rights reserved.
//

#import "NavigationController.h"

@interface NavigationController ()

@end

@implementation NavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationBar.barTintColor = ThemeColor;
    self.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationBar.translucent = NO;
    
    self.navigationBar.titleTextAttributes = @{
                                               NSForegroundColorAttributeName: [UIColor whiteColor],
                                               NSFontAttributeName: [UIFont systemFontOfSize:18]
                                               };
}

- (BOOL)popToViewControllerOfClass:(Class)viewControllerClass {
    NSArray *viewControllers = self.childViewControllers;
    for (NSInteger i = viewControllers.count - 1; i >= 0; i--) {
        UIViewController *viewController = viewControllers[i];
        if ([viewController isKindOfClass:viewControllerClass]) {
            [self popToViewController:viewController animated:YES];
            return YES;
        }
    }
    return NO;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
