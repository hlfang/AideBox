//
//  ResultMessageVO.m
//  AideBox
//
//  Created by 方海龙 on 15/9/28.
//  Copyright (c) 2015年 方海龙. All rights reserved.
//

#import "ResultMessage.h"

@implementation ResultMessage

+(ResultMessage *)parseData:(id)data{
    if(!data){
        return nil;
    }
    
    ResultMessage *message = [[ResultMessage alloc] init];
    
    if([data isKindOfClass:[NSString class]]){
        message.message = data;
        return message;
    }
    
    
    NSNumber *codeNumber = [data valueForKey:@"code"];
    message.code = [codeNumber integerValue];
    message.message = [data valueForKey:@"message"];
    message.data = [data valueForKey:@"data"];
    return message;
}

+(ResultMessage *)buildMessageVOWithMessage:(NSString *)aMess{
    ResultMessage *message = [[ResultMessage alloc] init];
    message.code = -404;
    message.message = aMess;
    return message;
}

@end
