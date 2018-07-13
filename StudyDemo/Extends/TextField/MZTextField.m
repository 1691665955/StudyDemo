//
//  MZTextField.m
//  StudyDemo
//
//  Created by 曾龙 on 2018/6/27.
//  Copyright © 2018年 曾龙. All rights reserved.
//

#import "MZTextField.h"

@implementation MZTextField

- (void)setMzDelegate:(id<MZTextFieldDelegate>)mzDelegate {
    _mzDelegate = mzDelegate;
    self.delegate = mzDelegate;
}

- (void)deleteBackward {
    [super deleteBackward];
    if (self.mzDelegate && [self.mzDelegate respondsToSelector:@selector(textFieldDidDeleteBackword:)]) {
        [self.mzDelegate textFieldDidDeleteBackword:self];
    }
}

- (void)setMaxTextLength:(NSInteger)maxTextLength {
    _maxTextLength = maxTextLength;
    [self addTarget:self action:@selector(textDidChange:) forControlEvents:UIControlEventEditingChanged];
}

- (void)textDidChange:(MZTextField *)textFiled {
    NSString *toBeString = textFiled.text;
    NSString *language = [UIApplication sharedApplication].textInputMode.primaryLanguage;
    //中文输入
    if ([language isEqualToString:@"zh-Hans"]) {
        UITextRange *selectedRange = [textFiled markedTextRange];
        //获取高亮部分
        UITextPosition *position = [textFiled positionFromPosition:selectedRange.start offset:0];
        if (!position) {
            //没有高亮选择的字，则对已输入的文字进行字数统计和限制
            if (toBeString.length > textFiled.maxTextLength) {
                textFiled.text = [toBeString substringToIndex:textFiled.maxTextLength];
            }
        }
    } else {
        //中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
        if (toBeString.length > textFiled.maxTextLength) {
            textFiled.text = [toBeString substringToIndex:textFiled.maxTextLength];
        }
    }
}
@end
