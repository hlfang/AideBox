//
//  HPRank.m
//  AideBox
//
//  Created by 方海龙 on 15/10/4.
//  Copyright (c) 2015年 方海龙. All rights reserved.
//

#import "HPRank.h"

@implementation HPRank

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.listname = @"merge_df_lf";
        self.page = @(1);
        self.count = @(25);
    }
    return self;
}

@end
