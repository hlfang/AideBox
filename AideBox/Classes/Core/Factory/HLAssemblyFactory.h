//
//  ABAssemblyFactory.h
//  AideBox
//
//  Created by 方海龙 on 15/9/27.
//  Copyright (c) 2015年 方海龙. All rights reserved.
//  组装工厂, 如果该工厂不能满足组装需求，可以继承该类或者定制该类的Category

#import <Foundation/Foundation.h>
#import "IDispatch.h"
#import "IView.h"
#import "IProgress.h"
#import "IInteractor.h"

@interface HLAssemblyFactory : NSObject

/**
 *  根据类名构造所对应的实例对象
 *
 *  @param clazzName 目标类类名
 *
 *  @return 目标类的实例对象
 */
+(instancetype)assemblyWithClassName:(NSString *)clazzName;

/**
 *  根据类名构造对应类实例对象
 *
 *  @param clazzName  目标类名称
 *  @param completion 完成回调方法
 */
+(void)assemblyWithClassName:(NSString *)clazzName completion:(void (^)(id object))completion;

/**
 *  组装基本调度器
 *
 *  @param view 视图层对象
 */
+(id<IDispatch>)assemblyBaseDispatch:(id<IView>)view;

/**
 *  组装基本ViewController
 *
 *  @param className 目标Controller类名
 *
 *  @return 目标controller
 */
+(id<IView>)assemblyBaseView:(NSString *)className;

/**
 *  为指定视图组装对应的调度器与交互器
 *
 *  @param aView          视图实例
 *  @param dispatchName   调度器名称
 *  @param interactorName 交互器名称
 */
+(id<IDispatch>)assemblySpecificForView:(id<IView>)aView dispatcher:(NSString *)dispatchName interactor:(NSString *)interactorName;

/**
 *  为指定的视图组装对应的调度器与交互器
 *
 *  @param viewName       视图类名称
 *  @param dispatchName   调度器类名称
 *  @param interactorName 交互器类名称
 *
 *  @return 目标视图
 */
+(id<IView>)assemblySpecificView:(NSString *)viewName dispatcher:(NSString *)dispatchName interactor:(NSString *)interactorName;

@end
