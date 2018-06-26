//
//  UIWebView_URL.m
//  StudyDemo
//
//  Created by 曾龙 on 2018/1/8.
//  Copyright © 2018年 曾龙. All rights reserved.
//

#import "UIWebView_URL.h"
#import <AVFoundation/AVFoundation.h>
@interface UIWebView_URL ()<UIWebViewDelegate>
@property(nonatomic ,strong)UIWebView *webView;
@end

@implementation UIWebView_URL

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"UIWebView+URL";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"给力" style:UIBarButtonItemStylePlain target:self action:@selector(sendInfoToJS)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    NSURL *htmlURL = [[NSBundle mainBundle] URLForResource:@"index2.html" withExtension:nil];
    [self.webView loadRequest:[NSURLRequest requestWithURL:htmlURL]];
    self.webView.delegate = self;
    self.webView.scrollView.bounces = NO;
    [self.view addSubview:self.webView];
    
    if (iOS11Later) {
        adjustsScrollViewInsets_NO(self.webView.scrollView, self);
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

- (void)sendInfoToJS {
    [self.webView stringByEvaluatingJavaScriptFromString:@"receiveInfo(\"欧力给\")"];
}

- (void)handleCustomAction:(NSURL *)url {
    NSString *host = [url host];
    if ([host isEqualToString:@"sendAlert"]) {
        [self sendAlert:url];
    } else if ([host isEqualToString:@"openLight"]) {
        [self openLight];
    }
}

- (void)sendAlert:(NSURL *)url {
    NSArray *params = [url.query componentsSeparatedByString:@"="];
    if (params.count>1) {
        [MBProgressHUD showError:[params[1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }
}

- (void)openLight {
    AVCaptureDevice * device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (device.torchMode == AVCaptureTorchModeOn) {
        [device lockForConfiguration:nil];
        [device setTorchMode:AVCaptureTorchModeOff];
        [device unlockForConfiguration];
    } else {
        [device lockForConfiguration:nil];
        [device setTorchMode:AVCaptureTorchModeOn];
        [device unlockForConfiguration];
    }
    [self updateLightState];
}

- (void)updateLightState {
    AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if ([captureDevice hasTorch]) {
        [self.webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"updateLightState(%d)",captureDevice.torchMode==AVCaptureTorchModeOn?1:0]];
    }
}

#pragma mark -UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSURL *URL = request.URL;
    NSString *scheme = [URL scheme];
    if ([scheme isEqualToString:@"haleyaction"]) {
        [self handleCustomAction:URL];
        return NO;
    }
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self updateLightState];
}




@end
