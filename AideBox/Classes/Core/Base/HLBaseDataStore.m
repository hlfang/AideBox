//
//  HLBaseDataStore.m
//  AideBox
//
//  Created by 方海龙 on 15/10/3.
//  Copyright (c) 2015年 方海龙. All rights reserved.
//

#import "HLBaseDataStore.h"

#define cacheFileName @"cacheData.txt"

@implementation HLBaseDataStore

-(BOOL)storeData:(NSData *)aData withPath:(NSString *)aPath{
    if(!aData || aPath.length == 0){
        return NO;
    }
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isExist = [fileManager fileExistsAtPath:aPath];
    if(!isExist){
       BOOL pathSuccess = [fileManager createDirectoryAtPath:aPath withIntermediateDirectories:YES attributes:nil error:nil];
        if(!pathSuccess){
            return NO;
        }
    }
    
    NSError *error;
    aPath = [aPath stringByAppendingPathComponent:cacheFileName];
    [aData writeToFile:aPath options:NSDataWritingAtomic error:&error];
    
    if(error){
        return NO;
    }
    
    return YES;
}

-(NSData *)fetchDataWithPath:(NSString *)aPath{
    if(aPath.length == 0){
        return nil;
    }
    aPath = [aPath stringByAppendingPathComponent:cacheFileName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isExist = [fileManager fileExistsAtPath:aPath];
    if(!isExist){
        return nil;
    }
    
    NSData *cacheData = [fileManager contentsAtPath:aPath];
    
    return cacheData;
}

@end
