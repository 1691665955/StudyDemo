//
//  MZRSA.h
//  StudyDemo
//
//  Created by 曾龙 on 2018/7/13.
//  Copyright © 2018年 曾龙. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MZRSA : NSObject

/**
 RSA字符串公钥加密

 @param str 待加密字符串
 @param pubKey 公钥字符串
 @return 加密后字符串
 */
+ (NSString *)encryptString:(NSString *)str publicKey:(NSString *)pubKey;

/**
 RSAdata公钥加密

 @param data 待加密data
 @param pubKey 公钥字符串
 @return 加密后data
 */
+ (NSData *)encryptData:(NSData *)data publicKey:(NSString *)pubKey;

/**
 RSA字符串私钥加密
 
 @param str 待加密字符串
 @param privKey 公钥字符串
 @return 加密后字符串
 */
+ (NSString *)encryptString:(NSString *)str privateKey:(NSString *)privKey;

/**
 RSAdata私钥加密
 
 @param data 待加密data
 @param privKey 公钥字符串
 @return 加密后data
 */
+ (NSData *)encryptData:(NSData *)data privateKey:(NSString *)privKey;


/**
 RSA字符串公钥解密
 
 @param str 待解密字符串
 @param pubKey 公钥字符串
 @return 解密后字符串
 */
+ (NSString *)decryptString:(NSString *)str publicKey:(NSString *)pubKey;

/**
 RSAdata公钥解密
 
 @param data 待解密data
 @param pubKey 公钥字符串
 @return 解密后data
 */
+ (NSData *)decryptData:(NSData *)data publicKey:(NSString *)pubKey;

/**
 RSA字符串私钥解密
 
 @param str 待解密字符串
 @param privKey 公钥字符串
 @return 解密后字符串
 */
+ (NSString *)decryptString:(NSString *)str privateKey:(NSString *)privKey;

/**
 RSAdata私钥解密
 
 @param data 待解密data
 @param privKey 公钥字符串
 @return 解密后data
 */
+ (NSData *)decryptData:(NSData *)data privateKey:(NSString *)privKey;




/**
 RSA字符串公钥加密
 
 @param str 待加密字符串
 @param der 公钥文件名称
 @return 加密后字符串
 */
+ (NSString *)encryptString:(NSString *)str certificateName:(NSString *)der;

/**
 RSAdata公钥加密
 
 @param data 待加密data
 @param der 公钥文件名称
 @return 加密后data
 */
+ (NSData *)encryptData:(NSData *)data certificateName:(NSString *)der;

/**
 RSA字符串私钥加密
 
 @param str 待加密字符串
 @param p12 私钥文件名称
 @param pwd 私钥密码
 @return 加密后字符串
 */
+ (NSString *)encryptString:(NSString *)str certificateName:(NSString *)p12 pwd:(NSString *)pwd;

/**
 RSAdata私钥加密
 
 @param data 待加密data
 @param p12 私钥文件名称
 @param pwd 私钥密码
 @return 加密后data
 */
+ (NSData *)encryptData:(NSData *)data certificateName:(NSString *)p12 pwd:(NSString *)pwd;


/**
 RSA字符串公钥解密
 
 @param str 待解密字符串
 @param der 公钥文件名称
 @return 解密后字符串
 */
+ (NSString *)decryptString:(NSString *)str certificateName:(NSString *)der;

/**
 RSAdata公钥解密
 
 @param data 待解密data
 @param der 公钥文件名称
 @return 解密后data
 */
+ (NSData *)decryptData:(NSData *)data certificateName:(NSString *)der;

/**
 RSA字符串私钥解密
 
 @param str 待解密字符串
 @param p12 私钥文件名称
 @param pwd 私钥密码
 @return 解密后字符串
 */
+ (NSString *)decryptString:(NSString *)str certificateName:(NSString *)p12 pwd:(NSString *)pwd;

/**
 RSAdata私钥解密
 
 @param data 待解密data
 @param p12 私钥文件名称
 @param pwd 私钥密码
 @return 解密后data
 */
+ (NSData *)decryptData:(NSData *)data certificateName:(NSString *)p12 pwd:(NSString *)pwd;
@end
