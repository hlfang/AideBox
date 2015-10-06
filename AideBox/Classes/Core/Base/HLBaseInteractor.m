//
//  ABBaseInteractor.m
//  AideBox
//
//  Created by 方海龙 on 15/9/27.
//  Copyright (c) 2015年 方海龙. All rights reserved.
//

#import "HLBaseInteractor.h"
#import "IHttpService.h"
#import "HLResourceManager.h"
#import "IDataParser.h"
#import "ResultMessage.h"
#import "IDataManager.h"

@implementation HLBaseInteractor

-(id)fetchCacheDataWithUrlString:(NSString *)urlString dataParser:(id<IDataParser>)parser{
    if(urlString.length == 0 || !parser){
        return nil;
    }
    
    id jsonData = [self.dataManager fetchJsonDataWithUrlString:urlString];
    if(!jsonData){
        return nil;
    }
    
    BOOL success = [parser parsing:jsonData];
    if(success){
        return parser.successData;
    }
    
    return nil;
}

-(void)sendRequestWithServiceID:(NSString *)serviceID cacheEnable:(BOOL)cache param:(id)aParam reqMethod:(HTTRequestMethod)aMethod dataParser:(id<IDataParser>)parser completion:(RequestNewworkCompletionBlcok)completionBlock
{
    self.dataParser = parser;
    self.cacheEnable = cache;
    
    NSString *urlString = [HLResourceManager urlStringWithServID:serviceID];
    
    [self send:urlString param:aParam reqMethod:aMethod completion:completionBlock];
}

-(void)sendRequestWithUrlString:(NSString *)urlString cacheEnable:(BOOL)cache param:(id)aParam reqMethed:(HTTRequestMethod)aMethod dataParser:(id<IDataParser>)parser completion:(RequestNewworkCompletionBlcok)completionBlock
{
    self.dataParser = parser;
    self.cacheEnable = cache;
    
    [self send:urlString param:aParam reqMethod:aMethod completion:completionBlock];
}

-(void)send:(NSString *)urlString param:(id)aParam reqMethod:(HTTRequestMethod)aMethod completion:(RequestNewworkCompletionBlcok)completionBlock{
    
    self.reqCompleteBlock = completionBlock;
    self.httpService.urlString = urlString;
    self.httpService.reqParam = aParam;
    self.httpService.reqMethod = aMethod;
    
    __weak typeof(self) welf = self;
    
    [self.httpService sendAsyncRequest:^(id resultData) {
        [welf requestSuccessHandler:resultData];
    } failCompletion:^(id resultData) {
        [welf requestFailureHandler:resultData];
    }];
}

-(void)requestSuccessHandler:(id)resultData{

    if(!self.dataParser){
        NSException *notDataParserExpression = [[NSException alloc] initWithName:@"数据错误" reason:@"没有提供数据解析对象" userInfo:nil];
        @throw notDataParserExpression;
    }

    BOOL success = [self.dataParser parsing:resultData];
    if(success){
        if(self.cacheEnable){
            [self.dataManager storeJsonData:resultData urlString:self.httpService.urlString];
        }
        resultData = self.dataParser.successData;
    }else{
        resultData = self.dataParser.failureMessage;
    }
    
    if(self.reqCompleteBlock){
        self.reqCompleteBlock(success, resultData);
    }
    
    _dataParser = nil;
}

-(void)requestFailureHandler:(id)resultData{
    ResultMessage *mess = [ResultMessage parseData:resultData];
    if(self.reqCompleteBlock){
        self.reqCompleteBlock(NO, mess.message);
    }
}

-(void)dealloc{
    ObjLog(@"baseInteractor释放.......");
    _httpService = nil;
    _dataParser = nil;
    _reqCompleteBlock = NULL;
    _dataManager = nil;
}

#pragma mark -------------------以下是Setters And Getters部分--------------------

@synthesize httpService = _httpService, reqCompleteBlock = _reqCompleteBlock, dataParser = _dataParser, dataManager = _dataManager, cacheEnable = _cacheEnable;


@end
