//
//  HLPresentModalManager.h
//  AideBox
//
//  Created by 方海龙 on 15/9/28.
//  Copyright (c) 2015年 方海龙. All rights reserved.
//  管理弹出视图

#import <Foundation/Foundation.h>

@interface HLPresentModalManager : NSObject

+(void)presentModalView:(UIView *)modalView animation:(BOOL)animation completion:(void (^)(void))completion;

+(void)dismissModalView:(UIView *)modalView animation:(BOOL)animation completion:(void (^)(void))completion;

+(void)presentModalController:(UIViewController *)modalController animation:(BOOL)animation completion:(void (^)(void))completion;

+(void)dismissModalController:(UIViewController *)modalController animation:(BOOL)animation completion:(void (^)(void))completion;

@end
