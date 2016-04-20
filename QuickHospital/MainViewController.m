//
//  MainViewController.m
//  QuickHospital
//
//  Created by zmx on 16/3/30.
//  Copyright © 2016年 zmx. All rights reserved.
//

#import "MainViewController.h"
#import "HomeViewController.h"
#import "LeftView.h"
#import "PwdLoginViewController.h"
#import "RegisterViewController.h"

@interface MainViewController () <LeftViewDelegate>

@property (nonatomic, strong) NavigationController *rootVC;
@property (nonatomic, weak) LeftView *leftView;
@property (nonatomic, weak) UIButton *coverButton;

@property (nonatomic, strong) MASConstraint *constraint;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
}

- (void)setupUI {
    HomeViewController *hvc = [UIStoryboard storyboardWithName:@"Main" bundle:nil].instantiateInitialViewController;
    hvc.mainViewController = self;
    self.rootVC = [[NavigationController alloc] initWithRootViewController:hvc];
    [self.view addSubview:self.rootVC.view];
    
    LeftView *leftView = [[[NSBundle mainBundle] loadNibNamed:@"LeftView" owner:nil options:nil] firstObject];
    self.leftView = leftView;
    self.leftView.delegate = self;
    [self.view addSubview:self.leftView];
    
    UIButton *coverButton = [[UIButton alloc] init];
    self.coverButton = coverButton;
    self.coverButton.hidden = YES;
    [self.coverButton addTarget:self action:@selector(hideLeftView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.coverButton];
    
    [self.rootVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        self.constraint = make.left.equalTo(self.view);
        make.top.equalTo(self.view);
        make.width.mas_equalTo(ScreenW);
        make.height.mas_equalTo(ScreenH);
    }];
    
    [self.leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.right.equalTo(self.rootVC.view.mas_left);
        make.width.mas_equalTo(ScreenW * 0.67);
        make.height.mas_equalTo(ScreenH);
    }];
    
    [self.coverButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.width.height.equalTo(self.rootVC.view);
    }];
}

- (void)showLeftView {
    [UIView animateWithDuration:0.25 animations:^{
        [self.constraint uninstall];
        [self.rootVC.view mas_updateConstraints:^(MASConstraintMaker *make) {
            self.constraint = make.left.equalTo(self.view).offset(ScreenW * 0.67);
        }];
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        self.coverButton.hidden = NO;
    }];
}

- (void)hideLeftView {
    [UIView animateWithDuration:0.25 animations:^{
        [self.constraint uninstall];
        [self.rootVC.view mas_updateConstraints:^(MASConstraintMaker *make) {
            self.constraint = make.left.equalTo(self.view);
        }];
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        self.coverButton.hidden = YES;
    }];
}

- (void)leftViewWillLogin:(LeftView *)leftView {
    [self hideLeftView];
    [self.rootVC pushViewController:[[PwdLoginViewController alloc] init] animated:YES];
}

- (void)leftViewWillRegister:(LeftView *)leftView {
    [self hideLeftView];
    [self.rootVC pushViewController:[[RegisterViewController alloc] init] animated:YES];
}

@end
