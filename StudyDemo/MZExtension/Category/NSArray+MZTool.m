//
//  NSArray+MZTool.m
//  StudyDemo
//
//  Created by 曾龙 on 2019/1/15.
//  Copyright © 2019年 曾龙. All rights reserved.
//

#import "NSArray+MZTool.h"

@implementation NSArray (MZTool)
- (void)caculateMaxArray:(void(^)(NSArray *maxArray,NSInteger startIndex,NSInteger endIndex))callback {
    if (!self || self.count == 0) {
        callback([NSArray array],0,0);
        return;
    }
    
    float max = 0;
    NSInteger maxStart = 0;
    NSInteger maxEnd = 0;
    
    float total = 0;
    NSInteger start = 0;
    
    for (int i=0; i<self.count; i++) {
        total += [self[i] floatValue];
        if (total < 0) {
            start = i+1;
            total = 0;
        } else {
            if (total > max) {
                maxStart = start;
                maxEnd = i;
                max = total;
            }
        }
    }
    
    NSMutableArray *newArray = [NSMutableArray array];
    if (max > 0) {
        for (NSInteger i = maxStart; i <= maxEnd; i++) {
            [newArray addObject:self[i]];
        }
    }
    
    callback(newArray,maxStart,maxEnd);
}
@end
