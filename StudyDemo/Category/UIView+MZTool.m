//
//  UIView+MZTool.m
//  StudyDemo
//
//  Created by 曾龙 on 2018/6/27.
//  Copyright © 2018年 曾龙. All rights reserved.
//

#import "UIView+MZTool.h"

@implementation UIView (MZTool)
/*
  设置试图背景颜色的渐变色
 */
- (void)setupGradientColorWithStartColor:(UIColor *)startColor endColor:(UIColor *)endColor startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint {
    if (self.layer.sublayers.count > 0 && [self.layer.sublayers[0] isKindOfClass:[CAGradientLayer class]]) {
        [self.layer.sublayers[0] removeFromSuperlayer];
    }
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.startPoint = startPoint;
    gradient.endPoint = endPoint;
    gradient.frame = self.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id)startColor.CGColor, (id)endColor.CGColor, nil];
    [self.layer insertSublayer:gradient atIndex:0];
}

/**
 给view添加点击事件
 */
- (void)addTapGestureRecognizerWithTarget:(id)target selector:(SEL)selector {
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:target action:selector];
    [self addGestureRecognizer:tap];
}
@end
