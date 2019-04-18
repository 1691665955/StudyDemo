//
//  UIViewController+MZAlert.m
//  StudyDemo
//
//  Created by 曾龙 on 2018/7/13.
//  Copyright © 2018年 曾龙. All rights reserved.
//

#import "UIViewController+MZAlert.h"

@implementation UIViewController (MZAlert)
/**
 系统提示框（确认按钮在左，取消按钮在右）
 
 @param title 提示框标题
 @param message 提示框内容
 @param confirmTitle 确认按钮标题
 @param cancelTitle 取消按钮标题
 @param confirm 确认按钮点击回调
 @param cancel 取消按钮点击回调
 */
- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message confirmTitle:(NSString *)confirmTitle cancelTitle:(NSString *)cancelTitle confirm:(void(^)(void))confirm cancel:(void(^)(void))cancel {
    [self showAlertWithAttributedTitle:title?[[NSAttributedString alloc] initWithString:title]:nil attributedMessage:message?[[NSAttributedString alloc] initWithString:message]:nil confirmTitle:confirmTitle confirmStyle:UIAlertActionStyleDefault cancelTitle:cancelTitle cancelStyle:UIAlertActionStyleCancel confirm:confirm cancel:cancel];
}

/**
 系统提示款（确认按钮在右，取消按钮在左）
 
 @param title 提示框标题
 @param message 提示框内容
 @param cancelTitle 取消按钮标题
 @param confirmTitle 确认按钮标题
 @param confirm 确认按钮点击回调
 @param cancel 取消按钮点击回调
 */
- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle confirmTitle:(NSString *)confirmTitle confirm:(void(^)(void))confirm cancel:(void(^)(void))cancel {
    [self showAlertWithAttributedTitle:title?[[NSAttributedString alloc] initWithString:title]:nil attributedMessage:message?[[NSAttributedString alloc] initWithString:message]:nil confirmTitle:cancelTitle confirmStyle:UIAlertActionStyleCancel cancelTitle:confirmTitle cancelStyle:UIAlertActionStyleDefault confirm:cancel cancel:confirm];
}

/**
 系统提示款（只有一个按钮）
 
 @param title 提示框标题
 @param message 提示框内容
 @param confirmTitle 确认按钮标题
 @param confirm 确认按钮点击回调
 */
- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message confirmTitle:(NSString *)confirmTitle confirm:(void (^)(void))confirm {
    [self showAlertWithAttributedTitle:title?[[NSAttributedString alloc] initWithString:title]:nil attributedMessage:message?[[NSAttributedString alloc] initWithString:message]:nil confirmTitle:confirmTitle confirmStyle:UIAlertActionStyleDefault cancelTitle:nil cancelStyle:UIAlertActionStyleCancel confirm:confirm cancel:nil];
}

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
- (void)showAlertWithAttributedTitle:(NSAttributedString *)attributedTitle attributedMessage:(NSAttributedString *)attributedMessage confirmTitle:(NSString *)confirmTitle confirmStyle:(UIAlertActionStyle)confirmStyle cancelTitle:(NSString *)cancelTitle cancelStyle:(UIAlertActionStyle)cancelStyle confirm:(void(^)(void))confirm cancel:(void(^)(void))cancel {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
    if (attributedTitle) {
        [alert setValue:attributedTitle forKey:@"attributedTitle"];
    }
    if (attributedMessage) {
        [alert setValue:attributedMessage forKey:@"attributedMessage"];
    }
    
    if (confirmTitle) {
        UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:confirmTitle style:confirmStyle handler:^(UIAlertAction * _Nonnull action) {
            if (confirm) {
                confirm();
            }
        }];
        [alert addAction:confirmAction];
    }
    
    if (cancelTitle) {
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelTitle style:cancelStyle handler:^(UIAlertAction * _Nonnull action) {
            if (cancel) {
                cancel();
            }
        }];
        [alert addAction:cancelAction];
    }
    [self presentViewController:alert animated:YES completion:nil];
}

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
- (void)showAlertWithAttributedTitle:(NSAttributedString *)attributedTitle attributedMessage:(NSAttributedString *)attributedMessage confirmTitle:(NSString *)confirmTitle confirmColor:(UIColor *)confirmColor cancelTitle:(NSString *)cancelTitle cancelColor:(UIColor *)cancelColor confirm:(void(^)(void))confirm cancel:(void(^)(void))cancel {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
    if (attributedTitle) {
        [alert setValue:attributedTitle forKey:@"attributedTitle"];
    }
    if (attributedMessage) {
        [alert setValue:attributedMessage forKey:@"attributedMessage"];
    }
    if (confirmTitle) {
        UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:confirmTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (confirm) {
                confirm();
            }
        }];
        if (confirmColor) {
            [confirmAction setValue:confirmColor forKey:@"titleTextColor"];
        }
        [alert addAction:confirmAction];
    }
    if (cancelTitle) {
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (cancel) {
                cancel();
            }
        }];
        if (cancelColor) {
            [cancelAction setValue:cancelColor forKey:@"titleTextColor"];
        }
        [alert addAction:cancelAction];
    }
    [self presentViewController:alert animated:YES completion:nil];
}

/**
 系统操作框
 
 @param title 操作框标题
 @param message 操作框内容
 @param actionTitles 操作按钮标题（自带取消按钮,actionTitles不用定义）
 @param cancelTitle 取消按钮标题
 @param cancelColor 取消按钮标题颜色
 @param callback 按钮点击回调
 */
- (void)showActionSheetWithTitle:(NSString *)title message:(NSString *)message actionTitles:(NSArray<NSString *> *)actionTitles cancelTitle:(NSString *)cancelTitle cancelColor:(UIColor *)cancelColor callback:(void(^)(NSString *actionTitle))callback {
    [self showActionSheetWithAttributedTitle:title?[[NSAttributedString alloc] initWithString:title]:nil attributedMessage:message?[[NSAttributedString alloc] initWithString:message]:nil actionTitles:actionTitles actionColors:nil cancelTitle:cancelTitle cancelColor:cancelColor callback:callback];
}

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
- (void)showActionSheetWithAttributedTitle:(NSAttributedString *)attributedTitle attributedMessage:(NSAttributedString *)attributedMessage actionTitles:(NSArray<NSString *> *)actionTitles actionColors:(NSArray<UIColor *> *)actionColors cancelTitle:(NSString *)cancelTitle cancelColor:(UIColor *)cancelColor callback:(void(^)(NSString *actionTitle))callback {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    if (attributedTitle) {
        [alert setValue:attributedTitle forKey:@"attributedTitle"];
    }
    if (attributedMessage) {
        [alert setValue:attributedMessage forKey:@"attributedMessage"];
    }
    if (actionTitles) {
        for (int i = 0; i < actionTitles.count; i++) {
            NSString *actionTitle = actionTitles[i];
            UIAlertAction *action = [UIAlertAction actionWithTitle:actionTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                if (callback) {
                    callback(action.title);
                }
            }];
            if (actionColors && actionColors.count >= i+1) {
                [action setValue:actionColors[i] forKey:@"titleTextColor"];
            }
            [alert addAction:action];
        }
    }
    if (cancelTitle) {
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            if (callback) {
                callback(@"cancel");
            }
        }];
        if (cancelColor) {
            [cancelAction setValue:cancelColor forKey:@"titleTextColor"];
        }
        [alert addAction:cancelAction];
    }
    [self presentViewController:alert animated:YES completion:nil];
}
@end
