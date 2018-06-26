//
//  SystemFuncVC.m
//  StudyDemo
//
//  Created by 曾龙 on 2018/6/26.
//  Copyright © 2018年 曾龙. All rights reserved.
//

#import "SystemFuncVC.h"
#import <Social/Social.h>
@interface SystemFuncVC ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation SystemFuncVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"iOS系统功能";
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
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *titles = @[@"打电话",@"发短信",@"发邮件",@"浏览器打开网页",@"UIActivityViewController分享"];
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.textLabel.text = titles[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

#pragma mark -UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        NSString *telStr = @"18062022010";
        UIWebView *callWebView = [[UIWebView alloc] init];
        NSURL *telURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",telStr]];
        [callWebView loadRequest:[NSURLRequest requestWithURL:telURL]];
        [self.view addSubview:callWebView];
    } else if (indexPath.row == 1) {
        if ([[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"sms://18062022010"]]){
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"sms://18062022010"]];
        }
    } else if (indexPath.row == 2) {
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"mailto://1691665955@qq.com"]]){
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"mailto://1691665955@qq.com"]];
        }
    } else if (indexPath.row == 3) {
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"http://www.baidu.com/"]]){
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.baidu.com/"]];
        }
    } else if (indexPath.row == 4) {
        NSString *title = @"分享的标题";
        UIImage *image = [UIImage imageNamed:@"luffy"];
        UIImage *image2 = [UIImage imageNamed:@"luo"];
        NSURL *url = [NSURL URLWithString:@"http://v.youku.com/v_show/id_XMzY4NzEwNDQ4NA==.html?tpa=dW5pb25faWQ9MTAzMjUyXzEwMDAwMV8wMV8wMQ"];
        NSArray *activityItmes = @[title,image,image2,url];
        [self shareByActivityViewControllerWithActivityItmes:activityItmes];
    }
}

- (void)shareByActivityViewControllerWithActivityItmes:(NSArray *)activityItmes {
    /*
     1、只有文字的时候才显示问题
     2、只有文字和图片的时候只显示图片
     3、只有文字和url的时候都显示
     4、图片和url都有的时候，只显示url
     5、多张图片可以滑动查看
     */
    
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:activityItmes applicationActivities:nil];
    activityVC.excludedActivityTypes = @[ UIActivityTypePostToFacebook,UIActivityTypePostToTwitter, UIActivityTypePostToWeibo, UIActivityTypeMessage,UIActivityTypeMail,UIActivityTypePrint,UIActivityTypeCopyToPasteboard,UIActivityTypeAssignToContact,UIActivityTypeSaveToCameraRoll,UIActivityTypeAddToReadingList,UIActivityTypePostToFlickr,UIActivityTypePostToVimeo,UIActivityTypePostToTencentWeibo,UIActivityTypeAirDrop];
    [self presentViewController:activityVC animated:YES completion:nil];
}

@end
