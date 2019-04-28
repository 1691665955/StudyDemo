//
//  UIButton+MZTool.m
//  StudyDemo
//
//  Created by 曾龙 on 2018/7/13.
//  Copyright © 2018年 曾龙. All rights reserved.
//

#import "UIButton+MZTool.h"
#import <objc/runtime.h>

typedef void(^UIButtonBlock)(UIButton *sender);

@implementation UIButton (MZTool)
- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state {
    if (state == UIControlStateNormal) {
        [self setBackgroundColor:backgroundColor];
        [self setExtraPropertyWithPropertyName:@"UIControlStateNormal" perportyValue:backgroundColor];
    } else if (state == UIControlStateSelected) {
        [self setExtraPropertyWithPropertyName:@"UIControlStateSelected" perportyValue:backgroundColor];
    }
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    if (selected) {
        [self setbackgroundColorWithState:UIControlStateSelected];
    } else {
        [self setbackgroundColorWithState:UIControlStateNormal];
    }
}

- (void)setbackgroundColorWithState:(UIControlState)state {
    NSString *propertyName = @"UIControlStateNormal";
    if (state == UIControlStateNormal) {
        propertyName = @"UIControlStateNormal";
    } else if (state == UIControlStateSelected) {
        propertyName = @"UIControlStateSelected";
    }
    UIColor *color = [self getExtraPropertyWithPropertyName:propertyName];
    if (color) {
        self.backgroundColor = color;
    }
}

/**
 添加点击事件
 
 @param clickedBlock 点击事件回调
 */
- (void)setClickedBlock:(void(^)(UIButton *sender))clickedBlock {
    [self setExtraPropertyWithPropertyName:@"clickedBlock" perportyValue:clickedBlock];
    [self addTarget:self action:@selector(mzClicked:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)mzClicked:(UIButton *)sender {
    UIButtonBlock block = [self getExtraPropertyWithPropertyName:@"clickedBlock"];
    block(sender);
}

/**
 设置属性名和属性值
 @param name 属性名
 @param value 属性值
 */
- (void)setExtraPropertyWithPropertyName:(NSString *)name perportyValue:(id)value {
    objc_setAssociatedObject(self, [name UTF8String], value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

/**
 通过属性名拿到属性值
 @param name 属性名
 @return 返回属性值
 */
- (id)getExtraPropertyWithPropertyName:(NSString *)name {
    return objc_getAssociatedObject(self, [name UTF8String]);
}
@end
