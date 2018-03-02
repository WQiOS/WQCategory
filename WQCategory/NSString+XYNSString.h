//
//  NSString+XYNSString.h
//  xinhuammPlatform
//
//  Created by xinhuamm on 2017/12/19.
//  Copyright © 2017年 xinhuamm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 字符串的一些常用操作方法
 */
@interface NSString (XYNSString)

/**
 判断字符串是否为空
 
 @return 是否
 */
+ (BOOL)xy_isNullString:(NSString *)string;


/**
 对字符串中的汉字进行utf8编码【PS：没有汉字不会进行编码】
 
 @return 编码后的字符串
 */
- (NSString *)xy_encodeStringUtf8;

/**
 判断字符串里面是否含有汉字
 @return BOOL
 */
- (BOOL)xy_includeChinese;

/**
 能够知道label的每一行显示的内容，和一共有多少行
 @param width label的宽度
 @param fontSize 字体大小
 @param string 显示的字符串
 @return 返回NSArray
 */
+ (NSArray *)xy_getLinesArrayOfStringInWidth:(CGFloat)width fontSize:(UIFont *)fontSize  string:(NSString *)string;

@end
