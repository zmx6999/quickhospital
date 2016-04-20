//
//  DiagnoseTimeViewController.m
//  QuickHospital
//
//  Created by zmx on 16/3/28.
//  Copyright © 2016年 zmx. All rights reserved.
//

#import "DiagnoseTimeViewController.h"
#import "Doctor.h"
#import "TimeCell.h"

#define identifier @"diagnoseTime"
#define col 7
#define margin 1

@interface DiagnoseTimeViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *spotView;
@property (weak, nonatomic) IBOutlet UILabel *hospitalLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *layout;

@property (nonatomic, strong) NSIndexPath *choosedIndexPath;

@end

@implementation DiagnoseTimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.collectionView registerNib:[UINib nibWithNibName:@"TimeCell" bundle:nil] forCellWithReuseIdentifier:identifier];
    
    self.hospitalLabel.text = self.doctor.doctor_hospital_name;
    self.spotView.layer.cornerRadius = 3;
    self.spotView.layer.masksToBounds = YES;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.layout.itemSize = CGSizeMake((self.collectionView.frame.size.width - margin * (col - 1)) / col, 60);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 28;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TimeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    cell.blank = (indexPath.item > 6);
    if (!cell.blank) {
        cell.date = [NSDate dateWithTimeIntervalSinceNow:3600 * 24 * (indexPath.item + 1)];
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    TimeCell *cell = (TimeCell *)[collectionView cellForItemAtIndexPath:indexPath];
    if (cell.blank) {
        cell.choosed = YES;
        TimeCell *choosedCell = (TimeCell *)[collectionView cellForItemAtIndexPath:self.choosedIndexPath];
        choosedCell.choosed = NO;
        self.choosedIndexPath = indexPath;
    }
}

@end
