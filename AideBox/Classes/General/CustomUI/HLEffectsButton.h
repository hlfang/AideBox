//
//  HLEffectsButton.h
//  AideBox
//
//  Created by 方海龙 on 15/9/28.
//  Copyright (c) 2015年 方海龙. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IAcceptParam.h"

@interface HLEffectsButton : UIControl<UIGestureRecognizerDelegate, IAcceptParam>

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UIImage *normalImage;

@property (nonatomic, strong) UIImage *highlightImage;

@property (nonatomic, strong) UIColor *highlightColor;

@property (nonatomic, assign) BOOL highlightEnable;

-(void)initSubviews;

-(void)destory;

@end
