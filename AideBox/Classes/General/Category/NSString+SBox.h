//
//  NSString+SBox.h
//  AideBox
//
//  Created by 方海龙 on 15/9/28.
//  Copyright (c) 2015年 方海龙. All rights reserved.
//  安全沙盒路径扩展

#import <Foundation/Foundation.h>

@interface NSString (SBox)

/**
 *  获取应用沙盒根路径
 *
 *  @return 根路径
 */
+(NSString *)boxHomePath;

/**
 *  获取Documents目录路径
 *
 *  @return Documents目录路径
 */
+(NSString *)boxDocumentPath;

/**
 *  获取Library目录路径
 *
 *  @return Library目录路径
 */
+(NSString *)boxLibraryPath;

/**
 *  获取Cache目录路径
 *
 *  @return Cache目录路径
 */
+(NSString *)boxCachePath;

/**
 *  获取Tmp目录路径
 *
 *  @return Tmp目录路径
 */
+(NSString *)boxTmpPath;

@end
