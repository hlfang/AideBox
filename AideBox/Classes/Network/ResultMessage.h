//
//  ResultMessageVO.h
//  AideBox
//
//  Created by 方海龙 on 15/9/28.
//  Copyright (c) 2015年 方海龙. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ResultMessage : NSObject

@property (nonatomic, assign) NSInteger code;

@property (nonatomic, copy) NSString *message;

@property (nonatomic, strong) id data;

+(ResultMessage *)parseData:(id)data;

+(ResultMessage *)buildMessageVOWithMessage:(NSString *)aMess;

@end
