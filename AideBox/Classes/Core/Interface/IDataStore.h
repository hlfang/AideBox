//
//  IDataStore.h
//  AideBox
//
//  Created by fanghailong on 15/9/27.
//  Copyright (c) 2015年 ptteng. All rights reserved.
//  数据存储接口

#import <Foundation/Foundation.h>

@protocol IDataStore <NSObject>

@optional

/**
 *  存储数据方法
 *
 *  @param aData 被存储的数据
 *  @param aPath 存储路径
 *
 *  @return 成功返回YES, 否则返回NO
 */
-(BOOL)storeData:(NSData *)aData withPath:(NSString *)aPath;

/**
 *  获取本地存储的数据
 *
 *  @param aPath 数据存储路径
 *
 *  @return 存储的数据, 如果没有数据则返回nil
 */
-(NSData *)fetchDataWithPath:(NSString *)aPath;

@end
