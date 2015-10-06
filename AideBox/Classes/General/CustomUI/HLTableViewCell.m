//
//  HLTableViewCell.m
//  AideBox
//
//  Created by 方海龙 on 15/9/28.
//  Copyright (c) 2015年 方海龙. All rights reserved.
//

#import "HLTableViewCell.h"

@implementation HLTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        if ([self respondsToSelector:@selector(setSeparatorInset:)]) {
            [self setSeparatorInset:UIEdgeInsetsZero];
        }
        if ([self respondsToSelector:@selector(setLayoutMargins:)]) {
            [self setLayoutMargins:UIEdgeInsetsZero];
        }
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(void)setItemView:(UIView<ITableCellItemView> *)aView{
    if(_itemView != aView){
        [_itemView removeFromSuperview];
        _itemView = aView;
        if(_itemView){
            self.contentView.layer.masksToBounds = YES;
            self.layer.masksToBounds = YES;
            [self.contentView addSubview:_itemView];
            [self setNeedsLayout];
        }
    }
}
-(void)layoutSubviews{
    self.contentView.frame = self.bounds;
    _itemView.frame = self.contentView.bounds;
}

@end
