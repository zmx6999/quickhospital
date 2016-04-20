//
//  ReceivingSettingCell.m
//  QuickHospital
//
//  Created by zmx on 16/3/28.
//  Copyright © 2016年 zmx. All rights reserved.
//

#import "ReceivingSettingCell.h"
#import "ReceivingSettingViewController.h"

@interface ReceivingSettingCell ()

@property (nonatomic, weak) UIView *view;
@property (nonatomic, strong) ReceivingSettingViewController *rsvc;

@end

@implementation ReceivingSettingCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    [self setupUI];
    return self;
}

- (void)setupUI {
    self.rsvc = [[ReceivingSettingViewController alloc] init];
    self.view = self.rsvc.view;
    [self addSubview:self.view];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.view.frame = self.bounds;
}

- (void)setDoctor:(Doctor *)doctor {
    _doctor = doctor;
    self.rsvc.doctor = doctor;
}

@end
