//
//  WKWebView_URL.m
//  StudyDemo
//
//  Created by 曾龙 on 2018/1/8.
//  Copyright © 2018年 曾龙. All rights reserved.
//

#import "WKWebView_URL.h"
#import <WebKit/WebKit.h>
#import <AVFoundation/AVFoundation.h>
@interface WKWebView_URL ()<WKNavigationDelegate>
@property (nonatomic ,strong)WKWebView *webView;
@end

@implementation WKWebView_URL

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"WKWebView_URL";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"给力" style:UIBarButtonItemStylePlain target:self action:@selector(sendInfoToJS)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    WKPreferences *preferences = [WKPreferences new];
    preferences.javaScriptCanOpenWindowsAutomatically = YES;
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    configuration.preferences = preferences;
    
    self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-Navi_Height) configuration:configuration];
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"index2.html" withExtension:nil];
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
    self.webView.scrollView.bounces = NO;
    self.webView.navigationDelegate = self;
    [self.view addSubview:self.webView];
    
    if (iOS11Later) {
        adjustsScrollViewInsets_NO(self.webView.scrollView, self);
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    //监听是否加载完毕
    [self.webView addObserver:self forKeyPath:@"loading" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)sendInfoToJS {
    [self.webView evaluateJavaScript:@"receiveInfo(\"欧力给\")" completionHandler:^(id _Nullable info, NSError * _Nullable error) {
        NSLog(@"发送成功");
    }];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"loading"]) {
        //监听加载情况，加载完毕后，将闪光灯的状态传给H5界面
        if (!self.webView.loading) {
            [self updateLightState];
        }
    }
}

- (void)updateLightState {
    AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if ([captureDevice hasTorch]) {
        [self.webView evaluateJavaScript:[NSString stringWithFormat:@"updateLightState(%d)",captureDevice.torchMode==AVCaptureTorchModeOn?1:0] completionHandler:^(id _Nullable info, NSError * _Nullable error) {
            NSLog(@"发送成功");
        }];
    }
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

#pragma mark -WKNavigationDelegate
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    NSURL *url = navigationAction.request.URL;
    NSString *scheme = [url scheme];
    if ([scheme isEqualToString:@"haleyaction"]) {
        [self handleCustomAction:url];
        decisionHandler(WKNavigationActionPolicyCancel);
        return;
    }
    decisionHandler(WKNavigationActionPolicyAllow);
}



@end
