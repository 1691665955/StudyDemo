//
//  MZPresentationController.m
//  StudyDemo
//
//  Created by 曾龙 on 2019/4/11.
//  Copyright © 2019年 曾龙. All rights reserved.
//

#import "MZPresentationController.h"
#import "MZActionSheetController.h"

#define MZPresentationController_WIDTH   [UIScreen mainScreen].bounds.size.width
#define MZPresentationController_Height  [UIScreen mainScreen].bounds.size.height

@interface MZPresentationController ()
@property (nonatomic, strong) UIVisualEffectView *visualView;
@end

@implementation MZPresentationController
//presentationTransitionWillBegin 是在呈现过渡即将开始的时候被调用的。我们在这个方法中把半透明黑色背景 View 加入到 containerView 中，并且做一个 alpha 从0到1的渐变过渡动画。
- (void)presentationTransitionWillBegin {
    //使用UIVisualEffectView实现模糊效果
    UIBlurEffect *blur  = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    _visualView = [[UIVisualEffectView alloc]initWithEffect:blur];
    _visualView.frame = self.containerView.bounds;
    _visualView.alpha = 0.3;
    _visualView.backgroundColor = [UIColor blackColor];
    [self.containerView addSubview:_visualView];
}

//以上就涵盖了我们的背景 View 的呈现部分，我们现在需要给它添加淡出动画并且在它消失后移除它。正如你预料的那样，dismissalTransitionWillBegin 正是我们把它的 alpha 重新设回0的地方。
- (void)dismissalTransitionWillBegin {
    _visualView.alpha = 0.0;
}

//我们还需要在消失完成后移除背景 View。做法与上面 presentationTransitionDidEnd: 类似，我们重载 dismissalTransitionDidEnd: 方法
- (void)dismissalTransitionDidEnd:(BOOL)completed {
    if (completed) {
        [_visualView removeFromSuperview];
    }
}

- (CGRect)frameOfPresentedViewInContainerView {
    MZActionSheetController *actionSheet = (MZActionSheetController *)self.presentedViewController;
    self.presentedView.frame = CGRectMake(0, MZPresentationController_Height-actionSheet.Height, MZPresentationController_WIDTH, actionSheet.Height);
    return self.presentedView.frame;
}
@end
