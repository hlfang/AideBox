//
//  ABResourceManager.h
//  AideBox
//
//  Created by 方海龙 on 15/9/27.
//  Copyright (c) 2015年 方海龙. All rights reserved.
//  资源管理类，该类负责对资源配置文件(Resource.plist)管理

#import <Foundation/Foundation.h>

@interface HLResourceManager : NSObject

+(void)initMenuResourceWithPath:(NSString *)menuPath;

/**
 *  对资源初始化
 */
+(void)initResourceWithPath:(NSString *)resPath;

/**
 *  根据给定的资源名称返回对应的资源
 *
 *  @param resName 资源名称
 *
 *  @return 返回对应的资源，如图片
 */
+(id)findResourceWithName:(NSString *)resName;

/**
 *  如果资源节点是一个字典Dictionary,则需要传递资源节点名称和自节点名称
 *
 *  @param parentName 资源节点名称
 *  @param childName  子节点名称
 *
 *  @return 资源束
 */
+(id)findResourceWithParentName:(NSString *)parentName childName:(NSString *)childName;


/**
 *  根据配置文件路径初始化配置
 */
+(void)initConfigureWithHostPath:(NSString *)hPath suffixPath:(NSString *)spath;


/**
 *  根据参数的ID，返回对应的URL地址字符串
 */
+(NSString *)urlStringWithServID:(NSString *)servID;

/**
 *仅返回url前缀
 */
+(NSString *)getHostIPWithServID:(NSString *)servID;

/**
 *  根据参数的ID和账号ID返回对应的URL地址字符串
 *
 *  @param servID 服务ID
 *  @param userID 账号ID
 *
 *  @return url字符串
 */
+(NSString *)urlStringWithServID:(NSString *)servID userID:(NSString *)userID;


@end
