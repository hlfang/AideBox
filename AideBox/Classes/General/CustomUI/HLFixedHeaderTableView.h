//
//  HLFixedHeaderTableView.h
//  AideBox
//
//  Created by 方海龙 on 15/10/6.
//  Copyright (c) 2015年 方海龙. All rights reserved.
//  该TableView的HeaderView有两部分组成: 顶部视图topView,与底部视图bottomView,
//  TableView向上滑动的时候顶部视图消失，底部视图保持固定位置

#import <UIKit/UIKit.h>

@class HLFixedHeaderView;

@interface HLFixedHeaderTableView : HLTableView

/**
 *  两部分视图构成的HeaderView
 */
@property (nonatomic, strong) HLFixedHeaderView *fixedHeaderView;

@end

@interface HLFixedHeaderView : UIView

-(instancetype)initWithFrame:(CGRect)frame topView:(UIView *)topView bottomView:(UIView *)bottomView topHeight:(CGFloat)topHeight;

/**
 *  顶部视图
 */
@property (nonatomic, readonly) UIView *topView;

/**
 *  底部视图
 */
@property (nonatomic, readonly) UIView *bottomView;

@end