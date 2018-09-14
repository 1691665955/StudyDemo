//
//  TestPayVC.m
//  StudyDemo
//
//  Created by 曾龙 on 2018/7/15.
//  Copyright © 2018年 曾龙. All rights reserved.
//

#import "TestPayVC.h"
#import "MZPayVC.h"
#import "MZShadowController.h"
@interface TestPayVC ()<UIViewControllerTransitioningDelegate>

@end

@implementation TestPayVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"自定义支付选择控制器控制器控制器";
}

- (IBAction)pay:(id)sender {
    MZPayVC *vc = [[MZPayVC alloc] initWithNibName:@"MZPayVC" bundle:nil];
    vc.modalPresentationStyle = UIModalPresentationCustom;
    vc.transitioningDelegate = self;
    [self presentViewController:vc animated:YES completion:nil];
}

#pragma mark -UIViewControllerPreviewingDelegate
- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source {
    return [[MZShadowController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
}
@end
