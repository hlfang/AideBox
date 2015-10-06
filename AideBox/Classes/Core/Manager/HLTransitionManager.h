//
//  HLTransitionManager.h
//  AideBox
//
//  Created by 方海龙 on 15/9/28.
//  Copyright (c) 2015年 方海龙. All rights reserved.
//  过场动画管理类

#import <Foundation/Foundation.h>

@interface HLTransitionManager : NSObject

+(CATransition *)modalTransition;

+(CATransition *)dismisTransition;

@end
