//
//  HPRecommend.h
//  AideBox
//
//  Created by 方海龙 on 15/10/4.
//  Copyright (c) 2015年 方海龙. All rights reserved.
//  首页推荐请求参数

#import <Foundation/Foundation.h>

@interface HPRecommend : NSObject

@property (nonatomic, strong) NSString *listname;

@property (nonatomic, strong) NSNumber *page;

@property (nonatomic, strong) NSNumber *count;

@end
