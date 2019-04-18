//
//  MZActionSheetDelegate.m
//  StudyDemo
//
//  Created by 曾龙 on 2019/4/12.
//  Copyright © 2019年 曾龙. All rights reserved.
//

#import "MZActionSheetDelegate.h"
#import "MZPresentationController.h"
@implementation MZActionSheetDelegate
#pragma mark -UIViewControllerTransitioningDelegate
- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source {
    return [[MZPresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
}
@end
