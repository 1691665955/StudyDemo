//
//  MZPayVC.m
//  StudyDemo
//
//  Created by 曾龙 on 2018/7/15.
//  Copyright © 2018年 曾龙. All rights reserved.
//

#import "MZPayVC.h"

@interface MZPayVC ()
@property (weak, nonatomic) IBOutlet UIImageView *wechatSelectView;
@property (weak, nonatomic) IBOutlet UILabel *wechatTipLB;
@property (weak, nonatomic) IBOutlet UIImageView *alipaySelectView;
@property (weak, nonatomic) IBOutlet UILabel *alipayTipLB;

@end

@implementation MZPayVC

- (void)viewDidLoad {
    [super viewDidLoad];
    if (SCREEN_WIDTH == 320) {
        self.wechatTipLB.font = [UIFont systemFontOfSize:11];
        self.alipayTipLB.font = [UIFont systemFontOfSize:11];
    }
}

- (IBAction)pay:(id)sender {
    if (self.wechatSelectView.hidden) {
        [MBProgressHUD showSuccess:@"支付宝支付"];
    } else {
        [MBProgressHUD showSuccess:@"微信支付"];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)selectWechat:(id)sender {
    self.wechatSelectView.hidden = NO;
    self.alipaySelectView.hidden = YES;
}

- (IBAction)selectAlipay:(id)sender {
    self.wechatSelectView.hidden = YES;
    self.alipaySelectView.hidden = NO;
}
@end
