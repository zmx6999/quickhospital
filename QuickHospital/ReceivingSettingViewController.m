//
//  ReceivingSettingViewController.m
//  QuickHospital
//
//  Created by zmx on 16/3/28.
//  Copyright © 2016年 zmx. All rights reserved.
//

#import "ReceivingSettingViewController.h"
#import "DoctorViewModel.h"

@interface ReceivingSettingViewController ()

@property (weak, nonatomic) IBOutlet UILabel *receivingSettingLabel;

@end

@implementation ReceivingSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated {
    [DoctorViewModel getReceivingSettingOfDoctor:self.doctor completionHandler:^(NSArray *receivingSettings) {
        NSMutableString *strM = [NSMutableString string];
        for (NSString *str in receivingSettings) {
            [strM appendString:[NSString stringWithFormat:@"%@\n", str]];
        }
        self.receivingSettingLabel.text = strM;
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
