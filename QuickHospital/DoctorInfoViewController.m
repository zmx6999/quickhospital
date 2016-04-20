//
//  DoctorInfoViewController.m
//  QuickHospital
//
//  Created by zmx on 16/3/28.
//  Copyright © 2016年 zmx. All rights reserved.
//

#import "DoctorInfoViewController.h"
#import "Doctor.h"
#import "DoctorViewModel.h"
#import "ReceivingSettingCell.h"
#import "IntroductionCell.h"
#import "DiagnoseTimeCell.h"
#import "IFSButton.h"

#define receivingSettingIdentifier @"receivingSetting"
#define introductionIdentifier @"introduction"
#define diagnoseTimeIdentifier @"diagnoseTime"

@interface DoctorInfoViewController () <UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UIImageView *genderView;
@property (weak, nonatomic) IBOutlet UILabel *nameAndTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *hospitalAndDepartmentLabel;
@property (weak, nonatomic) IBOutlet UILabel *operationLabel;
@property (weak, nonatomic) IBOutlet UILabel *flowerLabel;
@property (weak, nonatomic) IBOutlet UILabel *bannerLabel;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *layout;
@property (weak, nonatomic) IBOutlet UIView *slideView;

@property (weak, nonatomic) IBOutlet IFSButton *receivingSettingButton;
@property (nonatomic, weak) IFSButton *selectedButton;

@end

@implementation DoctorInfoViewController

- (IBAction)chooseInfo:(IFSButton *)sender {
    self.selectedButton.selected = NO;
    sender.selected = YES;
    self.selectedButton = sender;
    
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:sender.tag inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    
    [UIView animateWithDuration:0.25 animations:^{
        self.slideView.transform = CGAffineTransformMakeTranslation(ScreenW / 3 * sender.tag, 0);
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupUI];
    [DoctorViewModel getDepartmentNameOfDoctor:self.doctor completionHandler:^(NSString *department) {
        if (department == nil) {
            return;
        }
        
        self.doctor.department_name = department;
        self.hospitalAndDepartmentLabel.text = [NSString stringWithFormat:@"%@-%@", self.doctor.doctor_hospital_name, self.doctor.department_name];
    }];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.layout.itemSize = self.collectionView.frame.size;
}

- (void)setupUI {
    self.genderView.image = (self.doctor.doctor_gender == 1 ?[UIImage imageNamed:@"male"] : [UIImage imageNamed:@"female"]);
    self.genderView.layer.cornerRadius = 20;
    self.genderView.layer.masksToBounds = YES;
    
    self.nameAndTitleLabel.text = [NSString stringWithFormat:@"%@ %@", self.doctor.doctor_name, self.doctor.doctor_title_name];
    self.hospitalAndDepartmentLabel.text = [NSString stringWithFormat:@"%@", self.doctor.doctor_hospital_name];
    self.operationLabel.text = [NSString stringWithFormat:@"预约量:%ld", self.doctor.operation_count];
    self.flowerLabel.text = [NSString stringWithFormat:@"鲜花量:%ld", self.doctor.flower];
    self.bannerLabel.text = [NSString stringWithFormat:@"锦旗数:%ld", self.doctor.banner];
    
    [self.collectionView registerClass:[ReceivingSettingCell class] forCellWithReuseIdentifier:receivingSettingIdentifier];
    [self.collectionView registerClass:[IntroductionCell class] forCellWithReuseIdentifier:introductionIdentifier];
    [self.collectionView registerClass:[DiagnoseTimeCell class] forCellWithReuseIdentifier:diagnoseTimeIdentifier];
    
    self.selectedButton = self.receivingSettingButton;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.item == 0) {
        ReceivingSettingCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:receivingSettingIdentifier forIndexPath:indexPath];
        cell.doctor = self.doctor;
        return cell;
    } else if (indexPath.item == 1) {
        IntroductionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:introductionIdentifier forIndexPath:indexPath];
        cell.doctor = self.doctor;
        return cell;
    } else {
        DiagnoseTimeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:diagnoseTimeIdentifier forIndexPath:indexPath];
        cell.doctor = self.doctor;
        return cell;
    }
}

@end