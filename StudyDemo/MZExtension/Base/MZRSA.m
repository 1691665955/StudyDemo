//
//  MZRSA.m
//  StudyDemo
//
//  Created by 曾龙 on 2018/7/13.
//  Copyright © 2018年 曾龙. All rights reserved.
//

#import "MZRSA.h"
#import <Security/Security.h>
@implementation MZRSA
static NSString *base64_encode_data(NSData *data){
    data = [data base64EncodedDataWithOptions:0];
    NSString *ret = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return ret;
}

static NSData *base64_decode(NSString *str){
    NSData *data = [[NSData alloc] initWithBase64EncodedString:str options:NSDataBase64DecodingIgnoreUnknownCharacters];
    return data;
}

+ (NSData *)stripPublicKeyHeader:(NSData *)d_key{
    // Skip ASN.1 public key header
    if (d_key == nil) return(nil);
    
    unsigned long len = [d_key length];
    if (!len) return(nil);
    
    unsigned char *c_key = (unsigned char *)[d_key bytes];
    unsigned int  idx     = 0;
    
    if (c_key[idx++] != 0x30) return(nil);
    
    if (c_key[idx] > 0x80) idx += c_key[idx] - 0x80 + 1;
    else idx++;
    
    // PKCS #1 rsaEncryption szOID_RSA_RSA
    static unsigned char seqiod[] =
    { 0x30,   0x0d, 0x06, 0x09, 0x2a, 0x86, 0x48, 0x86, 0xf7, 0x0d, 0x01, 0x01,
        0x01, 0x05, 0x00 };
    if (memcmp(&c_key[idx], seqiod, 15)) return(nil);
    
    idx += 15;
    
    if (c_key[idx++] != 0x03) return(nil);
    
    if (c_key[idx] > 0x80) idx += c_key[idx] - 0x80 + 1;
    else idx++;
    
    if (c_key[idx++] != '\0') return(nil);
    
    // Now make a new NSData from this buffer
    return([NSData dataWithBytes:&c_key[idx] length:len - idx]);
}

+ (NSData *)stripPrivateKeyHeader:(NSData *)d_key{
    // Skip ASN.1 private key header
    if (d_key == nil) return(nil);
    
    unsigned long len = [d_key length];
    if (!len) return(nil);
    
    unsigned char *c_key = (unsigned char *)[d_key bytes];
    unsigned int  idx     = 22; //magic byte at offset 22
    
    if (0x04 != c_key[idx++]) return nil;
    
    //calculate length of the key
    unsigned int c_len = c_key[idx++];
    int det = c_len & 0x80;
    if (!det) {
        c_len = c_len & 0x7f;
    } else {
        int byteCount = c_len & 0x7f;
        if (byteCount + idx > len) {
            //rsa length field longer than buffer
            return nil;
        }
        unsigned int accum = 0;
        unsigned char *ptr = &c_key[idx];
        idx += byteCount;
        while (byteCount) {
            accum = (accum << 8) + *ptr;
            ptr++;
            byteCount--;
        }
        c_len = accum;
    }
    
    // Now make a new NSData from this buffer
    return [d_key subdataWithRange:NSMakeRange(idx, c_len)];
}

