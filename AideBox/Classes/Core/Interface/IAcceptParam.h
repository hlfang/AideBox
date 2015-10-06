//
//  PPTAcceptParamDelegate.h
//  AideBox
//
//  Created by fanghailong on 15/9/27.
//  Copyright (c) 2015年 ptteng. All rights reserved.
//  参数接收接口

#import <Foundation/Foundation.h>

@protocol IAcceptParam <NSObject>

@optional

/**
 *  接收参数方法
 *
 *  @param aParam 参数
 */
-(void)acceptParam:(id)aParam;

/**
 *  接收参数属性
 */
@property (nonatomic, strong) id parameter;

@end
