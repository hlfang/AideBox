//
//  IDataParser.h
//  AideBox
//
//  Created by 方海龙 on 15/10/2.
//  Copyright (c) 2015年 方海龙. All rights reserved.
//  数据解析接口

#import <Foundation/Foundation.h>

@protocol IDataParser <NSObject>

@optional

/**
 *  解析成功后的数据
 */
@property (nonatomic, readonly) id successData;

/**
 *  失败后的信息
 */
@property (nonatomic, readonly) NSString *failureMessage;

/**
 *  数据解析方法
 *
 *  @param data 被解析数据
 *
 *  @return 如果解析成功返回YES，否则返回NO
 */
-(BOOL)parsing:(id)data;


@end
