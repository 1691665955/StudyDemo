//
//  UIViewController+MZTool.h
//  StudyDemo
//
//  Created by 曾龙 on 2018/6/28.
//  Copyright © 2018年 曾龙. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger,TransitionAnimationType) {
    //默认方式
    TransitionAnimationTypeDefault,            //竖向上推
    TransitionAnimationTypeCoverVertical,      //竖向上推
    TransitionAnimationTypeFlipHorizontal,     //水平反转
    TransitionAnimationTypeCrossDissolve,      //隐出隐现
    TransitionAnimationTypePartialCurl,        //部分翻页
    
    //自定义方式
    TransitionAnimationTypeFade,               //淡入淡出
    TransitionAnimationTypeMoveIn,             //覆盖
    TransitionAnimationTypePush,               //推出
    TransitionAnimationTypeReveal,             //揭开
    TransitionAnimationTypeCube,               //立方体
    TransitionAnimationTypeSuckEffect,         //吮吸
    TransitionAnimationTypeOglFlip,            //翻转
    TransitionAnimationTypeRippleEffect,       //波纹
    TransitionAnimationTypePageCurl,           //翻页
    TransitionAnimationTypePageUnCurl,         //反翻页
    TransitionAnimationTypeCameraIrisOpen,     //开镜头
    TransitionAnimationTypeCameraIrisClose,    //关镜头
};

typedef NS_ENUM(NSUInteger,TransitionAnimationDirection) {
    TransitionAnimationDirectionBottom,
    TransitionAnimationDirectionLeft,
    TransitionAnimationDirectionRight,
    TransitionAnimationDirectionTop
};
@interface UIViewController (MZTool)
- (void)presentViewController:(UIViewController *)viewController animationType:(TransitionAnimationType)type animationDirection:(TransitionAnimationDirection)direction duration:(NSTimeInterval)duration;
- (void)dismiss;
@end
