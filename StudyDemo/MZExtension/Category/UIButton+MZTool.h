//
//  UIButton+MZTool.h
//  StudyDemo
//
//  Created by 曾龙 on 2018/7/13.
//  Copyright © 2018年 曾龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (MZTool)

/**
 设置不同状态下的背景颜色

 @param backgroundColor 背景颜色
 @param state 目前状态只能设置UIControlStateNormal和UIControlStateSelected
 */
- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state;
@end
