//
//  HLRequestService.m
//  AideBox
//
//  Created by 方海龙 on 15/9/28.
//  Copyright (c) 2015年 方海龙. All rights reserved.
//

#import "HLRequestService.h"
#import "HLRequestParam.h"
#import "CJSONDeserializer.h"
#import "CJSONSerializer.h"
#import "ASIFormDataRequest.h"

@interface HLRequestService()

@property (nonatomic, strong) ASIFormDataRequest *asiRequest;

@property (nonatomic, copy) SuccessCompletion successCompletionBlock;

@property (nonatomic, copy) FailureCompletion failureCompletionBlock;

@end

@implementation HLRequestService

@synthesize urlString = _urlString, reqMethod = _reqMethod, reqParam = _reqParam;


-(id)initWithUrlString:(NSString *)urlString params:(id)aParam requestMethod:(HTTRequestMethod)method{
    self = [super init];
    if(self){
        self.reqMethod = method;
        self.urlString = urlString;
        self.reqParam = aParam;
    }
    return self;
}

-(void)sendAsyncRequest:(SuccessCompletion)success failCompletion:(FailureCompletion)failure{
    self.successCompletionBlock = success;
    self.failureCompletionBlock = failure;
    
    NSURL *url = nil;
    
    NSString *method = @"GET";
    if(self.reqMethod == HTTRequestGET){
        NSString *finalUrlString = [HLRequestParam didBuildRequestQueryStringWithUrlString:self.urlString reqParam:self.reqParam];
        method = @"GET";
        url = [[NSURL alloc] initWithString:finalUrlString];
        self.asiRequest = [[ASIFormDataRequest alloc] initWithURL:url];
    }else if(self.reqMethod == HTTRequestPOST){
        url = [[NSURL alloc] initWithString:self.urlString];
        self.asiRequest = [[ASIFormDataRequest alloc] initWithURL:url];
        [HLRequestParam didBuildRequestPostParamWith:self.asiRequest reqParam:self.reqParam];
        method = @"POST";
    }
    
    NSLog(@"%@", self.asiRequest.url.absoluteString);
    self.asiRequest.requestMethod = method;
    self.asiRequest.delegate = self;
    [self.asiRequest startAsynchronous];
}

/**
 *  异步调用返回
 */
-(void)requestFinished:(ASIHTTPRequest *)request{
    int code = request.responseStatusCode;
    if(code == 404 || code == 500){
        NSDictionary *failureObj = @{@"code":@"404", @"message":@"服务器连接失败, 请重试"};
        [self didProcessFailureWithMessage:failureObj];
        return;
    }
    
    NSData *responseData = [request responseData];
    NSMutableDictionary* jsonoObj = [[CJSONDeserializer deserializer] deserialize:responseData error:nil];
    if (!jsonoObj) {
        jsonoObj = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:nil];
    }
    
    if(self.successCompletionBlock){
        self.successCompletionBlock(jsonoObj);
    }
    
    [self clear];
}

- (void)requestFailed:(ASIHTTPRequest *)request{
    
    NSDictionary *failureObj = @{@"code":@"404", @"message":@"网络连接失败"};
    [self didProcessFailureWithMessage:failureObj];
    
    [self clear];
}

-(void)didProcessFailureWithMessage:(id)failureObj{
    
    if(self.failureCompletionBlock){
        self.failureCompletionBlock(failureObj);
    }
}

-(void)clear{
    _successCompletionBlock = NULL;
    _failureCompletionBlock = NULL;
    _asiRequest = nil;
}

-(void)dealloc{
    ObjLog(@"httpService释放.......");
    [self clear];
}

@end
