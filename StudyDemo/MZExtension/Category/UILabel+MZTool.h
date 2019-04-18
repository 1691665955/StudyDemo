//
//  UILabel+MZTool.h
//  StudyDemo
//
//  Created by 曾龙 on 2018/1/14.
//  Copyright © 2018年 曾龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (MZTool)

/**
 给字符串划斜线
 注意：每次更新完text之后都要重新执行该方法来重新划线
 问题：目前划线时线是在字符串的下面，如果字符串和斜线的颜色不一样话，会在视觉上存在问题
 @param frame 斜线的位置
 @param color 斜线的颜色
 @param width 斜线的宽度
 */
- (void)drawLineWithFrame:(CGRect)frame lineColor:(UIColor *)color lineWidth:(CGFloat)width;


/**
 给字符串划斜线
 该方法只有在numberOfLine为1时才能使用
 */
- (void)drawLine;
@end
