//
//  NSString+XYNSStringRegular.h
//  xinhuammPlatform
//
//  Created by xinhuamm on 2017/12/18.
//  Copyright © 2017年 xinhuamm. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 通过正则验证
 */
@interface NSString (XYNSStringRegular)


/**
 验证邮箱

 @param email 邮箱
 @return 是否是邮箱
 */
+ (BOOL)xy_isValidateEmail:(NSString *)email;


/**
 验证电话号码

 @param mobileNumbel 电话号码
 @return 是否是电话号码
 */
+ (BOOL)xy_isValidateMobileNumber:(NSString *)mobileNumbel;

@end
