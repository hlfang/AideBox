//
//  HLTimerManager.m
//  AideBox
//
//  Created by 方海龙 on 15/9/28.
//  Copyright (c) 2015年 方海龙. All rights reserved.
//

#import "HLTimerManager.h"

@interface HLTimerManager(){
    NSTimer *_countDownTimer;
    NSTimeInterval _currentTimerInterval;
    NSMutableArray *_taskQueue;
}

@end

@implementation HLTimerManager

static HLTimerManager *instance = nil;

+(HLTimerManager *)shareInstance{
    @synchronized(self){
        if(!instance){
            instance = [[self alloc] init];
        }
    }
    return instance;
}

+(NSTimeInterval)currentTimerInterval{
    HLTimerManager *tInstance = [HLTimerManager shareInstance];
    return [tInstance currentTimerIntervalImpl];
}

-(NSTimeInterval)currentTimerIntervalImpl{
    return _currentTimerInterval;
}

+(void)addTaskObjectToQueue:(id<ITimerTask>)taskObject{
    HLTimerManager *tInstance = [HLTimerManager shareInstance];
    [tInstance addTaskObjectToQueueImpl:taskObject];
}

-(void)addTaskObjectToQueueImpl:(id<ITimerTask>)taskObject{
    if(!taskObject){
        return;
    }
    if(!_taskQueue){
        _taskQueue = @[].mutableCopy;
    }
    if([_taskQueue containsObject:taskObject]){
        return;
    }
    [_taskQueue addObject:taskObject];
}

+(void)removeTaskObjectFromQueue:(id<ITimerTask>)taskObject{
    HLTimerManager *tInstance = [HLTimerManager shareInstance];
    [tInstance removeTaskObjectFromQueueImpl:taskObject];
}

-(void)removeTaskObjectFromQueueImpl:(id<ITimerTask>)taskObject{
    if(!taskObject || _taskQueue.count == 0){
        return;
    }
    
    if([_taskQueue containsObject:taskObject]){
        [_taskQueue removeObject:taskObject];
    }
}

+(void)beginTimer{
    HLTimerManager *tInstance = [HLTimerManager shareInstance];
    [tInstance beginTimerImpl];
}

-(void)beginTimerImpl{
    _currentTimerInterval = [[NSDate date] timeIntervalSince1970];
    _countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timerHandler) userInfo:nil repeats:YES];
}

-(void)timerHandler{
    _currentTimerInterval++;
    for(id<ITimerTask> taskObject in _taskQueue){
        if([taskObject respondsToSelector:@selector(timerChangeHandler)]){
            [taskObject performSelector:@selector(timerChangeHandler)];
        }
    }
}

+(void)stopTimer{
    HLTimerManager *tInstance = [HLTimerManager shareInstance];
    [tInstance stopTimerImpl];
}

-(void)stopTimerImpl{
    [_countDownTimer invalidate];
    _countDownTimer = nil;
}

-(void)dealloc{
    [self stopTimerImpl];
    [_taskQueue removeAllObjects];
    _taskQueue = nil;
}

@end
