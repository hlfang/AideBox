//
//  RecommViewModel.h
//  AideBox
//
//  Created by 方海龙 on 15/10/4.
//  Copyright (c) 2015年 方海龙. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RecommModel.h"

@interface RecommViewModel : NSObject

@property (nonatomic, strong) RecommModel *model;

@property (nonatomic, readonly) NSString *title;

@property (nonatomic, readonly) NSString *icon;

@property (nonatomic, readonly) NSString *size;

@property (nonatomic, readonly) NSString *url;

@property (nonatomic, readonly) NSString *downCount;

@property (nonatomic, readonly) NSString *recommDesc;

@property (nonatomic, readonly) NSString *category;

@property (nonatomic, readonly) NSString *appid;

@end
