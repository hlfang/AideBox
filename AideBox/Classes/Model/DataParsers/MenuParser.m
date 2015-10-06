//
//  MenuParser.m
//  AideBox
//
//  Created by 方海龙 on 15/10/2.
//  Copyright (c) 2015年 方海龙. All rights reserved.
//

#import "MenuParser.h"
#import "MenuViewModel.h"

@implementation MenuParser

@synthesize successData = _successData, failureMessage = _failureMessage;

-(BOOL)parsing:(id)data{
    BOOL required = YES;
    NSArray *menuList = [HLResourceManager findResourceWithName:kAppMenuSourceKey];
    NSMutableArray *visibleMenuList = @[].mutableCopy;
    for(MenuViewModel *model in menuList){
        model.required = model.required || required;
        if(model.required){
            [visibleMenuList addObject:model];
        }
    }
    _successData = visibleMenuList;
    
    return YES;
}

@end
