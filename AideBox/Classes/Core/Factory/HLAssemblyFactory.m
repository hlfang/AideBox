//
//  ABAssemblyFactory.m
//  AideBox
//
//  Created by 方海龙 on 15/9/27.
//  Copyright (c) 2015年 方海龙. All rights reserved.
//

#import "HLAssemblyFactory.h"
#import "HLBaseDispatch.h"
#import "HLBaseInteractor.h"
#import "HLRequestService.h"
#import "HLDataManager.h"
#import "HLBaseDataStore.h"

@implementation HLAssemblyFactory

+(instancetype)assemblyWithClassName:(NSString *)clazzName{
    Class clazz = NSClassFromString(clazzName);
    
    if(!clazz){
        NSException *notFoundClassExpression = [[NSException alloc] initWithName:@"类型错误" reason:@"无效的类名" userInfo:nil];
        @throw notFoundClassExpression;
        return nil;
    }
    
    id targetObject = [[clazz alloc] init];
    
    return targetObject;
}

+(void)assemblyWithClassName:(NSString *)clazzName completion:(void (^)(id))completion{
    Class clazz = NSClassFromString(clazzName);
    
    if(!clazz && completion){
        completion(nil);
    }
    
    id targetObject = [[clazz alloc] init];
    
    if(completion){
        completion(targetObject);
    }
}

+(id<IDispatch>)assemblyBaseDispatch:(id<IView>)view{
    HLBaseInteractor *aInteractor = [[HLBaseInteractor alloc] init];
    HLRequestService *httpService = [[HLRequestService alloc] init];
    HLDataManager *dataManager = [[HLDataManager alloc] init];
    HLBaseDataStore *dataStore = [[HLBaseDataStore alloc] init];
    aInteractor.httpService = httpService;
    dataManager.dataStore = dataStore;
    aInteractor.dataManager = dataManager;
    HLBaseDispatch *aDispatch = [[HLBaseDispatch alloc] init];
    aDispatch.idle = YES;
    aDispatch.interactor = aInteractor;
    aDispatch.view = view;
    if([view conformsToProtocol:@protocol(IProgress)]){
        aDispatch.progress = (id<IProgress>)view;
    }
    
    return aDispatch;
}

+(id<IView>)assemblyBaseView:(NSString *)className{
    id object = [self assemblyWithClassName:className];
    if(![object conformsToProtocol:@protocol(IView)]){
        return nil;
    }
    
    id<IView> view = (id<IView>)object;
    id<IDispatch> aDispatch = [self assemblyBaseDispatch:view];
    
    [view.dispatchArr addObject:aDispatch];
    return view;
}

+(id<IDispatch>)assemblySpecificForView:(id<IView>)aView dispatcher:(NSString *)dispatchName interactor:(NSString *)interactorName{
    if(!aView){
        return nil;
    }
    
    id interactorObject = [self assemblyWithClassName:interactorName];
    id<IInteractor> aInteractor;
    if([interactorObject conformsToProtocol:@protocol(IInteractor)]){
        aInteractor = (id<IInteractor>)interactorObject;
        HLRequestService *httpService = [[HLRequestService alloc] init];
        HLDataManager *dataManager = [[HLDataManager alloc] init];
        HLBaseDataStore *dataStore = [[HLBaseDataStore alloc] init];
        dataManager.dataStore = dataStore;
        aInteractor.dataManager = dataManager;
        aInteractor.httpService = httpService;
    }
    id dispatcherObject = [self assemblyWithClassName:dispatchName];
    id<IDispatch> aDispatch;
    if([dispatcherObject conformsToProtocol:@protocol(IDispatch)]){
        aDispatch = (id<IDispatch>)dispatcherObject;
        aDispatch.idle = YES;
        aDispatch.interactor = aInteractor;
        aDispatch.view = aView;
        if([aView conformsToProtocol:@protocol(IProgress)]){
            aDispatch.progress = (id<IProgress>)aView;
        }
        if(aDispatch){
            [aView.dispatchArr addObject:aDispatch];
        }
    }
    
    return aDispatch;
}

+(id<IView>)assemblySpecificView:(NSString *)viewName dispatcher:(NSString *)dispatchName interactor:(NSString *)interactorName{
    id viewObject = [self assemblyWithClassName:viewName];
    if(![viewObject conformsToProtocol:@protocol(IView)]){
        return nil;
    }
    id<IView> aView = (id<IView>)viewObject;
    
    [self assemblySpecificForView:aView dispatcher:dispatchName interactor:interactorName];
    
    return aView;
}

@end
