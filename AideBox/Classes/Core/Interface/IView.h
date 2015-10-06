//
//  IView.h
//  AideBox
//
//  Created by fanghailong on 15/6/18.
//  Copyright (c) 2015年 ptteng. All rights reserved.
//  显示层基本接口

#import <Foundation/Foundation.h>

@protocol IDispatch;

@protocol IView <NSObject>

@optional

/**
 *  为当前controller组装一个调度器
 *
 *  @return 调度器
 */
-(id<IDispatch>)assemblyDispatch;

/**
 *  显示层持有调度层对象的应用列表，由于视图层会有请求多种数据的情况，所以视图层应该持有多个调度层引用
 */
@property (nonatomic, strong) NSMutableArray *dispatchArr;

/**
 *  根据调度器类名取得当前空闲调度器对象
 *
 *  @param clazzName 调度器类名
 *
 *  @return 空闲调度器
 */
-(id<IDispatch>)fetchDispatchInIdle:(NSString *)clazzName;

/**
 *  取得一个闲置的基础调度器对象
 *
 *  @return 空闲调度器对象
 */
-(id<IDispatch>)fetchBaseDispatchInIdle;

/**
 *  根据调度器类名称获取当前空闲的调度器对象，如果没有空闲调度器，会根据提供的类名称，创建一个
 *
 *  @param interactor   调度器类名
 *  @param interactor 交互器类名
 *
 *  @return 空闲调度器
 */
-(id<IDispatch>)fetchIdleDispatchWithDispatcher:(NSString *)dispatcher interactor:(NSString *)interactor;

@end
