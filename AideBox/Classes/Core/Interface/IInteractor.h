//
//  IInteractor.h
//  AideBox
//
//  Created by fanghailong on 15/6/18.
//  Copyright (c) 2015年 ptteng. All rights reserved.
//  交互层基本接口

#import <Foundation/Foundation.h>

@protocol IHttpService, IDataParser, IDataManager;

/**
 *  请求网络数据完成后回调方法
 *
 *  @param success    请求是否成功
 *  @param resultData 请求返回数据
 */
typedef void (^RequestNewworkCompletionBlcok)(BOOL success, id resultData);


@protocol IInteractor <NSObject>

@optional

/**
 *  请求网络数据完成后回调block
 */
@property (nonatomic, copy) RequestNewworkCompletionBlcok reqCompleteBlock;

/**
 *  是否缓存数据
 */
@property (nonatomic, assign) BOOL cacheEnable;

/**
 *  数据解析对象
 */
@property (nonatomic, strong) id<IDataParser> dataParser;

/**
 *  持有网络层对象引用
 */
@property (nonatomic, strong) id<IHttpService> httpService;

/**
 *  数据管理对象引用(负责数据缓存等的管理)
 */
@property (nonatomic, strong) id<IDataManager> dataManager;

/**
 *  获取缓存的Json数据
 *
 *  @param urlString 请求的url字符串
 *
 *  @return 缓存的json数据
 */
-(id)fetchCacheDataWithUrlString:(NSString *)urlString dataParser:(id<IDataParser>)parser;

/**
 *  根据给定配置文件中的serviceID请求网络数据
 *
 *  @param serviceID       配置文件中定义的serviceID
 *  @param cacheEnable     是否缓存到本地
 *  @param aParam          参数
 *  @param aMethod         请求方法(GET,POST等)
 *  @param parser          数据解析对象(负责返回数据的解析)
 *  @param completionBlock 完成后的回调方法
 */
-(void)sendRequestWithServiceID:(NSString *)serviceID
                    cacheEnable:(BOOL)cache
                          param:(id)aParam
                      reqMethod:(HTTRequestMethod)aMethod
                     dataParser:(id<IDataParser>)parser
                     completion:(RequestNewworkCompletionBlcok)completionBlock;

/**
 *  根据给定的url字符串请求网络数据
 *
 *  @param urlString       url字符串
 *  @param cacheEnable     是否缓存到本地
 *  @param aParam          参数
 *  @param aMethod         请求方法(GET,POST等)
 *  @param parser          数据解析器对象(负责返回数据的解析)
 *  @param completionBlock 完成后回调
 */
-(void)sendRequestWithUrlString:(NSString *)urlString
                    cacheEnable:(BOOL)cache
                          param:(id)aParam
                      reqMethed:(HTTRequestMethod)aMethod
                     dataParser:(id<IDataParser>)parser
                     completion:(RequestNewworkCompletionBlcok)completionBlock;

/**
 *  成功请求处理方法
 *
 *  @param resultData 请求成功后返回的数据
 */
-(void)requestSuccessHandler:(id)resultData;

/**
 *  失败请求后处理方法
 *
 *  @param resultData 请求失败后的信息
 */
-(void)requestFailureHandler:(id)resultData;

@end
