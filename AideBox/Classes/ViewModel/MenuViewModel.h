//
//  MenuViewModel.h
//  AideBox
//
//  Created by 方海龙 on 15/10/1.
//  Copyright (c) 2015年 方海龙. All rights reserved.
//  APP菜单对象

#import <Foundation/Foundation.h>

@interface MenuViewModel : NSObject

/**
 *  菜单显示名称
 */
@property (nonatomic, strong) NSString *title;

/**
 *  菜单对应的Controller类名
 */
@property (nonatomic, strong) NSString *className;

/**
 *  菜单是否显示
 */
@property (nonatomic, assign) BOOL required;

/**
 *  未选中状态图片
 */
@property (nonatomic, strong) UIImage *normalImage;

/**
 *  选中状态图片
 */
@property (nonatomic, strong) UIImage *highlightImage;

@end
