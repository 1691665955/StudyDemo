//
//  baseHeader.h
//  SmartFan
//
//  Created by 曾龙 on 2018/11/2.
//  Copyright © 2018年 trudian. All rights reserved.
//

#ifndef baseHeader_h
#define baseHeader_h

#define RGB(r,g,b)     [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define RGBA(r,g,b,a)  [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define SCREEN_WIDTH   [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT  [UIScreen mainScreen].bounds.size.height

//适配iPhoneX
#define iphoneX      [UIScreen mainScreen].bounds.size.height >= 812.0
#define Navi_Height  ([UIScreen mainScreen].bounds.size.height >= 812.0?88:64)
#define StateBar_Height ([UIScreen mainScreen].bounds.size.height >= 812.0?44:20)
#define Tabbar_Height ([UIScreen mainScreen].bounds.size.height >= 812.0?83:49)
#define Safe_Bottom  ([UIScreen mainScreen].bounds.size.height >= 812.0?34:0)

// 弱引用
#define WeakSelf(type)       __weak typeof(type) weak##type = type;
// 强引用
#define StrongSelf(type)     __strong typeof(type) type = weak##type;

// 解决iOS11 automaticallyAdjustsScrollViewInsets失效
#define  adjustsScrollViewInsets_NO(scrollView,vc)\
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
if ([UIScrollView instancesRespondToSelector:NSSelectorFromString(@"setContentInsetAdjustmentBehavior:")]) {\
[scrollView   performSelector:NSSelectorFromString(@"setContentInsetAdjustmentBehavior:") withObject:@(2)];\
} else {\
vc.automaticallyAdjustsScrollViewInsets = NO;\
}\
_Pragma("clang diagnostic pop") \
} while (0)

#if DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"\nfunction:%s line:%d \n%s\n", __FUNCTION__, __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String])
#else
#define NSLog(FORMAT, ...) nil
#endif

#endif /* baseHeader_h */
