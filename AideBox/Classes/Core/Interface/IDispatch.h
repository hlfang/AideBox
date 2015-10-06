//
//  IDispatch.h
//  AideBox
//
//  Created by fanghailong on 15/9/27.
//  Copyright (c) 2015年 ptteng. All rights reserved.
//  调度层基本接口

#import <Foundation/Foundation.h>

@protocol IView, IProgress, IInteractor, IDataParser;

@protocol IDispatch <NSObject>

@optional
/**
 *  持有显示层对象引用
 */
@property (nonatomic, weak) id<IView> view;

/**
 *  持有进度处理对象引用
 */
@property (nonatomic, weak) id<IProgress> progress;


@property (nonatomic, strong) id<IInteractor> interactor;

/**
 *  调度器对象是否空闲
 */
@property (nonatomic, assign, getter=isIdle) BOOL idle;

/**
 *  根据给定的serviceID发送网络请求
 *
 *  @param serviceID     配置文件中定义的serviceID
 *  @param cacheEnable   是否缓存到本地
 *  @param aParam        请求参数
 *  @param aMethod       请求方法(GET,POST等)
 *  @param parser        数据解析对象(负责返回数据的解析)
 *  @param successBlock  成功后的回调
 *  @param failgureBlock 失败回调
 */
-(void)sendRequestWithServiceID:(NSString *)serviceID
                    cacheEnable:(BOOL)cache
                          param:(id)aParam
                      reqMethod:(HTTRequestMethod)aMethod
                     dataParser:(id<IDataParser>)parser
                        success:(void (^)(id resultData))successBlock
                       failgure:(void (^)(NSString *aMess))failgureBlock;

/**
 *  根据给定的url字符串请求网络数据
 *
 *  @param urlString     url字符串
 *  @param cacheEnable   是否缓存到本地
 *  @param aParam        请求参数
 *  @param aMethod       请求方法(GET,POST等)
 *  @param parser        数据解析对象(负责返回数据的解析)
 *  @param successBlock  成功后的回调
 *  @param failgureBlock 失败回调
 */
-(void)sendRequestWithUrlString:(NSString *)urlString
                    cacheEnable:(BOOL)cache
                          param:(id)aParam
                      reqMethod:(HTTRequestMethod)aMethod
                     dataParser:(id<IDataParser>)parser
                        success:(void (^)(id resultData))successBlock
                       failgure:(void (^)(NSString *aMess))failgureBlock;

/**
 *  获取缓存的Json数据
 *
 *  @param urlString 请求的url字符串
 *
 *  @return 缓存的json数据
 */
-(id)fetchCacheDataWithUrlString:(NSString *)urlString dataParser:(id<IDataParser>)parser;

/**
 *  导航方法
 *
 *  @param clazzName 目标controller类名
 *  @param aParam    需要传递的参数
 */
-(void)navigate:(UIViewController *)current target:(NSString *)clazzName param:(id)aParam animation:(BOOL)animation;

@end
