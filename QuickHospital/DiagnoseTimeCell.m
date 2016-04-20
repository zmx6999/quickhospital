//
//  DiagnoseTimeCell.m
//  QuickHospital
//
//  Created by zmx on 16/3/28.
//  Copyright © 2016年 zmx. All rights reserved.
//

#import "DiagnoseTimeCell.h"
#import "DiagnoseTimeViewController.h"

@interface DiagnoseTimeCell ()

@property (nonatomic,weak) UIView *view;
@property (nonatomic, strong) DiagnoseTimeViewController *dtvc;

@end

@implementation DiagnoseTimeCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    [self setupUI];
    return self;
}

- (void)setupUI {
    self.dtvc = [[DiagnoseTimeViewController alloc] init];
    self.view = self.dtvc.view;
    [self addSubview:self.view];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.view.frame = self.bounds;
}

- (void)setDoctor:(Doctor *)doctor {
    _doctor = doctor;
    self.dtvc.doctor = doctor;
}

@end
