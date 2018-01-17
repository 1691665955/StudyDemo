//
//  JavaScriptAndOCFunVC.m
//  StudyDemo
//
//  Created by 曾龙 on 2018/1/6.
//  Copyright © 2018年 曾龙. All rights reserved.
//

#import "JavaScriptAndOCFunVC.h"
#import "WKWebView_MessageHandler.h"
#import "UIWebView_URL.h"
#import "WKWebView_URL.h"
#import "UIWebView_JSContext.h"
#import "UIWebView_JSExport.h"
#import "MZWebViewVC.h"
@interface JavaScriptAndOCFunVC ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation JavaScriptAndOCFunVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"JS与OC交互";
    [self initUI];
}

- (void)initUI {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-Navi_Height) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:tableView];
    if (iOS11Later) {
        adjustsScrollViewInsets_NO(tableView, self);
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

#pragma mark -UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *titles = @[@"WKWebView+MessageHandler",@"UIWebView+URL",@"WKWebView+URL",@"UIWebView+JSContext",@"UIWebView+JSExport",@"网上方法总结"];
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.textLabel.text = titles[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

#pragma mark -UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        WKWebView_MessageHandler *vc = [[WKWebView_MessageHandler alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row == 1) {
        UIWebView_URL *vc = [[UIWebView_URL alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row == 2) {
        WKWebView_URL *vc = [[WKWebView_URL alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row == 3) {
        UIWebView_JSContext *vc = [[UIWebView_JSContext alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row == 4) {
        UIWebView_JSExport *vc = [[UIWebView_JSExport alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        MZWebViewVC *vc = [[MZWebViewVC alloc] init];
        vc.titleText = @"JS_OC交互";
        vc.url = @"https://www.jianshu.com/p/d19689e0ed83";
        [self.navigationController pushViewController:vc animated:YES];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
