//
//  HLTabBar.h
//  AideBox
//
//  Created by 方海龙 on 15/9/28.
//  Copyright (c) 2015年 方海龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HLTabBar;

@protocol HLTabBarDelegate <NSObject>

@optional

- (void)tabBar:(HLTabBar *)tabBar didChangeSelectedIndex:(NSUInteger)selectedIndex;

@end

@interface HLTabBar : UIView

@property (nonatomic, strong) NSArray *items;

@property (nonatomic, assign) NSInteger selectedIndex;

@property (nonatomic, weak) id<HLTabBarDelegate> delegate;

@property (nonatomic, assign) BOOL showUnderLine;

@property (nonatomic, strong) UIColor *lineColor;

@end

@interface HLTabBarItem : UIControl

@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) UIImage *normalImage;

@property (nonatomic, strong) UIImage *highlightImage;

@property (nonatomic, strong) UIColor *normalTitleColor;

@property (nonatomic, strong) UIColor *highlightTitleColor;

@property (nonatomic, strong) UIColor *normalBGColor;

@property (nonatomic, strong) UIColor *highlightBGColor;

@property (nonatomic, assign) CGFloat titleFontSize;

@property (nonatomic, assign) CGFloat gap;

@end