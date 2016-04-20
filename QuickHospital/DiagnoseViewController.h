//
//  DiagnoseViewController.h
//  QuickHospital
//
//  Created by zmx on 16/3/26.
//  Copyright © 2016年 zmx. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Diagnose;

typedef void(^ChooseDiagnose)(Diagnose *diagnose);

@interface DiagnoseViewController : UITableViewController

@property (nonatomic, strong) Diagnose *choosedDiagnose;
@property (nonatomic, copy) ChooseDiagnose chooseDiagnose;

@end
