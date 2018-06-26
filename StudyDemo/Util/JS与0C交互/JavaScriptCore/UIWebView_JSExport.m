//
//  UIWebView_JSExport.m
//  StudyDemo
//
//  Created by 曾龙 on 2018/1/8.
//  Copyright © 2018年 曾龙. All rights reserved.
//

#import "UIWebView_JSExport.h"
#import <AVFoundation/AVFoundation.h>
@interface UIWebView_JSExport ()<UIWebViewDelegate>
@property (nonatomic ,strong)UIWebView *webView;
@end

@implementation UIWebView_JSExport

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"UIWebView_JSExport";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"给力" style:UIBarButtonItemStylePlain target:self action:@selector(sendInfoToJS)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    NSURL *htmlURL = [[NSBundle mainBundle] URLForResource:@"index4.html" withExtension:nil];
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

#pragma mark -JSTestDelegate
- (void)lightOperate:(JSValue *)value {
    JSValue *successCallBack = [value valueForProperty:@"success"];
    AVCaptureDevice * device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (device.torchMode == AVCaptureTorchModeOn) {
        [device lockForConfiguration:nil];
        [device setTorchMode:AVCaptureTorchModeOff];
        [device unlockForConfiguration];
        [successCallBack callWithArguments:@[@0]];
    } else {
        [device lockForConfiguration:nil];
        [device setTorchMode:AVCaptureTorchModeOn];
        [device unlockForConfiguration];
        [successCallBack callWithArguments:@[@1]];
    }
}

- (void)showAlert:(JSValue *)value {
    NSString *alertString = [value valueForProperty:@"contents"].toString;
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD showError:alertString];
    });
}

#pragma mark -UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    self.jsContext = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    self.jsContext[@"test"] = self;
    self.jsContext.exceptionHandler = ^(JSContext *context, JSValue *exception) {
        context.exception = exception;
        NSLog(@"异常信息:%@",exception);
    };
}




@end
