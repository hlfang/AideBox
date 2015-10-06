//
//  HLFooterRefreshView.h
//  AideBox
//
//  Created by 方海龙 on 15/10/6.
//  Copyright (c) 2015年 方海龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HLFooterRefreshView : UIView

@property (nonatomic, strong) UIColor *lineColor;

@property (nonatomic, assign) CGFloat lineWidth;

- (void)startAnimation;

- (void)stopAnimation;

- (BOOL)isAnimating;

@end

@interface HLFooterProgress : UIView

@property (nonatomic, strong) UIColor *lineColor;

@property (nonatomic, assign) CGFloat lineWidth;

- (void)startAnimation;

- (void)stopAnimation;

- (BOOL)isAnimating;

@end