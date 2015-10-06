//
//  IHttpService.h
//  AideBox
//
//  Created by fanghailong on 15/6/18.
//  Copyright (c) 2015年 ptteng. All rights reserved.
//  http通信接口

#import <Foundation/Foundation.h>

typedef void(^SuccessCompletion)(id resultData);

typedef void(^FailureCompletion)(id resultData);

@protocol IHttpService <NSObject>

@optional

@property (nonatomic, strong) NSString *urlString;

@property (nonatomic, strong) id reqParam;

@property (nonatomic, assign) HTTRequestMethod reqMethod;

-(id)initWithUrlString:(NSString *)urlString params:(id)aParam requestMethod:(HTTRequestMethod)method;

@required

-(void)sendAsyncRequest:(SuccessCompletion)success failCompletion:(FailureCompletion)failure;

@end
