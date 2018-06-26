//
//  TestAttrinuteStringTapVC.m
//  StudyDemo
//
//  Created by 曾龙 on 2018/1/15.
//  Copyright © 2018年 曾龙. All rights reserved.
//

#import "TestAttrinuteStringTapVC.h"
#import "UILabel+YBAttributeTextTapAction.h"
@interface TestAttrinuteStringTapVC ()

@end

@implementation TestAttrinuteStringTapVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"可点击字符串";
    
    UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(20, 50, SCREEN_WIDTH-40, 80)];
    lb.backgroundColor = [UIColor clearColor];
    lb.numberOfLines = 0;
    lb.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:lb];
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"如果您点击确认按钮，代表您同意《关于支付宝获取用户使用信息协议》"];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor cyanColor] range:NSMakeRange(15, 17)];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:NSMakeRange(15, 17)];
    lb.attributedText = str;
    
    [lb yb_addAttributeTapActionWithStrings:@[@"关于支付宝获取用户使用信息协议》"] tapClicked:^(NSString *string, NSRange range, NSInteger index) {
        [MBProgressHUD showSuccess:@"恭喜您同意了该协议"];
    }];
}



@end
