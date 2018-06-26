//
//  MZWebViewVC.m
//  StudyDemo
//
//  Created by 曾龙 on 2018/1/8.
//  Copyright © 2018年 曾龙. All rights reserved.
//

#import "MZWebViewVC.h"

@interface MZWebViewVC ()

@end

@implementation MZWebViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.titleText;
    self.view.backgroundColor = [UIColor whiteColor];
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-Navi_Height)];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
    [self.view addSubview:webView];
    if (iOS11Later) {
        adjustsScrollViewInsets_NO(webView.scrollView, self);
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}



@end
