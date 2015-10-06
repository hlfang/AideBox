//
//  HLDataManager.m
//  AideBox
//
//  Created by 方海龙 on 15/10/3.
//  Copyright (c) 2015年 方海龙. All rights reserved.
//

#import "HLDataManager.h"
#import "NSString+SBox.h"
#import "IDataStore.h"

@implementation HLDataManager

-(NSString *)encodeToPercentEscapeString:(NSString *)input{
    NSString *outputStr = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,                                                                                            (CFStringRef)input,NULL, (CFStringRef)@"!*'();:@&=+$,/?%#[]", kCFStringEncodingUTF8));
    
    return outputStr;
}

-(BOOL)storeJsonData:(id)jsonData urlString:(NSString *)urlString{
    if(!jsonData || urlString.length == 0){
        return NO;
    }
    
    urlString = [self encodeToPercentEscapeString:urlString];
    NSData *aData = [NSKeyedArchiver archivedDataWithRootObject:jsonData];
    NSString *documentPath = [NSString boxDocumentPath];
    NSString *storePath = [documentPath stringByAppendingPathComponent:urlString];
    
    BOOL success = [self.dataStore storeData:aData withPath:storePath];

    return success;
}

-(id)fetchJsonDataWithUrlString:(NSString *)urlString{
    if(urlString.length == 0){
        return nil;
    }
    urlString = [self encodeToPercentEscapeString:urlString];
    NSString *documentPath = [NSString boxDocumentPath];
    NSString *cachePath = [documentPath stringByAppendingPathComponent:urlString];
    NSData *cacheData = [self.dataStore fetchDataWithPath:cachePath];
    if(!cacheData){
        NSLog(@"没有缓存数据.....");
        return nil;
    }
    id jsonData = [NSKeyedUnarchiver unarchiveObjectWithData:cacheData];
    return jsonData;
}

@synthesize dataStore = _dataStore;

-(void)dealloc{
    ObjLog(@"dataManager释放.......");
    _dataStore = nil;
}

@end
