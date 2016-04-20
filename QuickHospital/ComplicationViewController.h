//
//  ComplicationViewController.h
//  QuickHospital
//
//  Created by zmx on 16/3/26.
//  Copyright © 2016年 zmx. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ChooseComplication)(NSArray *complications);

@interface ComplicationViewController : UITableViewController

@property (nonatomic, assign) NSInteger ci2Id;
@property (nonatomic, strong) NSMutableArray *choosedComplications;
@property (nonatomic, copy) ChooseComplication chooseComplication;

@end
