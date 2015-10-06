//
//  ABBaseDispatch.m
//  AideBox
//
//  Created by 方海龙 on 15/9/27.
//  Copyright (c) 2015年 方海龙. All rights reserved.
//

#import "HLBaseDispatch.h"
#import "HLNavigateManager.h"

@implementation HLBaseDispatch

-(id)fetchCacheDataWithUrlString:(NSString *)urlString dataParser:(id<IDataParser>)parser{
    return [self.interactor fetchCacheDataWithUrlString:urlString dataParser:parser];
}

-(void)sendRequestWithServiceID:(NSString *)serviceID
                    cacheEnable:(BOOL)cache
                          param:(id)aParam
                      reqMethod:(HTTRequestMethod)aMethod
                     dataParser:(id<IDataParser>)parser
                        success:(void (^)(id))successBlock
                       failgure:(void (^)(NSString *))failgureBlock
{

    [self.interactor sendRequestWithServiceID:serviceID cacheEnable:cache param:aParam reqMethod:aMethod dataParser:parser completion:^(BOOL success, id resultData) {
        if(success && successBlock){
            successBlock(resultData);
        }else if(!success && failgureBlock){
            failgureBlock(resultData);
        }
    }];
}

-(void)sendRequestWithUrlString:(NSString *)urlString
                    cacheEnable:(BOOL)cache
                          param:(id)aParam
                      reqMethod:(HTTRequestMethod)aMethod
                     dataParser:(id<IDataParser>)parser
                        success:(void (^)(id))successBlock
                       failgure:(void (^)(NSString *))failgureBlock
{
    
    [self.interactor sendRequestWithUrlString:urlString cacheEnable:cache param:aParam reqMethed:aMethod dataParser:parser completion:^(BOOL success, id resultData) {

        if(success && successBlock){
            successBlock(resultData);
        }else if(!success && failgureBlock){
            failgureBlock(resultData);
        }
    }];
}

-(void)navigate:(UIViewController *)current target:(NSString *)clazzName param:(id)aParam animation:(BOOL)animation{
    [HLNavigateManager navigate:current target:clazzName param:aParam animated:animation];
}

-(void)dealloc{
    ObjLog(@"baseDispatch释放.......");
    _interactor = nil;
}

#pragma mark -------------------以下是Setters And Getters部分--------------------

@synthesize view = _view, progress = _progress, interactor = _interactor, idle = _idle;

@end
