//
//  HMTableHeader.h
//  AideBox
//
//  Created by 方海龙 on 15/10/5.
//  Copyright (c) 2015年 方海龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HMTableHeader, HMHeaderDataItem;

@protocol HMHeaderDelegate <NSObject>

@optional

-(void)tableHeader:(HMTableHeader *)tableHeader didSelectedItem:(HMHeaderDataItem *)item;

@end

@interface HMTableHeader : UIView

@property (nonatomic, weak) id<HMHeaderDelegate> delegate;

@end

@interface HMHeaderDataItem : NSObject

@property (nonatomic, assign) ChannelType type;

@property (nonatomic, strong) NSString *title;

@end

@interface HMHeaderButtonItem : UIButton

@property (nonatomic, strong) HMHeaderDataItem *itemData;

@end
