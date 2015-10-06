//
//  NSDate+Easy.m
//  Design
//
//  Created by fanghailong on 15/7/10.
//  Copyright (c) 2015年 ptteng. All rights reserved.
//

#import "NSDate+Easy.h"

@implementation NSDate (Easy)

+(NSString *)timestamp{
    NSDate *nowTime = [NSDate date];
    NSTimeInterval interval = [nowTime timeIntervalSince1970];
    NSNumber *valInt = [NSNumber numberWithLongLong:interval];
    return [NSString stringWithFormat:@"%@", valInt];
}

+ (NSString *)getYYYYMMDDFormatByMiniSecondsSince1970:(NSNumber *)aValue
{
    if( [aValue isEqual:@""] || !aValue || [aValue isEqualToNumber:[NSNumber numberWithInt:0]])return @"--";
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSDate *date = [[NSDate alloc] initWithTimeIntervalSince1970:aValue.doubleValue/1000];
    
    return [dateFormatter stringFromDate:date];
}

+ (NSString *)getYYYYMMDDHHMMSSFormatByMiniSecondsSince1970:(NSNumber *)aValue
{
    if( !aValue || [aValue isEqualToNumber:[NSNumber numberWithInt:0]])return @"--";
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *date = [[NSDate alloc] initWithTimeIntervalSince1970:aValue.doubleValue/1000];
    
    return [dateFormatter stringFromDate:date];
}

+(NSString *)formatWithNumber:(NSNumber *)aNumber formatString:(NSString *)formatString{
    NSTimeInterval interval = [aNumber doubleValue] / 1000;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = formatString;
    NSString *resultString = [formatter stringFromDate:date];
    return resultString;
}

+(NSString *)formatWithTimeInterval:(NSTimeInterval)interval formatString:(NSString *)formatString{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = formatString;
    NSString *resultString = [formatter stringFromDate:date];
    return resultString;
}

@end
