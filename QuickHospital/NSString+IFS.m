//
//  NSString+IFS.m
//  QuickHospital
//
//  Created by zmx on 16/4/4.
//  Copyright © 2016年 zmx. All rights reserved.
//

#import "NSString+IFS.h"

@implementation NSString (IFS)

- (BOOL)isValidPhoneNumber {
    if (self.length != 11) {
        return NO;
    }
    
    NSString *pattern = @"^1[3|5|7|8][0-9]{9}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    return [predicate evaluateWithObject:self];
}

@end
