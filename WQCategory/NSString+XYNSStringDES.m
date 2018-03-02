//
//  NSString+XYNSStringDES.m
//  xinhuammPlatform
//
//  Created by xinhuamm on 2017/12/18.
//  Copyright © 2017年 xinhuamm. All rights reserved.
//

#import "NSString+XYNSStringDES.h"
#include <CommonCrypto/CommonCryptor.h>
#import <CommonCrypto/CommonDigest.h>
#import <Security/Security.h>
#import <YYCategories/YYCategories.h>



@implementation NSString (XYNSStringDES)


#define kCipherKey ((uint8_t[]){'a','b','c','d','e','f','g','h','1','2','3','4','5','6','7','8'})
#define kSecret ((uint8_t[]){0x98,0x74,0x1D,0x7E,0x2D,0x6E,0xE0,0x85,0x26,0x75,0x62,0x23,0x12,0x32,0x0A,0x4C,0x00,0x46,0x4D,0xB4,0xBE,0xCA,0xF4,0xBF,0x26,0xD8,0x93,0x0B,0x8F,0xC7,0xDF,0x50})

#define kAppSecret                                          \
({                                                          \
size_t outLength = 0;                                   \
char* buf = getsct(outLength);                      \
[[NSString alloc] initWithBytes:buf                     \
length:outLength                \
encoding:NSASCIIStringEncoding];  \
})

#define _CHK_CCSUCC(status, outLength)                      \
if ((status) != kCCSuccess) {                           \
outLength = 0;                                          \
goto end;                                               \
}

#define getsct(outLength)                                \
({                                                          \
__label__ end;                                          \
char* buf = NULL;                                       \
\
CCCryptorRef cryptor = NULL;                            \
uint8_t iv[kCCBlockSizeAES128];                         \
memset(iv, 0, kCCBlockSizeAES128);                      \
\
size_t bufsize = 0;                                     \
size_t moved = 0;                                       \
size_t total = 0;                                       \
size_t inLength = sizeof(kSecret);                      \
\
_CHK_CCSUCC(CCCryptorCreate(kCCDecrypt,                 \
kCCAlgorithmAES128,                         \
kCCOptionPKCS7Padding,                      \
kCipherKey, sizeof(kCipherKey),             \
iv, &cryptor), outLength);                  \
bufsize = CCCryptorGetOutputLength(cryptor,             \
inLength, true);     \
buf = (char*)alloca(bufsize);                           \
memset(buf, 0, bufsize);                                \
\
_CHK_CCSUCC(CCCryptorUpdate(cryptor,                    \
kSecret,inLength,           \
buf, bufsize, &moved),      \
outLength);                 \
total += moved;                                         \
\
_CHK_CCSUCC(CCCryptorFinal(cryptor,                     \
buf+total,                   \
bufsize-total, &moved),      \
outLength);                  \
total += moved;                                         \
\
outLength = total;                                      \
end:                                                        \
if (cryptor) {                                          \
CCCryptorRelease(cryptor);                          \
}                                                       \
buf;                                                    \
})

+ (NSString *)xy_base64DecryptWithKeyString:(NSString *)key value:(NSString *)value {
    NSString *ciphertext = nil;
    NSData* textData = [NSData dataWithBase64EncodedString:value];
    NSUInteger dataLength = [textData length];
    unsigned char buffer[1024];
    memset(buffer, 0, sizeof(char));
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode ,
                                          [key UTF8String], kCCKeySizeDES,
                                          NULL,  //ECB模式，不需要初始化向量。
                                          [textData bytes], dataLength,
                                          buffer, 1024,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        NSData *data = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesEncrypted];
        ciphertext = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return ciphertext;
}

/**字符串加密 */
+(NSString *)xy_doEncryptStr:(NSString *)originalStr{
    
    //把string 转NSData
    NSData* data = [originalStr dataUsingEncoding:NSUTF8StringEncoding];
    
    //length
    size_t plainTextBufferSize = [data length];
    
    const void *vplainText = (const void *)[data bytes];
    
    CCCryptorStatus ccStatus;
    uint8_t *bufferPtr = NULL;
    size_t bufferPtrSize = 0;
    size_t movedBytes = 0;
    
    bufferPtrSize = (plainTextBufferSize + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    
    const void *vkey = (const void *) [kAppSecret UTF8String];
    //偏移量
    //    const void *vinitVec = nil;
    
    //配置CCCrypt
    ccStatus = CCCrypt(kCCEncrypt,
                       kCCAlgorithm3DES, //3DES
                       kCCOptionECBMode|kCCOptionPKCS7Padding, //设置模式
                       vkey,    //key
                       kCCKeySize3DES,
                       nil,     //偏移量，这里不用，设置为nil;不用的话，必须为nil,不可以为@“”
                       vplainText,
                       plainTextBufferSize,
                       (void *)bufferPtr,
                       bufferPtrSize,
                       &movedBytes);
    
    NSData *myData = [NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)movedBytes];
    NSString *result = [myData base64EncodedString];
    return result;
}


