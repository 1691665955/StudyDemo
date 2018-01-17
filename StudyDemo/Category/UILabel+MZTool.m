//
//  UILabel+MZTool.m
//  StudyDemo
//
//  Created by 曾龙 on 2018/1/14.
//  Copyright © 2018年 曾龙. All rights reserved.
//

#import "UILabel+MZTool.h"
@implementation UILabel (MZTool)

/**
 给字符串划斜线
 
 @param frame 斜线的位置
 @param color 斜线的颜色
 @param width 斜线的宽度
 */
- (void)drawLineWithFrame:(CGRect)frame lineColor:(UIColor *)color lineWidth:(CGFloat)width {
    for (CALayer *layer in self.layer.sublayers) {
        if ([layer isKindOfClass:[CAShapeLayer class]]) {
            [layer removeFromSuperlayer];
        }
    }
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    path.lineWidth = width;
    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineJoinRound;
    [path moveToPoint:frame.origin];
    [path addLineToPoint:CGPointMake(CGRectGetMaxX(frame), CGRectGetMaxY(frame))];
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = path.CGPath;
    layer.strokeColor = color.CGColor;
    [self.layer addSublayer:layer];
}

/**
 给字符串划斜线
 该方法只有在numberOfLine为1时才能使用
 */
- (void)drawLine {
    CGSize maxSize = CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX);
    CGSize size = [self sizeThatFits:maxSize];
    if (self.textAlignment == NSTextAlignmentLeft) {
        [self drawLineWithFrame:CGRectMake(-2, (self.frame.size.height-size.height)/2, size.width+4, size.height) lineColor:self.textColor lineWidth:2.0f];
    } else if (self.textAlignment == NSTextAlignmentCenter) {
        [self drawLineWithFrame:CGRectMake((self.frame.size.width-size.width-4)/2, (self.frame.size.height-size.height)/2, size.width+4, size.height) lineColor:self.textColor lineWidth:2.0f];
    } else {
        [self drawLineWithFrame:CGRectMake(self.frame.size.width-size.width-2, (self.frame.size.height-size.height)/2, size.width+4, size.height) lineColor:self.textColor lineWidth:2.0f];
    }
}
@end
