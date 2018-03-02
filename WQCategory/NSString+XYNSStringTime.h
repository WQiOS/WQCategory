//
//  NSString+XYNSStringTime.h
//  xinhuammPlatform
//
//  Created by xinhuamm on 2017/12/19.
//  Copyright © 2017年 xinhuamm. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 关于时间处理的字符串类别
 */
@interface NSString (XYNSStringTime)

/**
 新华社中文版使用
 传入秒数，返回00:00:00格式
 @param seconds 秒数
 @return 返回00:00:00格式
 */
+ (NSString *)xy_convertTimeDisplayFormatWithSeconds:(NSInteger)seconds;

/**
 @param dateStr 传入时间，格式为 yyyy-MM-dd HH:mm:ss
 @return 当前时间是否大于传入时间
 */
+ (BOOL)xy_startedWithInputTime:(NSString *)dateStr;


/**
 获取当前时间距离1970年的毫秒数

 @return 毫秒数[NSString]
 */
+ (NSString *)xy_currentDateForMilliscond;
@end
