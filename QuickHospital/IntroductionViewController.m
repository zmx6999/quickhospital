//
//  IntroductionViewController.m
//  QuickHospital
//
//  Created by zmx on 16/3/28.
//  Copyright © 2016年 zmx. All rights reserved.
//

#import "IntroductionViewController.h"
#import "DoctorViewModel.h"

@interface IntroductionViewController ()
@property (weak, nonatomic) IBOutlet UILabel *introductionLabel;

@end

@implementation IntroductionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated {
    [DoctorViewModel getIntroductionOfDoctor:self.doctor completionHandler:^(NSString *introduction) {
        self.introductionLabel.text = introduction;
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
