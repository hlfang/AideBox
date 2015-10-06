//
//  NSString+SBox.m
//  AideBox
//
//  Created by 方海龙 on 15/9/28.
//  Copyright (c) 2015年 方海龙. All rights reserved.
//

#import "NSString+SBox.h"

@implementation NSString (SBox)

+(NSString *)boxHomePath{
    NSString *dirHome = NSHomeDirectory();
    return dirHome;
}

+(NSString *)boxDocumentPath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return documentsDirectory;
}

+(NSString *)boxLibraryPath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *libraryDirectory = [paths objectAtIndex:0];
    return libraryDirectory;
}

+(NSString *)boxCachePath{
    NSArray *cacPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [cacPath objectAtIndex:0];
    return cachePath;
}

+(NSString *)boxTmpPath{
    NSString *tmpDirectory = NSTemporaryDirectory();
    
    return tmpDirectory;
}

@end
