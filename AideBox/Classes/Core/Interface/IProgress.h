//
//  IProgress.h
//  AideBox
//
//  Created by fanghailong on 15/6/18.
//  Copyright (c) 2015年 ptteng. All rights reserved.
//  显示进度接口

#import <Foundation/Foundation.h>

@protocol IProgress <NSObject>

@optional

-(void)showProgressWithMessage:(NSString *)aMess;

-(void)hiddenProgressWithMessage:(NSString *)aMess;

-(void)hiddenProgress:(BOOL)success message:(NSString *)aMess;

@end
