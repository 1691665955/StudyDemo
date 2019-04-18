//
//  NSObject+MZTool.h
//  StudyDemo
//
//  Created by 曾龙 on 2018/6/27.
//  Copyright © 2018年 曾龙. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (MZTool)

/**
 获取当前显示的ViewController
 */
+ (UIViewController *)currentViewController;

/*
 获取屏幕窗口
 */
+ (UIView *)getWindowView;
@end
