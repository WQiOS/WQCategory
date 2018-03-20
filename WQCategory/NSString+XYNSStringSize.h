//
//  NSString+XYNSStringSize.h
//  xinhuammPlatform
//
//  Created by xinhuamm on 2017/12/19.
//  Copyright © 2017年 xinhuamm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


/**
 计算字符串长度、宽度、CGSize
 */
@interface NSString (XYNSStringSize)

/**
 根据字体、行数、行间距和指定的宽度constrainedWidth计算文本占据的size
 @param font label的字体
 @param numberOfLines 显示文本行数，值为0不限制行数
 @param lineSpacing 行间距
 @param constrainedWidth 文本指定的宽度
 @return 返回文本占据的size
 */
- (CGSize)xy_textSizeWithFont:(UIFont*)font
                numberOfLines:(NSInteger)numberOfLines
                  lineSpacing:(CGFloat)lineSpacing
             constrainedWidth:(CGFloat)constrainedWidth;


/**
 高度自如
 */
- (CGFloat)xy_getsTheHeightOfTheStringWithWidth:(CGFloat)width font:(UIFont *)font lineSpacing:(CGFloat)lineSpacing wordSpace:(CGFloat)wordSpace maxLines:(NSInteger)maxLines minLines:(NSInteger)minLines;

/**
 计算字符串的宽度
 
 @param stringHeight 显示的最大高度
 @param font 字体大小
 @return 宽度
 */
- (CGFloat)xy_getStringWidthWithStringHeight:(CGFloat)stringHeight font:(UIFont *)font;

/**
 计算字符串的高度
 
 @param maxWidth 显示的最大宽度
 @param font 字体大小
 @return 返回需要的高度
 */
- (CGFloat)xy_getStringHeightWithMaxWidth:(CGFloat)maxWidth Font:(UIFont *)font;

/**
 转换NSMutableAttributedString
 
 @param font 字体大小
 @param width 宽度
 @param lineSpacing 行间距
 @param wordSpace 字间距
 @param alignment alignment
 @return NSMutableAttributedString
 */
- (NSMutableAttributedString *)xy_getAttributedTextWithFont:(UIFont *)font width:(CGFloat)width lineSpacing:(CGFloat)lineSpacing wordSpace:(CGFloat)wordSpace alignment:(NSTextAlignment)alignment;


@end
