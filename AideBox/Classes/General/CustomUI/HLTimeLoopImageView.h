//
//  HLImageLoopView.h
//  AideBox
//
//  Created by 方海龙 on 15/10/2.
//  Copyright (c) 2015年 方海龙. All rights reserved.
//  图片定时轮播组件

#import <UIKit/UIKit.h>
#import "HLLoopImageScrollView.h"

@interface HLTimeLoopImageView : UIView<HLLoopImageDelegate>

/**
 *  轮播间隔
 */
@property (nonatomic, assign) NSUInteger loopInterval;

/**
 *  图片数据对象列表
 */
@property (nonatomic, strong) NSArray *imageModelList;

@end

@interface HLImageModel : NSObject

@property (nonatomic, strong) UIImage *image;

@end

