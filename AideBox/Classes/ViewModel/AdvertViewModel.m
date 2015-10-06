//
//  AdvertViewModel.m
//  AideBox
//
//  Created by 方海龙 on 15/10/2.
//  Copyright (c) 2015年 方海龙. All rights reserved.
//

#import "AdvertViewModel.h"

@implementation AdvertViewModel

- (NSString *)imagePath
{
    NSString *aPath = [NSString stringWithFormat:@"%@", self.model.imagePath];
    return aPath;
}

-(void)dealloc{
    _model = nil;
}

@end