+ (SecKeyRef)addPublicKey:(NSString *)key{
    NSRange spos = [key rangeOfString:@"-----BEGIN PUBLIC KEY-----"];
    NSRange epos = [key rangeOfString:@"-----END PUBLIC KEY-----"];
    if(spos.location != NSNotFound && epos.location != NSNotFound){
        NSUInteger s = spos.location + spos.length;
        NSUInteger e = epos.location;
        NSRange range = NSMakeRange(s, e-s);
        key = [key substringWithRange:range];
    }
    key = [key stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    key = [key stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    key = [key stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    key = [key stringByReplacingOccurrencesOfString:@" "  withString:@""];
    
    // This will be base64 encoded, decode it.
    NSData *data = base64_decode(key);
    data = [MZRSA stripPublicKeyHeader:data];
    if(!data){
        return nil;
    }
    
    //a tag to read/write keychain storage
    NSString *tag = @"RSAUtil_PubKey";
    NSData *d_tag = [NSData dataWithBytes:[tag UTF8String] length:[tag length]];
    
    // Delete any old lingering key with the same tag
    NSMutableDictionary *publicKey = [[NSMutableDictionary alloc] init];
    [publicKey setObject:(__bridge id) kSecClassKey forKey:(__bridge id)kSecClass];
    [publicKey setObject:(__bridge id) kSecAttrKeyTypeRSA forKey:(__bridge id)kSecAttrKeyType];
    [publicKey setObject:d_tag forKey:(__bridge id)kSecAttrApplicationTag];
    SecItemDelete((__bridge CFDictionaryRef)publicKey);
    
    // Add persistent version of the key to system keychain
    [publicKey setObject:data forKey:(__bridge id)kSecValueData];
    [publicKey setObject:(__bridge id) kSecAttrKeyClassPublic forKey:(__bridge id)
     kSecAttrKeyClass];
    [publicKey setObject:[NSNumber numberWithBool:YES] forKey:(__bridge id)
     kSecReturnPersistentRef];
    
    CFTypeRef persistKey = nil;
    OSStatus status = SecItemAdd((__bridge CFDictionaryRef)publicKey, &persistKey);
    if (persistKey != nil){
        CFRelease(persistKey);
    }
    if ((status != noErr) && (status != errSecDuplicateItem)) {
        return nil;
    }
    
    [publicKey removeObjectForKey:(__bridge id)kSecValueData];
    [publicKey removeObjectForKey:(__bridge id)kSecReturnPersistentRef];
    [publicKey setObject:[NSNumber numberWithBool:YES] forKey:(__bridge id)kSecReturnRef];
    [publicKey setObject:(__bridge id) kSecAttrKeyTypeRSA forKey:(__bridge id)kSecAttrKeyType];
    
    // Now fetch the SecKeyRef version of the key
    SecKeyRef keyRef = nil;
    status = SecItemCopyMatching((__bridge CFDictionaryRef)publicKey, (CFTypeRef *)&keyRef);
    if(status != noErr){
        return nil;
    }
    return keyRef;
}

+ (SecKeyRef)addPrivateKey:(NSString *)key{
    NSRange spos;
    NSRange epos;
    spos = [key rangeOfString:@"-----BEGIN RSA PRIVATE KEY-----"];
    if(spos.length > 0){
        epos = [key rangeOfString:@"-----END RSA PRIVATE KEY-----"];
    }else{
        spos = [key rangeOfString:@"-----BEGIN PRIVATE KEY-----"];
        epos = [key rangeOfString:@"-----END PRIVATE KEY-----"];
    }
    if(spos.location != NSNotFound && epos.location != NSNotFound){
        NSUInteger s = spos.location + spos.length;
        NSUInteger e = epos.location;
        NSRange range = NSMakeRange(s, e-s);
        key = [key substringWithRange:range];
    }
    key = [key stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    key = [key stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    key = [key stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    key = [key stringByReplacingOccurrencesOfString:@" "  withString:@""];
    
    // This will be base64 encoded, decode it.
    NSData *data = base64_decode(key);
    data = [MZRSA stripPrivateKeyHeader:data];
    if(!data){
        return nil;
    }
    
    //a tag to read/write keychain storage
    NSString *tag = @"RSAUtil_PrivKey";
    NSData *d_tag = [NSData dataWithBytes:[tag UTF8String] length:[tag length]];
    
    // Delete any old lingering key with the same tag
    NSMutableDictionary *privateKey = [[NSMutableDictionary alloc] init];
    [privateKey setObject:(__bridge id) kSecClassKey forKey:(__bridge id)kSecClass];
    [privateKey setObject:(__bridge id) kSecAttrKeyTypeRSA forKey:(__bridge id)kSecAttrKeyType];
    [privateKey setObject:d_tag forKey:(__bridge id)kSecAttrApplicationTag];
    SecItemDelete((__bridge CFDictionaryRef)privateKey);
    
    // Add persistent version of the key to system keychain
    [privateKey setObject:data forKey:(__bridge id)kSecValueData];
    [privateKey setObject:(__bridge id) kSecAttrKeyClassPrivate forKey:(__bridge id)
     kSecAttrKeyClass];
    [privateKey setObject:[NSNumber numberWithBool:YES] forKey:(__bridge id)
     kSecReturnPersistentRef];
    
    CFTypeRef persistKey = nil;
    OSStatus status = SecItemAdd((__bridge CFDictionaryRef)privateKey, &persistKey);
    if (persistKey != nil){
        CFRelease(persistKey);
    }
    if ((status != noErr) && (status != errSecDuplicateItem)) {
        return nil;
    }
    
    [privateKey removeObjectForKey:(__bridge id)kSecValueData];
    [privateKey removeObjectForKey:(__bridge id)kSecReturnPersistentRef];
    [privateKey setObject:[NSNumber numberWithBool:YES] forKey:(__bridge id)kSecReturnRef];
    [privateKey setObject:(__bridge id) kSecAttrKeyTypeRSA forKey:(__bridge id)kSecAttrKeyType];
    
    // Now fetch the SecKeyRef version of the key
    SecKeyRef keyRef = nil;
    status = SecItemCopyMatching((__bridge CFDictionaryRef)privateKey, (CFTypeRef *)&keyRef);
    if(status != noErr){
        return nil;
    }
    return keyRef;
}

/* START: Encryption & Decryption with RSA private key */

+ (NSData *)encryptData:(NSData *)data withKeyRef:(SecKeyRef) keyRef isSign:(BOOL)isSign {
    const uint8_t *srcbuf = (const uint8_t *)[data bytes];
    size_t srclen = (size_t)data.length;
    
    size_t block_size = SecKeyGetBlockSize(keyRef) * sizeof(uint8_t);
    void *outbuf = malloc(block_size);
    size_t src_block_size = block_size - 11;
    
    NSMutableData *ret = [[NSMutableData alloc] init];
    for(int idx=0; idx<srclen; idx+=src_block_size){
        //NSLog(@"%d/%d block_size: %d", idx, (int)srclen, (int)block_size);
        size_t data_len = srclen - idx;
        if(data_len > src_block_size){
            data_len = src_block_size;
        }
        
        size_t outlen = block_size;
        OSStatus status = noErr;
        
        if (isSign) {
            status = SecKeyRawSign(keyRef,
                                   kSecPaddingPKCS1,
                                   srcbuf + idx,
                                   data_len,
                                   outbuf,
                                   &outlen
                                   );
        } else {
            status = SecKeyEncrypt(keyRef,
                                   kSecPaddingPKCS1,
                                   srcbuf + idx,
                                   data_len,
                                   outbuf,
                                   &outlen
                                   );
        }
        if (status != 0) {
            NSLog(@"SecKeyEncrypt fail. Error Code: %d", status);
            ret = nil;
            break;
        }else{
            [ret appendBytes:outbuf length:outlen];
        }
    }
    
    free(outbuf);
    CFRelease(keyRef);
    return ret;
}

+ (NSString *)encryptString:(NSString *)str privateKey:(NSString *)privKey{
    NSData *data = [MZRSA encryptData:[str dataUsingEncoding:NSUTF8StringEncoding] privateKey:privKey];
    NSString *ret = base64_encode_data(data);
    return ret;
}

+ (NSData *)encryptData:(NSData *)data privateKey:(NSString *)privKey{
    if(!data || !privKey){
        return nil;
    }
    SecKeyRef keyRef = [MZRSA addPrivateKey:privKey];
    if(!keyRef){
        return nil;
    }
    return [MZRSA encryptData:data withKeyRef:keyRef isSign:YES];
}

+ (NSData *)decryptData:(NSData *)data withKeyRef:(SecKeyRef) keyRef{
    const uint8_t *srcbuf = (const uint8_t *)[data bytes];
    size_t srclen = (size_t)data.length;
    
    size_t block_size = SecKeyGetBlockSize(keyRef) * sizeof(uint8_t);
    UInt8 *outbuf = malloc(block_size);
    size_t src_block_size = block_size;
    
    NSMutableData *ret = [[NSMutableData alloc] init];
    for(int idx=0; idx<srclen; idx+=src_block_size){
        //NSLog(@"%d/%d block_size: %d", idx, (int)srclen, (int)block_size);
        size_t data_len = srclen - idx;
        if(data_len > src_block_size){
            data_len = src_block_size;
        }
        
        size_t outlen = block_size;
        OSStatus status = noErr;
        status = SecKeyDecrypt(keyRef,
                               kSecPaddingNone,
                               srcbuf + idx,
                               data_len,
                               outbuf,
                               &outlen
                               );
        if (status != 0) {
            NSLog(@"SecKeyEncrypt fail. Error Code: %d", status);
            ret = nil;
            break;
        }else{
            //the actual decrypted data is in the middle, locate it!
            int idxFirstZero = -1;
            int idxNextZero = (int)outlen;
            for ( int i = 0; i < outlen; i++ ) {
                if ( outbuf[i] == 0 ) {
                    if ( idxFirstZero < 0 ) {
                        idxFirstZero = i;
                    } else {
                        idxNextZero = i;
                        break;
                    }
                }
            }
            
            [ret appendBytes:&outbuf[idxFirstZero+1] length:idxNextZero-idxFirstZero-1];
        }
    }
    
    free(outbuf);
    CFRelease(keyRef);
    return ret;
}


+ (NSString *)decryptString:(NSString *)str privateKey:(NSString *)privKey{
    NSData *data = [[NSData alloc] initWithBase64EncodedString:str options:NSDataBase64DecodingIgnoreUnknownCharacters];
    data = [MZRSA decryptData:data privateKey:privKey];
    NSString *ret = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return ret;
}

+ (NSData *)decryptData:(NSData *)data privateKey:(NSString *)privKey{
    if(!data || !privKey){
        return nil;
    }
    SecKeyRef keyRef = [MZRSA addPrivateKey:privKey];
    if(!keyRef){
        return nil;
    }
    return [MZRSA decryptData:data withKeyRef:keyRef];
}

/* END: Encryption & Decryption with RSA private key */

/* START: Encryption & Decryption with RSA public key */

+ (NSString *)encryptString:(NSString *)str publicKey:(NSString *)pubKey{
    NSData *data = [MZRSA encryptData:[str dataUsingEncoding:NSUTF8StringEncoding] publicKey:pubKey];
    NSString *ret = base64_encode_data(data);
    return ret;
}

+ (NSData *)encryptData:(NSData *)data publicKey:(NSString *)pubKey{
    if(!data || !pubKey){
        return nil;
    }
    SecKeyRef keyRef = [MZRSA addPublicKey:pubKey];
    if(!keyRef){
        return nil;
    }
    return [MZRSA encryptData:data withKeyRef:keyRef isSign:NO];
}

+ (NSString *)decryptString:(NSString *)str publicKey:(NSString *)pubKey{
    NSData *data = [[NSData alloc] initWithBase64EncodedString:str options:NSDataBase64DecodingIgnoreUnknownCharacters];
    data = [MZRSA decryptData:data publicKey:pubKey];
    NSString *ret = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return ret;
}

+ (NSData *)decryptData:(NSData *)data publicKey:(NSString *)pubKey{
    if(!data || !pubKey){
        return nil;
    }
    SecKeyRef keyRef = [MZRSA addPublicKey:pubKey];
    if(!keyRef){
        return nil;
    }
    return [MZRSA decryptData:data withKeyRef:keyRef];
}

/* END: Encryption & Decryption with RSA public key */

/**
 获取公钥
 
 @param der public_key.der
 @return 公钥
 */
+ (SecKeyRef)publicKeyWithCertificate:(NSString *)der {
    NSString *keyPath = [[NSBundle mainBundle] pathForResource:der ofType:nil];
    NSData *derData = [NSData dataWithContentsOfFile:keyPath];
    if (!derData) {
        return nil;
    }
    SecCertificateRef cert = SecCertificateCreateWithData(NULL, (CFDataRef)derData);
    SecKeyRef key = nil;
    SecTrustRef trust = nil;
    SecPolicyRef policy = nil;
    if (cert != NULL) {
        policy = SecPolicyCreateBasicX509();
        if (policy) {
            if (SecTrustCreateWithCertificates((CFTypeRef)cert, policy, &trust) == noErr) {
                SecTrustResultType result;
                if (SecTrustEvaluate(trust, &result) == noErr) {
                    key = SecTrustCopyPublicKey(trust);
                }
            }
        }
    }
    if (policy) {
        CFRelease(policy);
    }
    if (trust) {
        CFRelease(trust);
    }
    if (cert) {
        CFRelease(cert);
    }
    return key;
}

/**
 获取私钥
 
 @param p12 private_key.p12
 @return 私钥
 */
+ (SecKeyRef)privateKeyWithCertificate:(NSString *)p12 certificatePWD:(NSString *)pwd {
    if (!p12) {
        return nil;
    }
    NSString *keyPath = [[NSBundle mainBundle] pathForResource:p12 ofType:nil];
    NSData *p12Data = [NSData dataWithContentsOfFile:keyPath];
    if (!p12Data) {
        return nil;
    }
    if (!pwd) {
        pwd = @"";
    }
    SecKeyRef key = NULL;
    NSMutableDictionary * options = [[NSMutableDictionary alloc] init];
    [options setObject:pwd forKey:(__bridge id)kSecImportExportPassphrase];
    CFArrayRef items = CFArrayCreate(NULL, 0, 0, NULL);
    OSStatus securityError = SecPKCS12Import((__bridge CFDataRef) p12Data, (__bridge CFDictionaryRef)options, &items);
    if (securityError == noErr && CFArrayGetCount(items) > 0) {
        CFDictionaryRef identityDict = CFArrayGetValueAtIndex(items, 0);
        SecIdentityRef identityApp = (SecIdentityRef)CFDictionaryGetValue(identityDict, kSecImportItemIdentity);
        securityError = SecIdentityCopyPrivateKey(identityApp, &key);
        if (securityError != noErr) {
            key = NULL;
        }
    }
    if (items) {
        CFRelease(items);
    }
    return key;
}

/**
 RSA字符串公钥加密
 
 @param str 待加密字符串
 @param der 公钥文件名称
 @return 加密后字符串
 */
+ (NSString *)encryptString:(NSString *)str certificateName:(NSString *)der {
    if (!der || !str) {
        return nil;
    }
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    SecKeyRef keyRef = [self publicKeyWithCertificate:der];
    if (!keyRef) {
        return nil;
    }
    NSData *encryptData = [MZRSA encryptData:data withKeyRef:keyRef isSign:NO];
    NSString *ret = base64_encode_data(encryptData);
    return ret;
}

/**
 RSAdata公钥加密
 
 @param data 待加密data
 @param der 公钥文件名称
 @return 加密后data
 */
+ (NSData *)encryptData:(NSData *)data certificateName:(NSString *)der {
    if (!der || !data) {
        return nil;
    }
    SecKeyRef keyRef = [self publicKeyWithCertificate:der];
    if (!keyRef) {
        return nil;
    }
    NSData *encryptData = [MZRSA encryptData:data withKeyRef:keyRef isSign:NO];
    return encryptData;
}

/**
 RSA字符串私钥加密
 
 @param str 待加密字符串
 @param p12 私钥文件名称
 @param pwd 私钥密码
 @return 加密后字符串
 */
+ (NSString *)encryptString:(NSString *)str certificateName:(NSString *)p12 pwd:(NSString *)pwd {
    if (!p12 || !str) {
        return nil;
    }
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    SecKeyRef keyRef = [self privateKeyWithCertificate:p12 certificatePWD:p12];
    if (!keyRef) {
        return nil;
    }
    NSData *encryptData = [MZRSA encryptData:data withKeyRef:keyRef isSign:YES];
    NSString *ret = base64_encode_data(encryptData);
    return ret;
}

/**
 RSAdata私钥加密
 
 @param data 待加密data
 @param p12 私钥文件名称
 @param pwd 私钥密码
 @return 加密后data
 */
+ (NSData *)encryptData:(NSData *)data certificateName:(NSString *)p12 pwd:(NSString *)pwd {
    if (!p12 || !data) {
        return nil;
    }
    SecKeyRef keyRef = [self privateKeyWithCertificate:p12 certificatePWD:p12];
    if (!keyRef) {
        return nil;
    }
    NSData *encryptData = [MZRSA encryptData:data withKeyRef:keyRef isSign:YES];
    return encryptData;
}


/**
 RSA字符串公钥解密
 
 @param str 待解密字符串
 @param der 公钥文件名称
 @return 解密后字符串
 */
+ (NSString *)decryptString:(NSString *)str certificateName:(NSString *)der {
    if (!der || !str) {
        return nil;
    }
    NSData *data = [[NSData alloc] initWithBase64EncodedString:str options:0];
    SecKeyRef keyRef = [self publicKeyWithCertificate:der];
    if (!keyRef) {
        return nil;
    }
    NSData *decryptData = [MZRSA decryptData:data withKeyRef:keyRef];
    return [[NSString alloc] initWithData:decryptData encoding:NSUTF8StringEncoding];
}

/**
 RSAdata公钥解密
 
 @param data 待解密data
 @param der 公钥文件名称
 @return 解密后data
 */
+ (NSData *)decryptData:(NSData *)data certificateName:(NSString *)der {
    if (!der || !data) {
        return nil;
    }
    SecKeyRef keyRef = [self publicKeyWithCertificate:der];
    if (!keyRef) {
        return nil;
    }
    NSData *decryptData = [MZRSA decryptData:data withKeyRef:keyRef];
    return decryptData;
}

/**
 RSA字符串私钥解密
 
 @param str 待解密字符串
 @param p12 私钥文件名称
 @param pwd 私钥密码
 @return 解密后字符串
 */
+ (NSString *)decryptString:(NSString *)str certificateName:(NSString *)p12 pwd:(NSString *)pwd {
    if (!p12 || !str) {
        return nil;
    }
    NSData *data = [[NSData alloc] initWithBase64EncodedString:str options:0];
    SecKeyRef keyRef = [self privateKeyWithCertificate:p12 certificatePWD:p12];
    if (!keyRef) {
        return nil;
    }
    NSData *decryptData = [MZRSA decryptData:data withKeyRef:keyRef];
    return [[NSString alloc] initWithData:decryptData encoding:NSUTF8StringEncoding];
}

/**
 RSAdata私钥解密
 
 @param data 待解密data
 @param p12 私钥文件名称
 @param pwd 私钥密码
 @return 解密后data
 */
+ (NSData *)decryptData:(NSData *)data certificateName:(NSString *)p12 pwd:(NSString *)pwd {
    if (!p12 || !data) {
        return nil;
    }
    SecKeyRef keyRef = [self privateKeyWithCertificate:p12 certificatePWD:p12];
    if (!keyRef) {
        return nil;
    }
    NSData *decryptData = [MZRSA decryptData:data withKeyRef:keyRef];
    return decryptData;
}
@end
