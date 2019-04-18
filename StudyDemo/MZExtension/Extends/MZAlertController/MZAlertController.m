//
//  MZAlertController.m
//  StudyDemo
//
//  Created by 曾龙 on 2019/4/11.
//  Copyright © 2019年 曾龙. All rights reserved.
//

#import "MZAlertController.h"

@interface MZAlertController ()

@end

@implementation MZAlertController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *visualView = [[UIVisualEffectView alloc] initWithEffect:blur];
    visualView.frame = UIScreen.mainScreen.bounds;
    visualView.alpha = 0.4;
    visualView.backgroundColor = [UIColor blackColor];
    [self.view insertSubview:visualView atIndex:0];
}

// 控制器弹出方式
- (UIModalTransitionStyle)modalTransitionStyle {
    return UIModalTransitionStyleCrossDissolve;
}

// 设置控制器透明
- (UIModalPresentationStyle)modalPresentationStyle {
    return UIModalPresentationOverFullScreen;
}

@end
