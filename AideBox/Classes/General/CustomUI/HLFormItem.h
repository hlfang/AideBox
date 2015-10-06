//
//  HLFormItem.h
//  AideBox
//
//  Created by 方海龙 on 15/9/28.
//  Copyright (c) 2015年 方海龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HLFormItem : UIControl

@property (nonatomic, assign) BOOL flagImageVisible;

@property (nonatomic, assign) BOOL detailTitleVisible;

@property (nonatomic, assign) BOOL accessImageVisible;

@property (nonatomic, strong) UIImage *flagImage;

@property (nonatomic, strong) NSString *title;

@property (nonatomic, assign) CGFloat titleFontSize;

@property (nonatomic, strong) NSString *detailTitle;

@property (nonatomic, strong) UIImage *accessImage;

@property (nonatomic, assign) CGFloat margin;

@end
