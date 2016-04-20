//
//  ForgetPwdViewController.m
//  QuickHospital
//
//  Created by zmx on 16/3/29.
//  Copyright © 2016年 zmx. All rights reserved.
//

#import "ForgetPwdViewController.h"
#import "BorderAndCornerTool.h"

@interface ForgetPwdViewController ()

@property (weak, nonatomic) IBOutlet UIView *phoneView;
@property (weak, nonatomic) IBOutlet UITextField *phoneText;

@property (weak, nonatomic) IBOutlet UIView *ensureView;
@property (weak, nonatomic) IBOutlet UITextField *ensureText;

@property (weak, nonatomic) IBOutlet UIView *ensureButton;

@end

@implementation ForgetPwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [BorderAndCornerTool setBorderAndCornerWithView:self.phoneView];
    [BorderAndCornerTool setBorderAndCornerWithView:self.ensureView];
    [BorderAndCornerTool setBorderAndCornerWithView:self.ensureButton borderColor:ThemeFontColor];
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
