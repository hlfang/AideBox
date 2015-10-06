//
//  HMRecommItemView.h
//  AideBox
//
//  Created by 方海龙 on 15/10/4.
//  Copyright (c) 2015年 方海龙. All rights reserved.
//  首页推荐列表条目组件

#import <UIKit/UIKit.h>

@class HMRecommItemView;

@protocol HMRecommItemDelegate <NSObject>

@optional

-(void)itemView:(HMRecommItemView *)itemView appid:(NSString *)appid;

@end

@interface HMRecommItemView : UIView<ITableCellItemView>

@property (nonatomic, weak) id<HMRecommItemDelegate> delegate;

@end
