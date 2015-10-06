//
//  ABNavigateManager.h
//  AideBox
//
//  Created by 方海龙 on 15/9/27.
//  Copyright (c) 2015年 方海龙. All rights reserved.
//  导航管理类，如果该类不能满足导航需求，可继承或者定制该类的Category

#import <Foundation/Foundation.h>
#import "IAcceptParam.h"

@interface HLNavigateManager : NSObject

/**
 *  组装一个基本的视图，并导航到该视图
 *
 *  @param current   当前视图controller
 *  @param clazzName 目标controller类名
 *  @param aParam    需要传递的参数
 *  @param animated  是否动画
 */
+(void)navigateAssemblyBaseView:(UIViewController *)current target:(NSString *)clazzName param:(id)aParam animated:(BOOL)animated;

/**
 *  导航到指定Controller
 *
 *  @param current   当前controller
 *  @param clazzName 目标controller类名
 *  @param aParam    需要传递的参数
 *  @param animated  是否动画
 */
+(void)navigate:(UIViewController *)current target:(NSString *)clazzName param:(id)aParam animated:(BOOL)animated;


/**
 *  导航到指定的controller
 *
 *  @param current    当前controller
 *  @param controller 目标controller
 *  @param aParam     需要传递的参数
 *  @param animated   是否动画
 */
+(void)navigate:(UIViewController *)current targetController:(UIViewController<IAcceptParam> *)controller param:(id)aParam animated:(BOOL)animated;

@end
