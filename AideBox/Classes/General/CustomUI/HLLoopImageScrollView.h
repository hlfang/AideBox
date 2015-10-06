//
//  HLLoopImageScrollView.h
//  AideBox
//
//  Created by 方海龙 on 15/10/3.
//  Copyright (c) 2015年 方海龙. All rights reserved.
//  可重用UIImageView的滚动视图(支持图片循环显示)

#import <UIKit/UIKit.h>

@class HLLoopImageScrollView;

@protocol HLLoopImageDelegate <NSObject>

@optional

-(void)loopImageScrollView:(HLLoopImageScrollView *)loopScrollView currentIndex:(NSUInteger)currentIndex;

@end

@interface HLLoopImageScrollView : UIScrollView<UIScrollViewDelegate>

/**
 *  需要显示的图片列表
 */
@property (nonatomic, strong) NSArray *imageList;

@property (nonatomic, weak) id<HLLoopImageDelegate> loopDelegate;

/**
 *  当前显示图片的索引值
 */
@property (nonatomic, readonly) NSUInteger currentIndex;

/**
 *  设置将要显示的索引值
 *
 *  @param aIndex 将要显示图片的索引值
 */
-(void)setWillShowImageIndex:(NSInteger)aIndex;

@end
