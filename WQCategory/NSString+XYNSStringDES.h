//
//  NSString+XYNSStringDES.h
//  xinhuammPlatform
//
//  Created by xinhuamm on 2017/12/18.
//  Copyright © 2017年 xinhuamm. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 字符串加解密操作
 */
@interface NSString (XYNSStringDES)

/**
 通过DES对base64字符串进行解密操作
 
 @param key 解密的key值
 @param value 需要解密的字符串
 @return 返回解密后的字符串
 */
+ (NSString *)xy_base64DecryptWithKeyString:(NSString *)key value:(NSString *)value;

/**字符串加密 */
+(NSString *)xy_doEncryptStr:(NSString *)originalStr;
/**字符串解密 */
+(NSString*)xy_doDecEncryptStr:(NSString *)encryptStr;
/**十六进制加密 */
+(NSString *)xy_doEncryptHex:(NSString *)originalStr;
/**十六进制解密 */
+(NSString*)xy_doDecEncryptHex:(NSString *)encryptStr;

@end
