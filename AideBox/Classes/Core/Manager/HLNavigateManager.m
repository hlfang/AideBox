//
//  ABNavigateManager.m
//  AideBox
//
//  Created by 方海龙 on 15/9/27.
//  Copyright (c) 2015年 方海龙. All rights reserved.
//  

#import "HLNavigateManager.h"
#import "HLAssemblyFactory.h"

@implementation HLNavigateManager

+(void)navigateAssemblyBaseView:(UIViewController *)current target:(NSString *)clazzName param:(id)aParam animated:(BOOL)animated{
    UIViewController *controller = (UIViewController *)[HLAssemblyFactory assemblyBaseView:clazzName];
    
    if(!controller || !current){
        return;
    }
    
    if([controller conformsToProtocol:@protocol(IAcceptParam)]){
        id<IAcceptParam> paramDelegate = (id<IAcceptParam>)controller;
        [paramDelegate acceptParam:aParam];
    }
    
    if(current.navigationController){
        [current.navigationController pushViewController:controller animated:animated];
    }else{
        [current presentViewController:controller animated:animated completion:NULL];
    }
}

+(void)navigate:(UIViewController *)current target:(NSString *)clazzName param:(id)aParam animated:(BOOL)animated{
    
    UIViewController *controller = (UIViewController *)[HLAssemblyFactory assemblyWithClassName:clazzName];
    if(!controller || !current){
        return;
    }
    
    if([controller conformsToProtocol:@protocol(IAcceptParam)]){
        id<IAcceptParam> paramDelegate = (id<IAcceptParam>)controller;
        [paramDelegate acceptParam:aParam];
    }
    
    if(current.navigationController){
        [current.navigationController pushViewController:controller animated:animated];
    }else{
        [current presentViewController:controller animated:animated completion:NULL];
    }
}

+(void)navigate:(UIViewController *)current targetController:(UIViewController<IAcceptParam> *)controller param:(id)aParam animated:(BOOL)animated{
    
    if(!controller || !current){
        return;
    }
    
    controller.parameter = aParam;
    
    if(current.navigationController){
        [current.navigationController pushViewController:controller animated:animated];
    }else{
        [current presentViewController:controller animated:animated completion:NULL];
    }
}

@end
