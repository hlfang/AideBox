//
//  NSDate+Easy.h
//  Design
//
//  Created by fanghailong on 15/7/10.
//  Copyright (c) 2015年 ptteng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Easy)

+(NSString *)timestamp;

+ (NSString *)getYYYYMMDDFormatByMiniSecondsSince1970:(NSNumber *)aValue;

+ (NSString *)getYYYYMMDDHHMMSSFormatByMiniSecondsSince1970:(NSNumber *)aValue;

+(NSString *)formatWithNumber:(NSNumber *)aNumber formatString:(NSString *)formatString;

+(NSString *)formatWithTimeInterval:(NSTimeInterval)interval formatString:(NSString *)formatString;

@end
