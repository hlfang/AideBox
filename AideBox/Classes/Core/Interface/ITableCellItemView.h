//
//  ITableCellItemView.h
//  AideBox
//
//  Created by 方海龙 on 15-6-21.
//  Copyright (c) 2015年 ptteng. All rights reserved.
//  列表CellItemView接口

#import <Foundation/Foundation.h>

@protocol ITableCellItemView <NSObject>

@optional
/**
 *  传递给列表cell的数据
 */
@property (nonatomic, strong) id itemData;

/**
 *  如果列表需要图片，则需要实现该方法
 */
@property (nonatomic, weak) UIImage *flagImage;


@end
