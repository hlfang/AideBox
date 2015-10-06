//
//  AdvertViewModel.h
//  AideBox
//
//  Created by 方海龙 on 15/10/2.
//  Copyright (c) 2015年 方海龙. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AdvertModel.h"

@interface AdvertViewModel : NSObject

@property (nonatomic, strong) AdvertModel *model;

@property (nonatomic, readonly) NSString *imagePath;

@end
