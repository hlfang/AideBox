//
//  HLImageScrollview.h
//  AideBox
//
//  Created by 方海龙 on 15/10/2.
//  Copyright (c) 2015年 方海龙. All rights reserved.
//  可重用UIImageView的滚动视图(不支持图片循环显示)

#import <UIKit/UIKit.h>

@interface HLCycleImageScrollview : UIScrollView<UIScrollViewDelegate>

/**
 *  在ScrollView中展示的图片列表
 */
@property (nonatomic, strong) NSArray *imageList;

@end