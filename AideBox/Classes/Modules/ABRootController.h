//
//  ABRootController.h
//  AideBox
//
//  Created by 方海龙 on 15/9/28.
//  Copyright (c) 2015年 方海龙. All rights reserved.
//

#import "HLViewController.h"
#import "IView.h"
#import "HLTabBar.h"

@interface ABRootController : UITabBarController<IView, HLTabBarDelegate>

/**
 *  初始化配置
 *
 *  @param configureCompleteBlock 配置完成后的回调方法
 */
-(void)initConfigureUsingBlock:(void (^)(void))configureCompleteBlock;

/**
 *  选择页面controller
 *
 *  @param index    页面索引
 *  @param animated 是否动画
 */
-(void)selectTabAtIndex:(NSInteger)index;

@end
