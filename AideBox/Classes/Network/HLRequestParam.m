//
//  HLRequestParam.m
//  AideBox
//
//  Created by 方海龙 on 15/9/28.
//  Copyright (c) 2015年 方海龙. All rights reserved.
//

#import "HLRequestParam.h"
#import "ASIFormDataRequest.h"

@implementation HLRequestParam

+(NSString *)encodeToPercentEscapeString:(NSString *)input{
    NSString *outputStr = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                              (CFStringRef)input,
                                                                              NULL,
                                                                              (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                              kCFStringEncodingUTF8));
    
    return outputStr;
}

+(NSString *)didBuildRequestQueryStringWithUrlString:(NSString *)urlString reqParam:(id)aParam{
    if(urlString.length == 0){
        return nil;
    }
    
    if(!aParam || [aParam allKeys].count == 0){
        return urlString;
    }
    NSArray *keys = [aParam allKeys];
    NSMutableString *queryString = [NSMutableString stringWithString:urlString];
    
    for(int i=0; i<keys.count; i++){
        if(i > 0){
            [queryString appendString:@"&"];
        }else{
            [queryString appendString:@"?"];
        }
        
        NSString *queryName = [keys objectAtIndex:i];
        NSString *queryValue = [aParam valueForKey:queryName];
        
        [queryString appendString:[NSString stringWithFormat:@"%@=%@", queryName, queryValue]];
    }
    
    NSString *finalUrlString = [NSString stringWithString:queryString];
    finalUrlString = [finalUrlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    return finalUrlString;
}

+(void)didBuildRequestPostParamWith:(ASIFormDataRequest *)request reqParam:(id)aParam{
    NSArray *keys = [aParam allKeys];
    for(NSString *key in keys){
        NSString *value = [aParam valueForKey:key];
        [request setPostValue:value forKey:key];
    }
}

@end
