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

@end
