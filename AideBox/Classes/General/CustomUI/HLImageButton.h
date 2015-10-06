//
//  HLImageButton.h
//  AideBox
//
//  Created by 方海龙 on 15/9/28.
//  Copyright (c) 2015年 方海龙. All rights reserved.
//  只显示图片的按钮

#import <UIKit/UIKit.h>

@interface HLImageButton : UIControl<UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIImage *normalImage;

@property (nonatomic, strong) UIImage *highlightImage;

@end
