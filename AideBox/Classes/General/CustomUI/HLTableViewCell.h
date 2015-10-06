//
//  HLTableViewCell.h
//  AideBox
//
//  Created by 方海龙 on 15/9/28.
//  Copyright (c) 2015年 方海龙. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ITableCellItemView.h"

@interface HLTableViewCell : UITableViewCell

/**
 *  列表展示数据的VIEW
 */
@property (nonatomic, strong) UIView<ITableCellItemView> *itemView;

@end
