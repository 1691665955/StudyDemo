//
//  WebViewFitVC.m
//  StudyDemo
//
//  Created by 曾龙 on 2018/1/15.
//  Copyright © 2018年 曾龙. All rights reserved.
//

#import "WebViewFitVC.h"

@interface WebViewFitVC ()
@property (nonatomic ,strong)UIWebView *webView;
@end

@implementation WebViewFitVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"UIWebView高度自适应";
    
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
    self.webView.backgroundColor = RGB(223, 223, 223);
    self.webView.scrollView.scrollEnabled = NO;
    [self.webView.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"testFit.html" withExtension:nil];
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
    [self.view addSubview:self.webView];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"contentSize"]) {
        CGSize fittingSize = [self.webView sizeThatFits:CGSizeZero];
        self.webView.frame = CGRectMake(0, 0, fittingSize.width, fittingSize.height);
    }
}



@end
