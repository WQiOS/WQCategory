//
//  NSString+XYNSString.m
//  xinhuammPlatform
//
//  Created by xinhuamm on 2017/12/19.
//  Copyright © 2017年 xinhuamm. All rights reserved.
//

#import "NSString+XYNSString.h"
#import <CoreText/CoreText.h>

@implementation NSString (XYNSString)

/**
 判断字符串是否为空
 
 @return 是否
 */
+ (BOOL)xy_isNullString:(NSString *)string {
    if (((![string isKindOfClass:[NSString class]])||[string isEqualToString:@""] || (string == nil) || [string isEqualToString:@""] || [string isKindOfClass:[NSNull class]]||[[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0 || [string isEqualToString:@"(null)"])) {
        return YES;
    }
    else {
        return NO;
    }
}

/**
 对字符串中的汉字进行utf8编码【PS：没有汉字不会进行编码】
 
 @return 编码后的字符串
 */
- (NSString *)xy_encodeStringUtf8 {
    if ([NSString xy_isNullString:self]) {
        return @"";
    }
    NSString *urlString = [self stringByReplacingOccurrencesOfString:@" " withString:@""];
    if ([urlString xy_includeChinese]) {
        NSString *encodedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes( kCFAllocatorDefault, (CFStringRef)urlString, NULL, NULL,  kCFStringEncodingUTF8));
        return encodedString;
    }
    else {
        return urlString;
    }
}

/**
 判断字符串里面是否含有汉字
 
 @return 是否
 */
- (BOOL)xy_includeChinese {
    for(int i = 0; i < [self length]; i++) {
        int a = [self characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff){
            return YES;
        }
    }
    return NO;
}

/**
 能够知道label的每一行显示的内容，和一共有多少行
 @param width label的宽度
 @param fontSize 字体大小
 @param string 显示的字符串
 @return 返回NSArray
 */
+ (NSArray *)xy_getLinesArrayOfStringInWidth:(CGFloat)width fontSize:(UIFont *)fontSize  string:(NSString *)string {
    if ([NSString xy_isNullString:string]) {
        return [NSArray new];
    }
    NSString *text = string;
    UIFont *font = fontSize;
    
    CTFontRef myFont = CTFontCreateWithName(( CFStringRef)([font fontName]), [font pointSize], NULL);
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:text];
    [attStr addAttribute:(NSString *)kCTFontAttributeName value:(__bridge  id)myFont range:NSMakeRange(0, attStr.length)];
    CFRelease(myFont);
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString(( CFAttributedStringRef)attStr);
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(0,0,width,100000));
    CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), path, NULL);
    NSArray *lines = ( NSArray *)CTFrameGetLines(frame);
    NSMutableArray *linesArray = [[NSMutableArray alloc]init];
    for (id line in lines) {
        CTLineRef lineRef = (__bridge  CTLineRef )line;
        CFRange lineRange = CTLineGetStringRange(lineRef);
        NSRange range = NSMakeRange(lineRange.location, lineRange.length);
        NSString *lineString = [text substringWithRange:range];
        CFAttributedStringSetAttribute((CFMutableAttributedStringRef)attStr, lineRange, kCTKernAttributeName, (CFTypeRef)([NSNumber numberWithFloat:0.0]));
        CFAttributedStringSetAttribute((CFMutableAttributedStringRef)attStr, lineRange, kCTKernAttributeName, (CFTypeRef)([NSNumber numberWithInt:0.0]));
        [linesArray addObject:lineString];
    }
    
    CGPathRelease(path);
    CFRelease( frame );
    CFRelease(frameSetter);
    return (NSArray *)linesArray;
}


@end
