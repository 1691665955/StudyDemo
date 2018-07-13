//
//  MZTextView.m
//  StudyDemo
//
//  Created by 曾龙 on 2018/7/13.
//  Copyright © 2018年 曾龙. All rights reserved.
//

#import "MZTextView.h"

@implementation MZTextView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.placeholder = @"";
        self.placeholderColor = [UIColor colorWithRed:187/255.0 green:187/255.0 blue:187/255.0 alpha:1];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange:) name:UITextViewTextDidChangeNotification object:self];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.placeholder = @"";
        self.placeholderColor = [UIColor colorWithRed:187/255.0 green:187/255.0 blue:187/255.0 alpha:1];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange:) name:UITextViewTextDidChangeNotification object:self];
    }
    return self;
}

- (void)textDidChange:(NSNotification *)notification {
    //会重新调用drawRect方法
    if (self.maxTextLength > 0) {
        NSString *toBeString = self.text;
        NSString *language = [UIApplication sharedApplication].textInputMode.primaryLanguage;
        //中文输入
        if ([language isEqualToString:@"zh-Hans"]) {
            UITextRange *selectedRange = [self markedTextRange];
            //获取高亮部分
            UITextPosition *position = [self positionFromPosition:selectedRange.start offset:0];
            if (!position) {
                //没有高亮选择的字，则对已输入的文字进行字数统计和限制
                if (toBeString.length > self.maxTextLength) {
                    self.text = [toBeString substringToIndex:self.maxTextLength];
                }
            }
        } else {
            //中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
            if (toBeString.length > self.maxTextLength) {
                self.text = [toBeString substringToIndex:self.maxTextLength];
            }
        }
    }
    [self setNeedsDisplay];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)drawRect:(CGRect)rect {
    if (self.maxTextLength > 0) {
        CGRect frame = CGRectMake(0, 0, rect.size.width, rect.size.height);
        CGSize maxSize = CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX);
        CGRect rect1 = [[NSString stringWithFormat:@"%ld/%ld",self.text.length,self.maxTextLength] boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:self.placeholderColor} context:nil];
        frame.origin.y = frame.size.height-3-rect1.size.height;
        frame.origin.x = frame.size.width-5-rect1.size.width;
        frame.size = rect1.size;
        [[NSString stringWithFormat:@"%ld/%ld",self.text.length,self.maxTextLength] drawInRect:frame withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:self.placeholderColor}];
    }
    
    //如果有文字，就直接返回，不需要画占位符文字
    if (self.hasText) {
        return;
    }
    
    //画文字
    rect.origin.x = 5;
    rect.origin.y = 8;
    rect.size.width -= rect.origin.x*2;
    [self.placeholder drawInRect:rect withAttributes:@{NSFontAttributeName:self.font,NSForegroundColorAttributeName:self.placeholderColor}];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self setNeedsDisplay];
}

- (void)setPlaceholder:(NSString *)placeholder {
    _placeholder = placeholder;
    [self setNeedsDisplay];
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor {
    _placeholderColor = placeholderColor;
    [self setNeedsDisplay];
}

- (void)setFont:(UIFont *)font {
    [super setFont:font];
    [self setNeedsDisplay];
}

- (void)setText:(NSString *)text {
    [super setText:text];
    [self setNeedsDisplay];
}

- (void)setAttributedText:(NSAttributedString *)attributedText {
    [super setAttributedText:attributedText];
    [self setNeedsDisplay];
}

- (void)setMaxTextLength:(NSInteger)maxTextLength {
    _maxTextLength = maxTextLength;
    [self setNeedsDisplay];
}
@end
