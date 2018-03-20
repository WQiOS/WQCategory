//
//  NSString+XYNSStringSize.m
//  xinhuammPlatform
//
//  Created by xinhuamm on 2017/12/19.
//  Copyright © 2017年 xinhuamm. All rights reserved.
//

#import "NSString+XYNSStringSize.h"
#import "NSString+XYNSString.h"

@implementation NSString (XYNSStringSize)

/**
 根据字体、行数、行间距和constrainedWidth计算文本占据的size
 **/
- (CGSize)xy_textSizeWithFont:(UIFont*)font
                numberOfLines:(NSInteger)numberOfLines
                  lineSpacing:(CGFloat)lineSpacing
             constrainedWidth:(CGFloat)constrainedWidth{
    
    if (self.length == 0) {
        return CGSizeZero;
    }
    CGFloat oneLineHeight = font.lineHeight;
    CGSize textSize = [self boundingRectWithSize:CGSizeMake(constrainedWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
    //  行数
    CGFloat rows = textSize.height / oneLineHeight;
    CGFloat realHeight = (int)ceil(oneLineHeight);
    // 0 不限制行数，真实高度加上行间距
    if (numberOfLines == 0) {
        if (rows >= 1) {
            realHeight = (rows * oneLineHeight) + (rows - 1) * lineSpacing;
        }
    }else{
        //  行数超过指定行数的时候，限制行数
        if (rows > numberOfLines) {
            rows = numberOfLines;
        }
        realHeight = (rows * oneLineHeight) + (rows - 1) * lineSpacing;
    }
    //  返回限制后的的宽高
    return CGSizeMake(ceilf(textSize.width), ceilf(realHeight));
}

- (CGFloat)xy_getsTheHeightOfTheStringWithWidth:(CGFloat)width font:(UIFont *)font lineSpacing:(CGFloat)lineSpacing wordSpace:(CGFloat)wordSpace maxLines:(NSInteger)maxLines minLines:(NSInteger)minLines {
    
    if ([NSString xy_isNullString:self]) {
        return 0.0f;
    }
    CGFloat maxHeight = font.lineHeight * maxLines + lineSpacing * (maxLines - 1);
    CGFloat minHeight = font.lineHeight * minLines + lineSpacing * (minLines - 1);
    CGSize orginalSize = [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT) font:font lineSpacing:lineSpacing wordSpace:wordSpace];
    
    if ((maxLines == 0) && (maxLines == 0)) { // 没有上限、没有下限
        return ceil(orginalSize.height);
    }
    
    if ((maxLines == 0) && (minLines > 0)) { // 最大没有上线、最小多少
        if (orginalSize.height < minHeight) {
            return minHeight;
        }
        else {
            return ceil(orginalSize.height);
        }
    }
    
    if ((maxLines == minLines) && (minLines != 0)) { // 最大==最少[ps:返回固定值]
        return maxHeight; // return minHeight
    }
    
    if ((maxLines > minLines) && (minLines == 0)) { // 最大多少最小不限
        if (orginalSize.height >= maxHeight) {
            return ceil(maxHeight);
        }
        else{
            return ceil(orginalSize.height);
        }
    }
    else { // 最大多少最小多少
        if (orginalSize.height >= maxHeight) {
            return ceil(maxHeight);
        }
        else if (orginalSize.height <= minHeight) {
            return ceil(minHeight);
        }
        else {
            return ceil(orginalSize.height);
        }
    }
}

/**
 计算字符串的宽度
 
 @param stringHeight 显示的最大高度
 @param font 字体大小
 @return 宽度
 */
- (CGFloat)xy_getStringWidthWithStringHeight:(CGFloat)stringHeight font:(UIFont *)font {
    
    CGFloat stringWidth = 0.0f;
    if ([NSString xy_isNullString:self]) { // 字符串为空
        return stringWidth;
    }
    else{
        CGSize detailSize = [self boundingRectWithSize:CGSizeMake(MAXFLOAT, stringHeight) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
        stringWidth = detailSize.width;
        return ceil(stringWidth);
    }
}


/**
 计算字符串的高度
 
 @param maxWidth 显示的最大宽度
 @param font 字体大小
 @return 返回需要的高度
 */
- (CGFloat)xy_getStringHeightWithMaxWidth:(CGFloat)maxWidth Font:(UIFont *)font {
    if ([NSString xy_isNullString:self]) { // 字符串为空
        return 0;
    }
    else{
        CGSize detailSize;
        detailSize = [self boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
        return ceil(detailSize.height);
    }
}

- (NSMutableAttributedString *)xy_getAttributedTextWithFont:(UIFont *)font width:(CGFloat)width lineSpacing:(CGFloat)lineSpacing wordSpace:(CGFloat)wordSpace alignment:(NSTextAlignment)alignment {
    
    if ([NSString xy_isNullString:self]) {
        return [NSMutableAttributedString new];
    }
    
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    paraStyle.alignment = alignment;
    if ([self isMoreThanOneLineWithSize:CGSizeMake(width, MAXFLOAT) font:font lineSpaceing:lineSpacing wordSpace:wordSpace]) {
        paraStyle.lineSpacing = lineSpacing; //超过一行设置行间距
    }
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@(wordSpace)};
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:self attributes:dic];
    
    return attributeStr;
}

#pragma mark -- private
// 计算文字高度
- (CGSize)boundingRectWithSize:(CGSize)size font:(UIFont *)font lineSpacing:(CGFloat)lineSpacing wordSpace:(CGFloat)wordSpace {
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = lineSpacing;
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle, NSKernAttributeName:@(wordSpace)};
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:self attributes:dic];
    [attributeString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, self.length)];
    [attributeString addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, self.length)];
    NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    CGRect rect = [attributeString boundingRectWithSize:size options:options context:nil];
    // 文本的高度减去字体高度小于等于行间距，判断为当前只有1行
    if ((rect.size.height - font.lineHeight) <= paragraphStyle.lineSpacing) {
        if ([self xy_includeChinese]) {  //如果包含中文
            rect = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height-paragraphStyle.lineSpacing);
        }
    }
    return rect.size;
}

// 计算是否超过一行
- (BOOL)isMoreThanOneLineWithSize:(CGSize)size font:(UIFont *)font lineSpaceing:(CGFloat)lineSpacing wordSpace:(CGFloat)wordSpace {
    
    if ([self boundingRectWithSize:size font:font lineSpacing:lineSpacing wordSpace:wordSpace].height > font.lineHeight) {
        return YES;
    }
    else{
        return NO;
    }
}


@end
