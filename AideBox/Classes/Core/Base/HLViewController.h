//
//  ABViewController.h
//  AideBox
//
//  Created by 方海龙 on 15/9/27.
//  Copyright (c) 2015年 方海龙. All rights reserved.
//  项目框架所用到的UIViewController基类
//  基类默认隐藏UINavigatioBar,使用自定义的导航栏替代
//  基类提供默认的键盘控制，在有键盘出现的时候，在键盘外点击，可使键盘消失

#import <UIKit/UIKit.h>
#import "IView.h"
#import "IProgress.h"
#import "IAcceptParam.h"

@interface HLViewController : UIViewController<IAcceptParam, IView, IProgress>

@property (nonatomic, readonly) UIView *contentView;

@property (nonatomic, readonly) CGRect contentRect;

@property (nonatomic, readonly) UIView *mNavgationBar;

@property (nonatomic, readonly) UIView *mBottomBar;

/**
 *  表明该controller是否为首次运行, 如果是则为YES
 */
@property (nonatomic, assign) BOOL runFirst;

/**
 *  是否隐藏状态栏
 */
@property (nonatomic, assign) BOOL hiddenStatusBar;

/**
 *  判断自身是否被push进视图栈里(如果自身是由UINavigationController管理的)
 */
@property (nonatomic, assign) BOOL isPushView;

/**
 *  背景图片
 */
@property (nonatomic, strong) UIImage *backgroundImage;

/**
 *  背景颜色
 */
@property (nonatomic, strong) UIColor *backgroundColor;

/**
 *  是否刷新布局的标志位
 */
@property (nonatomic, assign) BOOL invalid;

/**
 *  是否支持手势操作
 */
@property (nonatomic, assign) BOOL gestureable;

/**
 *  初始化controller配置(例如：是否隐藏导航栏，是否隐藏状态栏等属性)
 */
-(void)initConfigure;

/**
 *  初始化子组件
 */
-(void)initSubviews;

/**
 *  布局方法
 */
-(void)layoutSubElements;

/**
 *  清理资源
 */
-(void)destory;

/**
 *  隐藏键盘
 */
-(void)hiddenKeyboard;

/**
 *  用指定的图片添加导航栏左侧按钮
 *
 *  @param normalImg    非选中图片
 *  @param highlightImg 选中图片
 *  @param aSelector    执行方法
 */
-(void)addLeftButtonWithNormalImage:(UIImage *)normalImg highlightImage:(UIImage *)highlightImg selector:(SEL)aSelector;

-(void)addLeftButtonWithText:(NSString *)aText normalTextColor:(UIColor *)normalColor highlightColor:(UIColor *)highlightColor selector:(SEL)aSelector;

-(void)addRightButtonWithNormalImage:(UIImage *)normalImg highlightImage:(UIImage *)highlightImg selector:(SEL)aSelector;

-(void)addRightButtonWithText:(NSString *)aText normalTextColor:(UIColor *)normalColor highlightColor:(UIColor *)highlightColor selector:(SEL)aSelector;

-(void)addTopBackButton;

-(void)addBottomBackButton;

@end
