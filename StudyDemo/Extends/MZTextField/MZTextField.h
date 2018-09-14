//
//  MZTextField.h
//  StudyDemo
//
//  Created by 曾龙 on 2018/6/27.
//  Copyright © 2018年 曾龙. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 用于监听删除按钮点击，不论输入框是否还有字符，都会触发
 */
@protocol MZTextFieldDelegate<UITextFieldDelegate>
@optional
- (void)textFieldDidDeleteBackword:(UITextField *)textField;
@end

@interface MZTextField : UITextField
@property (nonatomic, weak)id<MZTextFieldDelegate> mzDelegate;
//最大输入字符
@property (nonatomic, assign) NSInteger maxTextLength;
@end
