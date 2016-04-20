//
//  UIView+IFS.m
//  QuickHospital
//
//  Created by zmx on 16/3/29.
//  Copyright © 2016年 zmx. All rights reserved.
//

#import "UIView+IFS.h"

@implementation UIView (IFS)

- (UIViewController *)getViewController {
    UIResponder *responder = self.nextResponder;
    while (responder) {
        if ([responder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)responder;
        }
        responder = responder.nextResponder;
    }
    return nil;
}

- (UINavigationController *)getNavigationController {
    UIResponder *responder = self.nextResponder;
    while (responder) {
        if ([responder isKindOfClass:[UINavigationController class]]) {
            return (UINavigationController *)responder;
        }
        responder = responder.nextResponder;
    }
    return nil;
}

@end
