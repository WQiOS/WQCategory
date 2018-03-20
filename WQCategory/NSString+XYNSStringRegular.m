//
//  NSString+XYNSStringRegular.m
//  xinhuammPlatform
//
//  Created by xinhuamm on 2017/12/18.
//  Copyright © 2017年 xinhuamm. All rights reserved.
//

#import "NSString+XYNSStringRegular.h"

@implementation NSString (XYNSStringRegular)

/**
 验证邮箱
 
 @param email 邮箱
 @return 是否是邮箱
 */
+ (BOOL)xy_isValidateEmail:(NSString *)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",emailRegex];
    return [emailTest evaluateWithObject:email];
}

/**
 验证电话号码
 
 @param mobileNumbel 电话号码
 @return 是否是电话号码
 */
+ (BOOL)xy_isValidateMobileNumber:(NSString *)mobileNumbel {
    //  首先进行手机号长度的判断
    //  首先去除首尾的空格
    NSString *str = [mobileNumbel stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if (str.length >= 5 && str.length <= 16) {
        NSString *aaa = @"^\\s*\\+?\\s*(\\(\\s*\\d+\\s*\\)|\\d+)(\\s*-?\\s*(\\(\\s*\\d+\\s*\\)|\\s*\\d+\\s*))*\\s*$";
        NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", aaa];
        if (([regextestct evaluateWithObject:mobileNumbel])) {
            return YES;
        }
        return NO;
    }else{
        return NO;
    }
    
}

@end
