//
//  NSObject+MZDate.m
//  StudyDemo
//
//  Created by 曾龙 on 2018/7/13.
//  Copyright © 2018年 曾龙. All rights reserved.
//

#import "NSObject+MZDate.h"

@implementation NSObject (MZDate)

/**
 时间转字符串
 */
+ (NSString *)dateToStringWithDate:(NSDate *)date dateFormat:(NSString *)dateFormat {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = dateFormat;
    return [formatter stringFromDate:date];
}

/**
 字符串转时间
 */
+ (NSDate *)stringToDateWithString:(NSString *)string dateFormat:(NSString *)dateFormat {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = dateFormat;
    return [formatter dateFromString:string];
}

/**
 时间戳转字符串
 */
+ (NSString *)timeIntervalToStringWithTimeInterval:(NSTimeInterval)timeInterval dateFormat:(NSString *)dateFormat {
    return [self dateToStringWithDate:[NSDate dateWithTimeIntervalSince1970:timeInterval] dateFormat:dateFormat];
}

/**
 字符串转时间戳
 */
+ (NSTimeInterval)stringToTimeIntervalWithString:(NSString *)string dateFormat:(NSString *)dateFormat {
    return [[self stringToDateWithString:string dateFormat:dateFormat] timeIntervalSince1970];
}

/**
 时间戳转特殊字符串（如果是今明两天,会将月日转换成“今天”或“明天”）
 请使用类似 “MM-dd HH:mm”这样的时间格式
 */
+ (NSString *)specialTimeIntervalToStringWithTimeInterval:(NSTimeInterval)timeInterval dateFormat:(NSString *)dateFormat {
    NSString *string = [self timeIntervalToStringWithTimeInterval:timeInterval dateFormat:dateFormat];
    NSInteger interval1 = [self getNowTimeInterval] - ((int)[self getNowTimeInterval])%(3600*24);
    NSInteger interval2 = timeInterval - ((int)timeInterval)%(3600*24);
    if (interval1 == interval2) {
        string = [string stringByReplacingCharactersInRange:NSMakeRange(0, 5) withString:@"今天"];
    } else if (interval1-interval2 == 3600*24) {
        string = [string stringByReplacingCharactersInRange:NSMakeRange(0, 5) withString:@"明天"];
    }
    return string;
}

/**
 获取当前时间戳
 */
+ (NSTimeInterval)getNowTimeInterval {
    return [[NSDate date] timeIntervalSince1970];
}
@end
