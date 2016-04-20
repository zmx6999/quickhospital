//
//  DoctorCell.m
//  QuickHospital
//
//  Created by zmx on 16/3/27.
//  Copyright © 2016年 zmx. All rights reserved.
//

#import "DoctorCell.h"
#import "Doctor.h"

@interface DoctorCell ()

@property (weak, nonatomic) IBOutlet UIImageView *genderView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *hospitalLabel;

@property (weak, nonatomic) IBOutlet UILabel *operatorCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *flowerLabel;
@property (weak, nonatomic) IBOutlet UILabel *bannerLabel;

@property (weak, nonatomic) IBOutlet UILabel *accuracyLabel;

@end

@implementation DoctorCell

- (void)setDoctor:(Doctor *)doctor {
    _doctor = doctor;
    
    self.genderView.image = (doctor.doctor_gender == 1 ?[UIImage imageNamed:@"male"] : [UIImage imageNamed:@"female"]);
    self.genderView.layer.cornerRadius = 30;
    self.genderView.layer.masksToBounds = YES;
    
    self.nameLabel.text = doctor.doctor_name;
    self.titleLabel.text = doctor.doctor_title_name;
    self.hospitalLabel.text = doctor.doctor_hospital_name;
    
    self.operatorCountLabel.text = [NSString stringWithFormat:@"%ld", doctor.operation_count];
    self.flowerLabel.text = [NSString stringWithFormat:@"%ld", doctor.flower];
    self.bannerLabel.text = [NSString stringWithFormat:@"%ld", doctor.banner];
    self.accuracyLabel.text = doctor.accuracy;
}

@end
