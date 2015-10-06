//
//  HLImageView.h
//  AideBox
//
//  Created by 方海龙 on 15/10/3.
//  Copyright (c) 2015年 方海龙. All rights reserved.
//  UIImageView的包装，对图片进行等比缩放，超出部分进行剪裁

#import <UIKit/UIKit.h>

@interface HLImageView : UIView

/**
 *  显示的图片
 */
@property (nonatomic, strong) UIImage *image;

/**
 *  如果图片是在UIScrollView中显示，则添加位置索引
 */
@property (nonatomic, assign) NSUInteger index;

@end
