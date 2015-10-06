//
//  RecommModel.h
//  AideBox
//
//  Created by 方海龙 on 15/10/4.
//  Copyright (c) 2015年 方海龙. All rights reserved.
//  首页推荐列表数据对象

#import <Foundation/Foundation.h>

@interface RecommModel : NSObject

@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) NSString *icon;

@property (nonatomic, strong) NSString *size;

@property (nonatomic, strong) NSString *url;

@property (nonatomic, strong) NSString *downCount;

@property (nonatomic, strong) NSString *recommDesc;

@property (nonatomic, strong) NSString *category;

@property (nonatomic, strong) NSString *appid;

@end
