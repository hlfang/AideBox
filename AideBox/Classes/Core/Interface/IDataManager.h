//
//  IDataManager.h
//  AideBox
//
//  Created by fanghailong on 15/9/27.
//  Copyright (c) 2015年 ptteng. All rights reserved.
//  数据管理接口

#import <Foundation/Foundation.h>

@protocol IDataStore;

@protocol IDataManager <NSObject>

@optional
/**
 *  负责数据存储与获取的对象引用
 */
@property (nonatomic, strong) id<IDataStore> dataStore;

/**
 *  根据给定的url字符串将json数据保存到本地缓存
 *
 *  @param jsonData  json数据
 *  @param urlString url字符串
 *
 *  @return 如果成功保存则返回YES，否则返回NO
 */
-(BOOL)storeJsonData:(id)jsonData urlString:(NSString *)urlString;

/**
 *  根据给定的url字符串返回对应的json数据
 *
 *  @param urlString url字符串
 *
 *  @return 本地保存的json数据, 如果没有则返回nil
 */
-(id)fetchJsonDataWithUrlString:(NSString *)urlString;

@end
