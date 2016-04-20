//
//  TimeHeaderCell.h
//  QuickHospital
//
//  Created by zmx on 16/3/28.
//  Copyright © 2016年 zmx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimeCell : UICollectionViewCell

@property (nonatomic, strong) NSDate *date;
@property (nonatomic, assign) BOOL blank;
@property (nonatomic, assign) BOOL choosed;

@end
