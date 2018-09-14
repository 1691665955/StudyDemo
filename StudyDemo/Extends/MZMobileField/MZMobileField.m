//
//  MZMobileField.m
//  StudyDemo
//
//  Created by 曾龙 on 2018/9/14.
//  Copyright © 2018年 曾龙. All rights reserved.
//

#import "MZMobileField.h"

@interface MZMobileField()<UITextFieldDelegate>

@end

@implementation MZMobileField
- (instancetype)init {
    self = [super init];
    if (self) {
        self.delegate = self;
        self.keyboardType = UIKeyboardTypeNumberPad;
    }
    return self;
}

- (void)setOriginText:(NSString *)originText {
    _originText = originText;
    self.text = [self parseString:originText];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
        self.keyboardType = UIKeyboardTypeNumberPad;
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.delegate = self;
        self.keyboardType = UIKeyboardTypeNumberPad;
    }
    return self;
}

#pragma mark -UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString* text = textField.text;
    if([string isEqualToString:@""]) {
        if(range.length == 1){
            //最后一位,遇到空格则多删除一次
            if (range.location == text.length-1 ) {
                if ([text characterAtIndex:text.length-1] == ' ') {
                    [textField deleteBackward];
                }
                return YES;
            } else{
                //从中间删除
                NSInteger offset = range.location;
                if (range.location < text.length && [text characterAtIndex:range.location] == ' ' && [textField.selectedTextRange isEmpty]) {
                    [textField deleteBackward];
                    offset --;
                }
                [textField deleteBackward];
                textField.text = [self parseString:textField.text];
                UITextPosition *newPos = [textField positionFromPosition:textField.beginningOfDocument offset:offset];
                textField.selectedTextRange = [textField textRangeFromPosition:newPos toPosition:newPos];
                return NO;
            }
        } else if (range.length > 1) {
            BOOL isLast = NO;
            //如果是从最后一位开始
            if(range.location + range.length == textField.text.length ) {
                isLast = YES;
            }
            [textField deleteBackward];
            textField.text = [self parseString:textField.text];
            
            NSInteger offset = range.location;
            if (range.location == 3 || range.location  == 8) {
                offset ++;
            }
            if (isLast) {
                //光标直接在最后一位了
            } else {
                UITextPosition *newPos = [textField positionFromPosition:textField.beginningOfDocument offset:offset];
                textField.selectedTextRange = [textField textRangeFromPosition:newPos toPosition:newPos];
            }
            return NO;
        } else{
            return YES;
        }
    } else if(string.length >0){
        //限制输入字符个数
        if (([self noneSpaseString:textField.text].length + string.length - range.length > 11) ) {
            return NO;
        }
        
        [textField insertText:string];
        textField.text = [self parseString:textField.text];
        
        NSInteger offset = range.location + string.length;
        if (range.location == 3 || range.location  == 8) {
            offset ++;
        }
        UITextPosition *newPos = [textField positionFromPosition:textField.beginningOfDocument offset:offset];
        textField.selectedTextRange = [textField textRangeFromPosition:newPos toPosition:newPos];
        return NO;
    } else{
        return YES;
    }
}

-(NSString*)noneSpaseString:(NSString*)string {
    return [string stringByReplacingOccurrencesOfString:@" " withString:@""];
}

- (NSString*)parseString:(NSString*)string {
    if (!string) {
        return nil;
    }
    NSMutableString* mStr = [NSMutableString stringWithString:[string stringByReplacingOccurrencesOfString:@" " withString:@""]];
    if (mStr.length >3) {
        [mStr insertString:@" " atIndex:3];
    }if (mStr.length > 8) {
        [mStr insertString:@" " atIndex:8];
        
    }
    return  mStr;
}
@end
