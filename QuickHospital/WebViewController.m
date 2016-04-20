//
//  WebViewController.m
//  QuickHospital
//
//  Created by zmx on 16/3/26.
//  Copyright © 2016年 zmx. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController () <UIWebViewDelegate>

@property (nonatomic, weak) UIWebView *webView;

@end

@implementation WebViewController

- (void)loadView {
    self.view = [[UIWebView alloc] init];
    self.webView = (UIWebView *)self.view;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.webView.delegate = self;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlstr]]];
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"加载中";
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [self webViewDidFinishLoad:webView];
    [MBProgressHUD showErrorWithStatus:@"网络不给力" inView:self.view];
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
