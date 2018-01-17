//
//  UIWebView_JSContext.m
//  JS_OC_JavaScriptCore
//
//  Created by 曾龙 on 2018/1/8.
//  Copyright © 2018年 Haley. All rights reserved.
//

#import "UIWebView_JSContext.h"
#import <AVFoundation/AVFoundation.h>
#import <JavaScriptCore/JavaScriptCore.h>
@interface UIWebView_JSContext ()<UIWebViewDelegate>
@property(nonatomic ,strong)UIWebView *webView;
@end

@implementation UIWebView_JSContext

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"UIWebView_JSContext";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"给力" style:UIBarButtonItemStylePlain target:self action:@selector(sendInfoToJS)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    NSURL *htmlURL = [[NSBundle mainBundle] URLForResource:@"index3.html" withExtension:nil];
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

- (void)addCustomActions {
    JSContext *context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    context[@"showAlert"] = ^{
        NSArray *args = [JSContext currentArguments];
        if (args.count<2) {
            return ;
        }
        //这里会有两个参数："提示"和"JS给OC的警告"，我们显示后一个
        NSString *alertString = [args[1] toString];
        dispatch_async(dispatch_get_main_queue(), ^{
           [MBProgressHUD showError:alertString];
        });
    };
    context[@"lightOperate"] = ^{
        [self openLight];
    };
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
        [[JSContext currentContext] evaluateScript:[NSString stringWithFormat:@"updateLightState(%d)",captureDevice.torchMode==AVCaptureTorchModeOn?1:0]];
    }
}

#pragma mark -UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self addCustomActions];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
