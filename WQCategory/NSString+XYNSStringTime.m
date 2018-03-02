//
//  NSString+XYNSStringTime.m
//  xinhuammPlatform
//
//  Created by xinhuamm on 2017/12/19.
//  Copyright © 2017年 xinhuamm. All rights reserved.
//

#import "NSString+XYNSStringTime.h"

@implementation NSString (XYNSStringTime)

/**
 *  传入秒数，返回00:00:00格式
 *
 *  @return NSMutableDictionary parameters
 */
+ (NSString *)xy_convertTimeDisplayFormatWithSeconds:(NSInteger)seconds {
    
    if (seconds == 0) {
        return  @"";
    }
    //format of hour
    NSString *str_hour = [NSString stringWithFormat:@"%02ld",(long)seconds/3600];
    //format of minute
    NSString *str_minute = [NSString stringWithFormat:@"%02ld",(long)(seconds%3600)/60];
    //format of second
    NSString *str_second = [NSString stringWithFormat:@"%02ld",(long)seconds%60];
    
    //format of time
    NSString *format_time = nil;
    if ([str_hour isEqualToString:@"00"]) {
        format_time = [NSString stringWithFormat:@"%@:%@",str_minute,str_second];
    } else {
        format_time = [NSString stringWithFormat:@"%@:%@:%@",str_hour,str_minute,str_second];
    }
    
    return format_time;
}

/**
 @param dateStr 传入时间，格式为 yyyy-MM-dd HH:mm:ss
 @return 当前时间是否大于传入时间
 */
+ (BOOL)xy_startedWithInputTime:(NSString *)dateStr {
    //  对比现场时间与当前时间，如果现场已经开始，则改变按钮显示为 已开始，按钮不使能
    long long currentTime =  [NSDate date].timeIntervalSince1970;
    //  时间转换成时间戳
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateStyle:NSDateFormatterMediumStyle];
    [dateFormat setTimeStyle:NSDateFormatterShortStyle];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    long long liveStartTime  = [dateFormat dateFromString:dateStr].timeIntervalSince1970;
    return currentTime >= liveStartTime;
}

/**
 获取当前时间距离1970年的毫秒数
 
 @return 毫秒数
 */
+ (NSString *)xy_currentDateForMilliscond {
    NSTimeInterval nowtime = [[NSDate date] timeIntervalSince1970]*1000;
    long long theTime = [[NSNumber numberWithDouble:nowtime] longLongValue];
    NSString *currentDate = [NSString stringWithFormat:@"%llu",theTime];
    return currentDate;
}

@end
