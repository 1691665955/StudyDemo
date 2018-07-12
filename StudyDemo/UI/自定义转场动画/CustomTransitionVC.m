//
//  CustomTransitionVC.m
//  StudyDemo
//
//  Created by 曾龙 on 2018/6/28.
//  Copyright © 2018年 曾龙. All rights reserved.
//

#import "CustomTransitionVC.h"
#import "UIViewController+MZTool.h"
#import "MZNavigationController.h"
@interface CustomTransitionVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong)NSArray *transitionTypes;
@end

@implementation CustomTransitionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"自定义转场动画";
    self.transitionTypes = @[@"Present系统动画之默认方式",@"Present系统动画之水平反转",@"Present系统动画之隐出隐现",@"Present系统动画之部分翻页",@"Present自定义动画之淡出",@"Present自定义动画之覆盖",@"Present自定义动画之推出",@"Present自定义动画之揭开",@"Present自定义动画之立方体",@"Present自定义动画之吮吸",@"Present自定义动画之翻转",@"Present自定义动画之波纹",@"Present自定义动画之翻页",@"Present自定义动画之反翻页",@"Present自定义动画之开镜头",@"Present自定义动画之关镜头"];
}


#pragma UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.transitionTypes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TransitionCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TransitionCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = self.transitionTypes[indexPath.row];
    return cell;
}

#pragma UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *vc = [[UIViewController alloc] init];
    vc.title = self.transitionTypes[indexPath.row];
    TransitionAnimationType type = TransitionAnimationTypeDefault;
    TransitionAnimationDirection direction = TransitionAnimationDirectionLeft;
    NSTimeInterval duration = 1.0f;
    if (indexPath.row == 0) {
        type = TransitionAnimationTypeCoverVertical;
    } else if (indexPath.row == 1) {
        type = TransitionAnimationTypeFlipHorizontal;
    } else if (indexPath.row == 2) {
        type = TransitionAnimationTypeCrossDissolve;
    } else if (indexPath.row == 3) {
        type = TransitionAnimationTypePartialCurl;
    } else if (indexPath.row == 4) {
        type = TransitionAnimationTypeFade;
    } else if (indexPath.row == 5) {
        type = TransitionAnimationTypeMoveIn;
    } else if (indexPath.row == 6) {
        type = TransitionAnimationTypePush;
    } else if (indexPath.row == 7) {
        type = TransitionAnimationTypeReveal;
    } else if (indexPath.row == 8) {
        type = TransitionAnimationTypeCube;
    } else if (indexPath.row == 9) {
        type = TransitionAnimationTypeSuckEffect;
    } else if (indexPath.row == 10) {
        type = TransitionAnimationTypeOglFlip;
    } else if (indexPath.row == 11) {
        type = TransitionAnimationTypeRippleEffect;
    } else if (indexPath.row == 12) {
        type = TransitionAnimationTypePageCurl;
    } else if (indexPath.row == 13) {
        type = TransitionAnimationTypePageUnCurl;
    } else if (indexPath.row == 14) {
        type = TransitionAnimationTypeCameraIrisOpen;
    } else if (indexPath.row == 15) {
        type = TransitionAnimationTypeCameraIrisClose;
    }
    MZNavigationController *nvc = [[MZNavigationController alloc] initWithRootViewController:vc];
    dispatch_async(dispatch_get_main_queue(), ^{
       [self presentViewController:nvc animationType:type animationDirection:direction duration:duration];
    });
}
@end