/**字符串解密 */
+(NSString*)xy_doDecEncryptStr:(NSString *)encryptStr{
    
    
    NSData *encryptData = [NSData dataWithBase64EncodedString:encryptStr];
    
    size_t plainTextBufferSize = [encryptData length];
    const void *vplainText = [encryptData bytes];
    
    CCCryptorStatus ccStatus;
    uint8_t *bufferPtr = NULL;
    size_t bufferPtrSize = 0;
    size_t movedBytes = 0;
    
    bufferPtrSize = (plainTextBufferSize + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    const void *vkey = (const void *) [kAppSecret UTF8String];
    
    const void *vinitVec = nil;
    
    ccStatus = CCCrypt(kCCDecrypt,
                       kCCAlgorithm3DES,
                       kCCOptionPKCS7Padding|kCCOptionECBMode,
                       vkey,
                       kCCKeySize3DES,
                       nil,
                       vplainText,
                       plainTextBufferSize,
                       (void *)bufferPtr,
                       bufferPtrSize,
                       &movedBytes);
    
    NSString *result = [[NSString alloc] initWithData:[NSData dataWithBytes:(const void *)bufferPtr
                                                                     length:(NSUInteger)movedBytes] encoding:NSUTF8StringEncoding];
    
    
    return result;
}




/**十六进制加密 */
+(NSString *)xy_doEncryptHex:(NSString *)originalStr{
    
    //把string 转NSData
    NSData* data = [originalStr dataUsingEncoding:NSUTF8StringEncoding];
    
    //length
    size_t plainTextBufferSize = [data length];
    
    const void *vplainText = (const void *)[data bytes];
    
    CCCryptorStatus ccStatus;
    uint8_t *bufferPtr = NULL;
    size_t bufferPtrSize = 0;
    size_t movedBytes = 0;
    
    bufferPtrSize = (plainTextBufferSize + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    
    const void *vkey = (const void *) [kAppSecret UTF8String];
    //偏移量
    const void *vinitVec = nil;
    
    //配置CCCrypt
    ccStatus = CCCrypt(kCCEncrypt,
                       kCCAlgorithm3DES, //3DES
                       kCCOptionECBMode|kCCOptionPKCS7Padding, //设置模式
                       vkey,    //key
                       kCCKeySize3DES,
                       vinitVec,     //偏移量，这里不用，设置为nil;不用的话，必须为nil,不可以为@“”
                       vplainText,
                       plainTextBufferSize,
                       (void *)bufferPtr,
                       bufferPtrSize,
                       &movedBytes);
    
    NSData *myData = [NSData dataWithBytes:(const char *)bufferPtr length:(NSUInteger)movedBytes];
    
    NSUInteger          len = [myData length];
    char *              chars = (char *)[myData bytes];
    NSMutableString *   hexString = [[NSMutableString alloc] init];
    
    for(NSUInteger i = 0; i < len; i++ )
        [hexString appendString:[NSString stringWithFormat:@"%0.2hhx", chars[i]]];
    
    return hexString;
    
}


/**十六进制解密 */
+(NSString*)xy_doDecEncryptHex:(NSString *)encryptStr{
    
    //十六进制转NSData
    long len = [encryptStr length] / 2;
    unsigned char *buf = malloc(len);
    unsigned char *whole_byte = buf;
    char byte_chars[3] = {'\0','\0','\0'};
    
    int i;
    for (i=0; i < [encryptStr length] / 2; i++) {
        byte_chars[0] = [encryptStr characterAtIndex:i*2];
        byte_chars[1] = [encryptStr characterAtIndex:i*2+1];
        *whole_byte = strtol(byte_chars, NULL, 16);
        whole_byte++;
    }
    
    NSData *encryptData = [NSData dataWithBytes:buf length:len];
    
    size_t plainTextBufferSize = [encryptData length];
    const void *vplainText = [encryptData bytes];
    
    CCCryptorStatus ccStatus;
    uint8_t *bufferPtr = NULL;
    size_t bufferPtrSize = 0;
    size_t movedBytes = 0;
    
    bufferPtrSize = (plainTextBufferSize + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    
    const void *vkey = (const void *) [kAppSecret UTF8String];
    
    const void *vinitVec = nil;
    
    ccStatus = CCCrypt(kCCDecrypt,
                       kCCAlgorithm3DES,
                       kCCOptionPKCS7Padding|kCCOptionECBMode,
                       vkey,
                       kCCKeySize3DES,
                       vinitVec,
                       vplainText,
                       plainTextBufferSize,
                       (void *)bufferPtr,
                       bufferPtrSize,
                       &movedBytes);
    
    NSString *result = [[NSString alloc] initWithData:[NSData dataWithBytes:(const void *)bufferPtr
                                                                     length:(NSUInteger)movedBytes] encoding:NSUTF8StringEncoding];
    return result;
}


@end
