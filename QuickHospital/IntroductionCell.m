//
//  IntroductionCell.m
//  QuickHospital
//
//  Created by zmx on 16/3/28.
//  Copyright © 2016年 zmx. All rights reserved.
//

#import "IntroductionCell.h"
#import "IntroductionViewController.h"

@interface IntroductionCell ()

@property (nonatomic, weak) UIView *view;
@property (nonatomic, strong) IntroductionViewController *ivc;

@end

@implementation IntroductionCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    [self setupUI];
    return self;
}

- (void)setupUI {
    self.ivc = [[IntroductionViewController alloc] init];
    self.view = self.ivc.view;
    [self addSubview:self.view];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.view.frame = self.bounds;
}

- (void)setDoctor:(Doctor *)doctor {
    _doctor = doctor;
    self.ivc.doctor = doctor;
}

@end
