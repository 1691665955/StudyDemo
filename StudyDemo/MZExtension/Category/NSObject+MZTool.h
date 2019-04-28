//
//  NSObject+MZTool.h
//  StudyDemo
//
//  Created by 曾龙 on 2018/6/27.
//  Copyright © 2018年 曾龙. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSObject (MZTool)

/**
 获取当前显示的ViewController
 */
+ (UIViewController *)currentViewController;

/*
 获取屏幕窗口
 */
+ (UIView *)getWindowView;

/**
 获取手机当前连接的SSID（iOS12后要开启capabilities中的Access WiFi Information）
 */
+ (NSString *)SSID;

/**
 获取app版本号
 */
+ (NSString *)getAppVersion;

/**
 获取app Build
 */
+ (NSString *)getAppBuild;

/**
 获取app名称
 */
+ (NSString *)getAppName;

/**
 获取app BundleID
 */
+ (NSString *)getAppBundleIdentifier;

/**
 获取app BundleID
 */
+ (UIImage *)getAppIcon;
@end
