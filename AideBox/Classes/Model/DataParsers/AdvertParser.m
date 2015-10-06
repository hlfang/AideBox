//
//  AdvertParser.m
//  AideBox
//
//  Created by 方海龙 on 15/10/2.
//  Copyright (c) 2015年 方海龙. All rights reserved.
//

#import "AdvertParser.h"
#import "AdvertModel.h"
#import "AdvertViewModel.h"

@implementation AdvertParser

@synthesize successData = _successData, failureMessage = _failureMessage;

-(BOOL)parsing:(id)data{
    id aData = [data valueForKey:kHttpResultDataField];
    if(![aData isKindOfClass:[NSArray class]]){
        return NO;
    }

    NSArray *aList = (NSArray *)aData;
    NSMutableArray *advertList = [NSMutableArray arrayWithCapacity:aList.count];
    for(id advertData in aList){
        AdvertModel *model = [[AdvertModel alloc] init];
        NSString *imagePath = [advertData valueForKey:@"banner"];
        model.imagePath = imagePath;

        AdvertViewModel *viewModel = [[AdvertViewModel alloc] init];
        viewModel.model = model;
        [advertList addObject:viewModel];
    }
    
    _successData = advertList;
    
    return YES;
}

-(void)dealloc{
    ObjLog(@"dataParser释放.......");
    _successData = nil;
    _failureMessage = nil;
}

@end
