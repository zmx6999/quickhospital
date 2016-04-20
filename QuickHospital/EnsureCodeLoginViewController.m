//
//  EnsureCodeLoginViewController.m
//  QuickHospital
//
//  Created by zmx on 16/3/29.
//  Copyright © 2016年 zmx. All rights reserved.
//

#import "EnsureCodeLoginViewController.h"
#import "BorderAndCornerTool.h"
#import "RegisterViewController.h"
#import "PwdLoginViewController.h"
#import "ForgetPwdViewController.h"

@interface EnsureCodeLoginViewController ()

@property (weak, nonatomic) IBOutlet UIView *phoneView;
@property (weak, nonatomic) IBOutlet UITextField *phoneText;

@property (weak, nonatomic) IBOutlet UIView *ensureView;
@property (weak, nonatomic) IBOutlet UITextField *ensureText;
@property (weak, nonatomic) IBOutlet UIView *ensureButton;

@end

@implementation EnsureCodeLoginViewController

- (IBAction)reg:(id)sender {
    if ([Nav popToViewControllerOfClass:[RegisterViewController class]]) {
        return;
    }
    
    RegisterViewController *rvc = [[RegisterViewController alloc] init];
    [self.navigationController pushViewController:rvc animated:YES];
}

- (IBAction)loginByPwd:(id)sender {
    if ([Nav popToViewControllerOfClass:[PwdLoginViewController class]]) {
        return;
    }
    
    EnsureCodeLoginViewController *evc = [[EnsureCodeLoginViewController alloc] init];
    [self.navigationController pushViewController:evc animated:YES];
}

- (IBAction)forgetPwd:(id)sender {
    ForgetPwdViewController *fvc = [[ForgetPwdViewController alloc] init];
    [self.navigationController pushViewController:fvc animated:YES];
}

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
