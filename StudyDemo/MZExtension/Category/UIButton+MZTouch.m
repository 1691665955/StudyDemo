//
//  UIButton+MZTouch.m
//  StudyDemo
//
//  Created by 曾龙 on 2018/8/16.
//  Copyright © 2018年 曾龙. All rights reserved.
//

#import "UIButton+MZTouch.h"
#import<objc/runtime.h>

#define defaultInterval  1.0f

@implementation UIButton (MZTouch)
static const char *UIControl_eventTimeInterval = "UIControl_eventTimeInterval";
- (void)sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    self.enabled = NO;
    [self performSelector:@selector(changeEnable) withObject:nil afterDelay:self.eventTimeInterval > 0 ? self.eventTimeInterval : defaultInterval];
    [super sendAction:action to:target forEvent:event];
}

- (void)changeEnable {
    self.enabled = YES;
}

- (NSTimeInterval)eventTimeInterval {
    return [objc_getAssociatedObject(self, UIControl_eventTimeInterval) doubleValue];
}

- (void)setEventTimeInterval:(NSTimeInterval)eventTimeInterval {
    objc_setAssociatedObject(self, UIControl_eventTimeInterval, @(eventTimeInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end
