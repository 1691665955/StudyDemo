//
//  NSString+MZTool.m
//  StudyDemo
//
//  Created by 曾龙 on 2018/7/13.
//  Copyright © 2018年 曾龙. All rights reserved.
//

#import "NSString+MZTool.h"
#import <CommonCrypto/CommonDigest.h>
@implementation NSString (MZTool)

/**
 字符串MD5加密
 */
- (NSString *)MD5 {
    const char *cStr = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result); // This is the md5 call
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", result[i]];
    return output;
}

/**
  普通字符串转换成十六进制字符串
 */
+ (NSString *)hexStringFromString:(NSString *)string{
    NSData *myD = [string dataUsingEncoding:NSUTF8StringEncoding];
    return [self dataToHexString:myD];
}

/**
 十六进制字符串转换成普通字符串
 */
+ (NSString *)stringFromHexString:(NSString *)hexString {
    
    char *myBuffer = (char *)malloc((int)[hexString length] / 2 + 1);
    bzero(myBuffer, [hexString length] / 2 + 1);
    for (int i = 0; i < [hexString length] - 1; i += 2) {
        unsigned int anInt;
        NSString * hexCharStr = [hexString substringWithRange:NSMakeRange(i, 2)];
        NSScanner * scanner = [[NSScanner alloc] initWithString:hexCharStr];
        [scanner scanHexInt:&anInt];
        myBuffer[i / 2] = (char)anInt;
    }
    NSString *unicodeString = [NSString stringWithCString:myBuffer encoding:4];
    return unicodeString;
}


/**
 data转16进制字符串
 */
+ (NSString *)dataToHexString:(NSData *)data {
    Byte *bytes = (Byte *)[data bytes];
    NSString *result = @"";
    for (int i = 0;i < [data length]; i++) {
        NSString *string = [NSString stringWithFormat:@"%02x",bytes[i]&0xff];
        result = [NSString stringWithFormat:@"%@%@",result,string];
    }
    return result;
}


/**
 转为本地大端模式 返回Unsigned类型的数据

 @param data 转换数据
 @param location 字节起始点
 @param offset 字节数
 @return 转换为大端Unsigned数据
 */
+(unsigned short)unsignedDataTointWithData:(NSData *)data Location:(NSInteger)location Offset:(NSInteger)offset {
    unsigned short value = 0;
    NSData *intdata= [data subdataWithRange:NSMakeRange(location, offset)];
    if (offset==2) {
        value=CFSwapInt16BigToHost(*(short*)([intdata bytes]));
    }
    else if (offset==4) {
        value = CFSwapInt32BigToHost(*(short*)([intdata bytes]));
    }
    else if (offset==1) {
        unsigned char *bs = (unsigned char *)[[data subdataWithRange:NSMakeRange(location, 1) ] bytes];
        value = *bs;
    }
    return value;
}
@end
