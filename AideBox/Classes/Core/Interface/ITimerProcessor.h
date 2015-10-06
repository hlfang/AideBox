//
//  ITimerProcessor.h
//  AideBox
//
//  Created by fanghailong on 15/6/23.
//  Copyright (c) 2015年 ptteng. All rights reserved.
//  定时器管理接口

#import <Foundation/Foundation.h>

@protocol ITimerTask;

@protocol ITimerProcessor <NSObject>

@optional

/**
 *  返回当前时间
 */
+(NSTimeInterval)currentTimerInterval;

/**
 *  启动定时器
 */
+(void)beginTimer;

/**
 *  停止定时器
 */
+(void)stopTimer;

/**
 *  向定时器添加要操作的对象
 */
+(void)addTaskObjectToQueue:(id<ITimerTask>)taskObject;

/**
 *  从定时器执行队列中移除操作任务对象
 */
+(void)removeTaskObjectFromQueue:(id<ITimerTask>)taskObject;

@end

@protocol ITimerTask <NSObject>

@optional

-(void)timerChangeHandler;

@end
