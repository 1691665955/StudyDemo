//
//  NSObject+MZDate.h
//  StudyDemo
//
//  Created by 曾龙 on 2018/7/13.
//  Copyright © 2018年 曾龙. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (MZDate)

/**
 时间转字符串
 */
+ (NSString *)dateToStringWithDate:(NSDate *)date dateFormat:(NSString *)dateFormat;

/**
 字符串转时间
 */
+ (NSDate *)stringToDateWithString:(NSString *)string dateFormat:(NSString *)dateFormat;

/**
 时间戳转字符串
 */
+ (NSString *)timeIntervalToStringWithTimeInterval:(NSTimeInterval)timeInterval dateFormat:(NSString *)dateFormat;

/**
 字符串转时间戳
 */
+ (NSTimeInterval)stringToTimeIntervalWithString:(NSString *)string dateFormat:(NSString *)dateFormat;

/**
 时间戳转特殊字符串（如果是今明两天,会将月日转换成“今天”或“明天”）
 请使用类似 “MM-dd HH:mm”这样的时间格式
 */
+ (NSString *)specialTimeIntervalToStringWithTimeInterval:(NSTimeInterval)timeInterval dateFormat:(NSString *)dateFormat;

/**
 获取当前时间戳
 */
+ (NSTimeInterval)getNowTimeInterval;
@end
