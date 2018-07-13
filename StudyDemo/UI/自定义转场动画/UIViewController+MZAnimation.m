//
//  UIViewController+MZAnimation.m
//  StudyDemo
//
//  Created by 曾龙 on 2018/6/28.
//  Copyright © 2018年 曾龙. All rights reserved.
//

#import "UIViewController+MZAnimation.h"
#import <objc/runtime.h>
@implementation UIViewController (MZAnimation)
- (void)presentViewController:(UIViewController *)viewController animationType:(TransitionAnimationType)type animationDirection:(TransitionAnimationDirection)direction duration:(NSTimeInterval)duration {
    CATransition *animation = [CATransition animation];
    animation.duration = duration ? duration : 1.0f;
    NSString *animationType = kCATransitionFade;
    NSString *animationSubType = kCATransitionFromLeft;
    switch (type) {
        case TransitionAnimationTypeDefault:
            viewController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
            break;
        case TransitionAnimationTypeCoverVertical:
            viewController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
            break;
        case TransitionAnimationTypeFlipHorizontal:
            viewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
            break;
        case TransitionAnimationTypeCrossDissolve:
            viewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            break;
        case TransitionAnimationTypePartialCurl:
            viewController.modalTransitionStyle = UIModalTransitionStylePartialCurl;
            break;
        case TransitionAnimationTypeFade:
            animationType = kCATransitionFade;
            break;
        case TransitionAnimationTypeMoveIn:
            animationType = kCATransitionMoveIn;
            break;
        case TransitionAnimationTypePush:
            animationType = kCATransitionPush;
            break;
        case TransitionAnimationTypeReveal:
            animationType = kCATransitionReveal;
            break;
        case TransitionAnimationTypeCube:
            animationType = @"cube";
            break;
        case TransitionAnimationTypeSuckEffect:
            animationType = @"suckEffect";
            break;
        case TransitionAnimationTypeOglFlip:
            animationType = @"oglFlip";
            break;
        case TransitionAnimationTypeRippleEffect:
            animationType = @"rippleEffect";
            break;
        case TransitionAnimationTypePageCurl:
            animationType = @"pageCurl";
            break;
        case TransitionAnimationTypePageUnCurl:
            animationType = @"pageUnCurl";
            break;
        case TransitionAnimationTypeCameraIrisOpen:
            animationType = @"cameraIrisHollowOpen";
            break;
        case TransitionAnimationTypeCameraIrisClose:
            animationType = @"cameraIrisHollowClose";
            break;
        default:
            break;
    }
    switch (direction) {
        case TransitionAnimationDirectionTop:
            animationSubType = kCATransitionFromTop;
            break;
        case TransitionAnimationDirectionLeft:
            animationSubType = kCATransitionFromLeft;
            break;
        case TransitionAnimationDirectionBottom:
            animationSubType = kCATransitionFromBottom;
            break;
        case TransitionAnimationDirectionRight:
            animationSubType = kCATransitionFromRight;
            break;
        default:
            break;
    }
    if (type == TransitionAnimationTypeDefault || type == TransitionAnimationTypePartialCurl || type == UIModalTransitionStyleFlipHorizontal || type == UIModalTransitionStyleCrossDissolve || type ==  UIModalTransitionStyleCoverVertical) {
        [self presentViewController:viewController animated:YES completion:nil];
    } else {
        animation.type = animationType;
        animation.subtype = animationSubType;
        [self.view.window.layer addAnimation:animation forKey:@"animation"];
        [viewController setExtraPropertyWithPropertyName:@"animation" perportyValue:animation];
        [self presentViewController:viewController animated:NO completion:nil];
    }
}

- (void)dismiss {
    CATransition *animation = [self getExtraPropertyWithPropertyName:@"animation"];
    if (animation) {
        if ([animation.type isEqualToString:@"pageCurl"]) {
            animation.type = @"pageUnCurl";
        } else if ([animation.type isEqualToString:@"pageUnCurl"]) {
            animation.type = @"pageCurl";
        } else if ([animation.type isEqualToString:@"cameraIrisHollowOpen"]) {
            animation.type = @"cameraIrisHollowClose";
        } else if ([animation.type isEqualToString:@"cameraIrisHollowClose"]) {
            animation.type = @"cameraIrisHollowOpen";
        } else {
            if (animation.subtype == kCATransitionFromTop) {
                animation.subtype = kCATransitionFromBottom;
            } else if (animation.subtype == kCATransitionFromBottom) {
                animation.subtype = kCATransitionFromTop;
            } else if (animation.subtype == kCATransitionFromLeft) {
                animation.subtype = kCATransitionFromRight;
            } else if (animation.subtype == kCATransitionFromRight) {
                animation.subtype = kCATransitionFromLeft;
            }
        }
        [self.view.window.layer addAnimation:animation forKey:@"animation"];
        [self dismissViewControllerAnimated:NO completion:nil];
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

/**
 设置属性名和属性值
 @param name 属性名
 @param value 属性值
 */
- (void)setExtraPropertyWithPropertyName:(NSString *)name perportyValue:(id)value {
    objc_setAssociatedObject(self, [name UTF8String], value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

/**
 通过属性名拿到属性值
 @param name 属性名
 @return 返回属性值
 */
- (id)getExtraPropertyWithPropertyName:(NSString *)name {
    return objc_getAssociatedObject(self, [name UTF8String]);
}
@end
