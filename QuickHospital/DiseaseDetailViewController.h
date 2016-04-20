//
//  DiseaseDetailViewController.h
//  QuickHospital
//
//  Created by zmx on 16/3/22.
//  Copyright © 2016年 zmx. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ChooseDetail)(NSString *name, NSInteger ci2Id, NSInteger ci3Id);

@interface DiseaseDetailViewController : UITableViewController

@property (nonatomic, assign) NSInteger ci1Id;
@property (nonatomic, copy) ChooseDetail chooseDetail;

@end
