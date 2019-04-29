//
//  UIView+MZTool.h
//  StudyDemo
//
//  Created by 曾龙 on 2018/6/27.
//  Copyright © 2018年 曾龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (MZTool)
/**
 设置试图背景颜色的渐变色
 
 @param startColor 起始颜色
 @param endColor 终止颜色
 @param startPoint 起始位置
 @param endPoint 终止位置
 */
- (void)setupGradientColorWithStartColor:(UIColor *)startColor endColor:(UIColor *)endColor startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint;

/**
 给view添加点击事件

 @param target 点击事件响应者
 @param selector 响应事件
 */
- (void)addTapGestureRecognizerWithTarget:(id)target selector:(SEL)selector;

/**
 根据一个VC上的view得到该VC
 
 @return VC
 */
- (UIViewController *)getVC;

/**
 设置试图圆角

 @param radius 圆角大小
 */
- (void)setRadius:(CGFloat)radius;

/**
 设置部分圆角

 @param corners 圆角方向
 @param radii 圆角大小
 */
- (void)setRoundedCorners:(UIRectCorner)corners radii:(CGSize)radii;
@end
