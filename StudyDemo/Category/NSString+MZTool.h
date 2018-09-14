//
//  NSString+MZTool.h
//  StudyDemo
//
//  Created by 曾龙 on 2018/7/13.
//  Copyright © 2018年 曾龙. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MZTool)

/**
 字符串MD5加密
 */
- (NSString *)MD5;

#pragma mark -十六进制数据处理
/**
 普通字符串转换成十六进制字符串
 */
+ (NSString *)hexStringFromString:(NSString *)string;

/**
 十六进制字符串转换成普通字符串
 */
+ (NSString *)stringFromHexString:(NSString *)hexString;

/**
 data转16进制字符串
 */
+ (NSString *)dataToHexString:(NSData *)data;

/**
 转为本地大端模式 返回Unsigned类型的数据
 
 @param data 转换数据
 @param location 字节起始点
 @param offset 字节数
 @return 转换为大端Unsigned数据
 */
+(unsigned short)unsignedDataTointWithData:(NSData *)data Location:(NSInteger)location Offset:(NSInteger)offset;
@end
