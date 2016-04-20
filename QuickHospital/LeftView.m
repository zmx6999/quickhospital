//
//  LeftView.m
//  QuickHospital
//
//  Created by zmx on 16/3/29.
//  Copyright © 2016年 zmx. All rights reserved.
//

#import "LeftView.h"

@interface LeftView ()

@property (weak, nonatomic) IBOutlet UIImageView *avatarView;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;

@end

@implementation LeftView

- (IBAction)login:(id)sender {
    if ([self.delegate respondsToSelector:@selector(leftViewWillLogin:)]) {
        [self.delegate leftViewWillLogin:self];
    }
}

- (IBAction)reg:(id)sender {
    if ([self.delegate respondsToSelector:@selector(leftViewWillRegister:)]) {
        [self.delegate leftViewWillRegister:self];
    }
}

- (void)awakeFromNib {
    self.avatarView.layer.cornerRadius = 30;
    self.avatarView.layer.masksToBounds = YES;
    
    self.loginButton.layer.borderColor = [UIColor whiteColor].CGColor;
    self.loginButton.layer.borderWidth = 1;
    
    self.registerButton.layer.borderColor = [UIColor whiteColor].CGColor;
    self.registerButton.layer.borderWidth = 1;
}

@end