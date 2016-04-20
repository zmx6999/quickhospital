//
//  TimeHeaderCell.m
//  QuickHospital
//
//  Created by zmx on 16/3/28.
//  Copyright © 2016年 zmx. All rights reserved.
//

#import "TimeCell.h"

@interface TimeCell ()

@property (weak, nonatomic) IBOutlet UILabel *dayLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end

@implementation TimeCell

- (void)setDate:(NSDate *)date {
    _date = date;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    formatter.dateFormat = @"EEE";
    self.dayLabel.text = [formatter stringFromDate:date];
    
    formatter.dateFormat = @"MM-dd";
    self.dateLabel.text = [formatter stringFromDate:date];
}

- (void)setBlank:(BOOL)blank {
    _blank = blank;
    
    if (blank) {
        self.dayLabel.hidden = YES;
        self.dateLabel.hidden = YES;
    } else {
        self.dayLabel.hidden = NO;
        self.dateLabel.hidden = NO;
    }
}

- (void)setChoosed:(BOOL)choosed {
    if (!self.blank) {
        return;
    }
    
    _choosed = choosed;
    
    if (choosed) {
        self.backgroundColor = Color(164, 251, 244);
    } else {
        self.backgroundColor = [UIColor whiteColor];
    }
}

@end