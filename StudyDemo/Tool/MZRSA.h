//
//  MZRSA.h
//  StudyDemo
//
//  Created by 曾龙 on 2018/7/13.
//  Copyright © 2018年 曾龙. All rights reserved.
//

#import <Foundation/Foundation.h>

//这是个公钥示例
#define PUBLIC_KEY @"-----BEGIN PUBLIC KEY-----\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQC5H9T8TD7KT2YbcZpsVHgNeo0hfAJdJhwJsYyqKriwi2fJHXK4MU7Ad71RNEBD7T17eujHSqSoejuTwKznCDTdoWXUS2BSSYp/wDXFyT3/Tq3zYE565HWd4NhOkPXBuAK8+RDvGFDpET59yygWWOp0K9SU8McZUyZlKaKe35fo4QIDAQAB\n-----END PUBLIC KEY-----"

@interface MZRSA : NSObject
// return base64 encoded string
+ (NSString *)encryptString:(NSString *)str publicKey:(NSString *)pubKey;
// return raw data
+ (NSData *)encryptData:(NSData *)data publicKey:(NSString *)pubKey;
// return base64 encoded string
+ (NSString *)encryptString:(NSString *)str privateKey:(NSString *)privKey;
// return raw data
+ (NSData *)encryptData:(NSData *)data privateKey:(NSString *)privKey;

// decrypt base64 encoded string, convert result to string(not base64 encoded)
+ (NSString *)decryptString:(NSString *)str publicKey:(NSString *)pubKey;
+ (NSData *)decryptData:(NSData *)data publicKey:(NSString *)pubKey;
+ (NSString *)decryptString:(NSString *)str privateKey:(NSString *)privKey;
+ (NSData *)decryptData:(NSData *)data privateKey:(NSString *)privKey;
@end
