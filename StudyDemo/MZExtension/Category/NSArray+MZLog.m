//
//  NSArray+MZLog.m
//  StudyDemo
//
//  Created by 曾龙 on 2019/4/22.
//  Copyright © 2019年 曾龙. All rights reserved.
//

#import "NSArray+MZLog.h"
#import <objc/runtime.h>

@implementation NSArray (MZLog)
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mz_swizzleSelector([self class], @selector(descriptionWithLocale:indent:), @selector(mz_descriptionWithLocale:indent:));
    });
}

- (NSString *)mz_descriptionWithLocale:(id)locale indent:(NSUInteger)level {
    return [self stringByReplaceUnicode:[self mz_descriptionWithLocale:locale indent:level]];
}

- (NSString *)stringByReplaceUnicode:(NSString *)unicodeString {
    NSMutableString *convertedString = [unicodeString mutableCopy];
    [convertedString replaceOccurrencesOfString:@"\\U" withString:@"\\u" options:0 range:NSMakeRange(0, convertedString.length)];
    CFStringRef transform = CFSTR("Any-Hex/Java");
    CFStringTransform((__bridge CFMutableStringRef)convertedString, NULL, transform, YES);
    
    return convertedString;
}

static inline void mz_swizzleSelector(Class theClass, SEL originalSelector, SEL swizzledSelector) {
    Method originalMethod = class_getInstanceMethod(theClass, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(theClass, swizzledSelector);
    
    BOOL didAddMethod =
    class_addMethod(theClass,
                    originalSelector,
                    method_getImplementation(swizzledMethod),
                    method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(theClass,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}
@end
