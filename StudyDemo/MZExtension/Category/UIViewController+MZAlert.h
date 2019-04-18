//
//  UIViewController+MZAlert.h
//  StudyDemo
//
//  Created by 曾龙 on 2018/7/13.
//  Copyright © 2018年 曾龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (MZAlert)

/**
 系统提示框（确认按钮在左，取消按钮在右）

 @param title 提示框标题
 @param message 提示框内容
 @param confirmTitle 确认按钮标题
 @param cancelTitle 取消按钮标题
 @param confirm 确认按钮点击回调
 @param cancel 取消按钮点击回调
 */
- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message confirmTitle:(NSString *)confirmTitle cancelTitle:(NSString *)cancelTitle confirm:(void(^)(void))confirm cancel:(void(^)(void))cancel;

/**
 系统提示款（确认按钮在右，取消按钮在左）

 @param title 提示框标题
 @param message 提示框内容
 @param cancelTitle 取消按钮标题
 @param confirmTitle 确认按钮标题
 @param confirm 确认按钮点击回调
 @param cancel 取消按钮点击回调
 */
- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle confirmTitle:(NSString *)confirmTitle confirm:(void(^)(void))confirm cancel:(void(^)(void))cancel;

/**
 系统提示款（只有一个按钮）

 @param title 提示框标题
 @param message 提示框内容
 @param confirmTitle 确认按钮标题
 @param confirm 确认按钮点击回调
 */
- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message confirmTitle:(NSString *)confirmTitle confirm:(void (^)(void))confirm;

/**
 系统提示框（自定义标题和内容）

 @param attributedTitle 自定义标题
 @param attributedMessage 自定义内容
 @param confirmTitle 确认按钮标题
 @param confirmStyle 确认按钮风格
 @param cancelTitle 取消按钮标题
 @param cancelStyle 取消按钮风格
 @param confirm 确认按钮点击回调
 @param cancel 取消按钮点击回调
 */
- (void)showAlertWithAttributedTitle:(NSAttributedString *)attributedTitle attributedMessage:(NSAttributedString *)attributedMessage confirmTitle:(NSString *)confirmTitle confirmStyle:(UIAlertActionStyle)confirmStyle cancelTitle:(NSString *)cancelTitle cancelStyle:(UIAlertActionStyle)cancelStyle confirm:(void(^)(void))confirm cancel:(void(^)(void))cancel;

/**
  系统提示框（自定义标题和内容以及按钮标题颜色）

 @param attributedTitle 自定义标题
 @param attributedMessage 自定义内容
 @param confirmTitle 确认按钮标题
 @param confirmColor 确认按钮标题颜色
 @param cancelTitle 取消按钮标题
 @param cancelColor 取消按钮标题颜色
 @param confirm 确认按钮点击回调
 @param cancel 取消按钮点击回调
 */
- (void)showAlertWithAttributedTitle:(NSAttributedString *)attributedTitle attributedMessage:(NSAttributedString *)attributedMessage confirmTitle:(NSString *)confirmTitle confirmColor:(UIColor *)confirmColor cancelTitle:(NSString *)cancelTitle cancelColor:(UIColor *)cancelColor confirm:(void(^)(void))confirm cancel:(void(^)(void))cancel;

/**
 系统操作框

 @param title 操作框标题
 @param message 操作框内容
 @param actionTitles 操作按钮标题（自带取消按钮,actionTitles不用定义）
 @param cancelTitle 取消按钮标题
 @param cancelColor 取消按钮标题颜色
 @param callback 按钮点击回调
 */
- (void)showActionSheetWithTitle:(NSString *)title message:(NSString *)message actionTitles:(NSArray<NSString *> *)actionTitles cancelTitle:(NSString *)cancelTitle cancelColor:(UIColor *)cancelColor callback:(void(^)(NSString *actionTitle))callback;

/**
 系统操作框（自定义标题和内容以及按钮标题颜色）

 @param attributedTitle 自定义标题
 @param attributedMessage 自定义内容
 @param actionTitles 操作按钮标题（自带取消按钮，actionTitles不用定义）
 @param actionColors 操作按钮标题颜色
 @param cancelTitle 取消按钮标题
 @param cancelColor 取消按钮标题颜色
 @param callback 按钮点击回调（取消按钮点击actionTitle值为"cancel"）
 */
- (void)showActionSheetWithAttributedTitle:(NSAttributedString *)attributedTitle attributedMessage:(NSAttributedString *)attributedMessage actionTitles:(NSArray<NSString *> *)actionTitles actionColors:(NSArray<UIColor *> *)actionColors cancelTitle:(NSString *)cancelTitle cancelColor:(UIColor *)cancelColor callback:(void(^)(NSString *actionTitle))callback;
@end
