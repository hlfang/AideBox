//
//  RecommendParser.m
//  AideBox
//
//  Created by 方海龙 on 15/10/4.
//  Copyright (c) 2015年 方海龙. All rights reserved.
//

#import "RecommendParser.h"
#import "RecommModel.h"
#import "RecommViewModel.h"

@implementation RecommendParser

-(BOOL)parsing:(id)data{
    id aData = [data valueForKey:kHttpResultDataField];
    if(![aData isKindOfClass:[NSArray class]]){
        return NO;
    }
    
    NSArray *aList = (NSArray *)aData;
    NSMutableArray *recommList = [NSMutableArray arrayWithCapacity:aList.count];
    for(id recommObj in aList){
        RecommModel *model = [[RecommModel alloc] init];
        model.title = [recommObj valueForKey:@"title"];
        model.size = [recommObj valueForKey:@"size"];
        model.url = [recommObj valueForKey:@"url"];
        model.icon = [recommObj valueForKey:@"icon"];
        model.recommDesc = [recommObj valueForKey:@"editor_advertisement"];
        model.downCount = [recommObj valueForKey:@"current_version_ratings_count"];
        model.category = [recommObj valueForKey:@"category"];
        model.appid = [recommObj valueForKey:@"appid"];
        
        RecommViewModel *vm = [[RecommViewModel alloc] init];
        vm.model = model;
        
        [recommList addObject:vm];
    }
    
    _successData = recommList;
    
    return YES;
}

@synthesize successData = _successData, failureMessage = _failureMessage;

-(void)dealloc{
    ObjLog(@"dataParser释放.......");
    _successData = nil;
    _failureMessage = nil;
}

@end
