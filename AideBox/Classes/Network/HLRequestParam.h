//
//  HLRequestParam.h
//  AideBox
//
//  Created by 方海龙 on 15/9/28.
//  Copyright (c) 2015年 方海龙. All rights reserved.
//  构造http请求参数

#import <Foundation/Foundation.h>

@class ASIFormDataRequest;

@interface HLRequestParam : NSObject

+(NSString *)didBuildRequestQueryStringWithUrlString:(NSString *)urlString reqParam:(id)aParam;

+(void)didBuildRequestPostParamWith:(ASIFormDataRequest *)request reqParam:(id)aParam;

@end
