//
//  MZTextView.h
//  StudyDemo
//
//  Created by 曾龙 on 2018/7/13.
//  Copyright © 2018年 曾龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MZTextView : UITextView
//占位符文字
@property (nonatomic, copy) NSString *placeholder;
//占位符颜色
@property (nonatomic, strong) UIColor *placeholderColor;
//最大输入字符数
@property (nonatomic, assign) NSInteger maxTextLength;
@end
