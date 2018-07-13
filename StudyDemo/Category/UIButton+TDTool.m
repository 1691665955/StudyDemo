//
//  UIButton+TDTool.m
//  StudyDemo
//
//  Created by 曾龙 on 2018/7/13.
//  Copyright © 2018年 曾龙. All rights reserved.
//

#import "UIButton+TDTool.h"
#import <objc/runtime.h>
@implementation UIButton (TDTool)
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
    } else if (state == UIControlStateHighlighted) {
        propertyName = @"UIControlStateHighlighted";
    } else if (state == UIControlStateSelected) {
        propertyName = @"UIControlStateSelected";
    }
    UIColor *color = [self getExtraPropertyWithPropertyName:propertyName];
    if (color) {
        self.backgroundColor = color;
    }
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
