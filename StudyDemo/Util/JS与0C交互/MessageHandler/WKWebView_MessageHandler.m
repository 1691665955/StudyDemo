//
//  WKWebView_MessageHandler.m
//  StudyDemo
//
//  Created by 曾龙 on 2018/1/5.
//  Copyright © 2018年 曾龙. All rights reserved.
//

#import "WKWebView_MessageHandler.h"
#import <WebKit/WebKit.h>
#import <AVFoundation/AVFoundation.h>
@interface WKWebView_MessageHandler ()<WKScriptMessageHandler>
@property (nonatomic ,strong)WKWebView *webView;
@end

@implementation WKWebView_MessageHandler

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"MessageHandler";
    self.view.backgroundColor = [UIColor whiteColor];

    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"给力" style:UIBarButtonItemStylePlain target:self action:@selector(sendInfoToJS)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    WKPreferences *preferences = [WKPreferences new];
    preferences.javaScriptCanOpenWindowsAutomatically = YES;
    
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    configuration.preferences = preferences;
    
    self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-Navi_Height) configuration:configuration];
    NSString *urlStr = [[NSBundle mainBundle] pathForResource:@"index1" ofType:@"html"];
    NSURL *url = [NSURL fileURLWithPath:urlStr];
    NSString *html = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    [self.webView loadHTMLString:html baseURL:url];
    self.webView.scrollView.bounces = NO;
    [self.view addSubview:self.webView];
    
    if (iOS11Later) {
        adjustsScrollViewInsets_NO(self.webView.scrollView, self);
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    //监听是否加载完毕
    [self.webView addObserver:self forKeyPath:@"loading" options:NSKeyValueObservingOptionNew context:nil];
    //监听加载进度
//    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    //监听H5标题
//    [self.webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)sendInfoToJS {
    [self.webView evaluateJavaScript:@"receiveInfo(\"欧力给\")" completionHandler:^(id _Nullable info, NSError * _Nullable error) {
        NSLog(@"发送成功");
    }];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"loading"]) {
        //监听加载情况，加载完毕后，将闪光灯的状态传给H5界面,但是好像无效，目前没找到原因  torchMode为nil
        if (!self.webView.loading) {
            [self updateLightState];
        }
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.webView.configuration.userContentController addScriptMessageHandler:self name:@"alert"];
    [self.webView.configuration.userContentController addScriptMessageHandler:self name:@"openLight"];
}

- (void)updateLightState {
    AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if ([captureDevice hasTorch]) {
        int state = 0;
        if (captureDevice.torchMode == AVCaptureTorchModeOn) {
            state = 1;
        }
        [self.webView evaluateJavaScript:[NSString stringWithFormat:@"updateLightState(%d)",state] completionHandler:^(id _Nullable info, NSError * _Nullable error) {
            NSLog(@"发送成功");
        }];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.webView.configuration.userContentController removeScriptMessageHandlerForName:@"alert"];
    [self.webView.configuration.userContentController removeScriptMessageHandlerForName:@"openLight"];
    [self.webView removeObserver:self forKeyPath:@"loading"];
}

#pragma mark -WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    // 注意:js方法如果传参为空的话，一定要传"null"过来，不然该代理方法接收不到，可参考index1.html文件的openLight方法传参
    if ([message.name isEqualToString:@"alert"]) {
        [MBProgressHUD showError:message.body];
    } else if ([message.name isEqualToString:@"openLight"]) {
        [self openLight];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
