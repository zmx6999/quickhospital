//
//  RegisterViewController.m
//  QuickHospital
//
//  Created by zmx on 16/3/28.
//  Copyright © 2016年 zmx. All rights reserved.
//

#import "RegisterViewController.h"
#import "BorderAndCornerTool.h"
#import "PwdLoginViewController.h"
#import "RegisterProfile.h"
#import "ProfileViewModel.h"

@interface RegisterViewController ()

@property (weak, nonatomic) IBOutlet UIView *phoneView;
@property (weak, nonatomic) IBOutlet UITextField *phoneText;

@property (weak, nonatomic) IBOutlet UIView *ensureView;
@property (weak, nonatomic) IBOutlet UITextField *ensureText;
@property (weak, nonatomic) IBOutlet UIView *ensureButton;
@property (weak, nonatomic) IBOutlet UILabel *ensureButtonText;

@property (weak, nonatomic) IBOutlet UIView *inviteView;
@property (weak, nonatomic) IBOutlet UITextField *inviteText;

@property (weak, nonatomic) IBOutlet UIButton *agreeButton;
@property (weak, nonatomic) IBOutlet UILabel *protocolLabel;

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation RegisterViewController

- (IBAction)smsCode:(UITapGestureRecognizer *)sender {
    if (self.timer) {
        return;
    }
    
    if (!self.phoneText.text.isValidPhoneNumber) {
        [MBProgressHUD showErrorWithStatus:@"请输入正确的手机号" inView:self.view];
        return;
    }
    
    [self setupTimer];
    
    [ProfileViewModel getSmsCodeWithMobileNumber:self.phoneText.text completionHandler:^(NSString *msg) {
        if (![msg isEqualToString:@"OK"]) {
            [MBProgressHUD showErrorWithStatus:msg inView:self.view];
            [self removeTimer];
            return;
        }
    }];
}

- (IBAction)next:(id)sender {
    if (!self.phoneText.text.isValidPhoneNumber) {
        [MBProgressHUD showErrorWithStatus:@"请输入正确的手机号" inView:self.view];
        return;
    }
    
    if (!self.agreeButton.selected) {
        [MBProgressHUD showErrorWithStatus:@"请勾选用户协议" inView:self.view];
        return;
    }
    
    RegisterProfile *profile = [[RegisterProfile alloc] init];
    profile.mobile_number = self.phoneText.text;
    profile.sms_code = self.ensureText.text;
    profile.invite_code = self.inviteText.text;
    [ProfileViewModel registerS1WithProfileInfo:profile completionHandler:^(NSString *msg) {
        if (![msg isEqualToString:@"OK"]) {
            [MBProgressHUD showErrorWithStatus:msg inView:self.view];
            return;
        }
        NSLog(@"ok");
    }];
}

- (IBAction)login:(id)sender {
    if ([Nav popToViewControllerOfClass:[PwdLoginViewController class]]) {
        return;
    }
    
    PwdLoginViewController *lvc = [[PwdLoginViewController alloc] init];
    [self.navigationController pushViewController:lvc animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupUI];
}

- (void)setupUI {
    [BorderAndCornerTool setBorderAndCornerWithView:self.phoneView];
    [BorderAndCornerTool setBorderAndCornerWithView:self.ensureView];
    [BorderAndCornerTool setBorderAndCornerWithView:self.inviteView];
    [BorderAndCornerTool setBorderAndCornerWithView:self.ensureButton borderColor:ThemeFontColor];
    
    NSMutableAttributedString *aStrM = [[NSMutableAttributedString alloc] initWithString:self.protocolLabel.text];
    [aStrM addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleSingle | NSUnderlinePatternSolid) range:NSMakeRange(0, aStrM.length)];
    [aStrM addAttribute:NSUnderlineColorAttributeName value:[UIColor blueColor] range:NSMakeRange(0, aStrM.length)];
    self.protocolLabel.attributedText = aStrM;
}

- (void)setupTimer {
    self.ensureButton.backgroundColor = [UIColor lightGrayColor];
    self.ensureButton.layer.borderColor = self.ensureView.backgroundColor.CGColor;
    self.ensureButtonText.textColor = [UIColor whiteColor];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
    [self.timer fire];
}

- (void)removeTimer {
    self.ensureButton.backgroundColor = [UIColor whiteColor];
    self.ensureButton.layer.borderColor = ThemeFontColor.CGColor;
    self.ensureButtonText.textColor = ThemeFontColor;
    self.ensureButtonText.text = @"获取验证码";
    
    [self.timer invalidate];
    self.timer = nil;
}

- (void)updateTimer {
    static int time = 60;
    
    if (time < 1) {
        [self removeTimer];
        return;
    }
    
    self.ensureButtonText.text = [NSString stringWithFormat:@"%d秒", --time];
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