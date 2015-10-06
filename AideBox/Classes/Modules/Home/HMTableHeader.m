//
//  HMTableHeader.m
//  AideBox
//
//  Created by 方海龙 on 15/10/5.
//  Copyright (c) 2015年 方海龙. All rights reserved.
//

#import "HMTableHeader.h"

@interface HMTableHeader()

@property (nonatomic, strong) NSMutableArray *buttonItems;

@end

@implementation HMTableHeader

#pragma mark -------------------以下是页面交互部分--------------------

-(void)buttonItemTouchHandler:(id)sender{
    if(![sender isKindOfClass:[HMHeaderButtonItem class]]){
        return;
    }
    if([self.delegate respondsToSelector:@selector(tableHeader:didSelectedItem:)]){
        HMHeaderButtonItem *buttonItem = (HMHeaderButtonItem *)sender;
        [self.delegate tableHeader:self didSelectedItem:buttonItem.itemData];
    }
}


#pragma mark -------------------以下是页面初始化部分--------------------

-(instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor = appBackgroundColor;
        [self initSubviews];
    }
    return self;
}

-(void)dealloc{
    [_buttonItems makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [_buttonItems removeAllObjects];
    _buttonItems = nil;
}

-(void)initSubviews{
    [self didBuildItemWithTitle:kChannelRanking type:ChannelRanking];
    [self didBuildItemWithTitle:kChannelMust type:ChannelMust];
    [self didBuildItemWithTitle:kChannelHtml5 type:ChannelHTML5];
    [self didBuildItemWithTitle:kChannelTimeFree type:ChannelTimeFree];
}

-(void)didBuildItemWithTitle:(NSString *)title type:(ChannelType)type{
    HMHeaderDataItem *aItemData = [[HMHeaderDataItem alloc] init];
    aItemData.title = title;
    aItemData.type = type;
    
    HMHeaderButtonItem *buttonItem = [[HMHeaderButtonItem alloc] init];
    buttonItem.titleLabel.font = [UIFont systemFontOfSize:13.0f];
    buttonItem.itemData = aItemData;
    [buttonItem setTitle:title forState:UIControlStateNormal];
    [buttonItem setTitle:title forState:UIControlStateHighlighted];
    [buttonItem setTitleColor:color_font_white forState:UIControlStateNormal];
    [buttonItem setTitleColor:color_font_red forState:UIControlStateHighlighted];
    [buttonItem setTitleColor:color_font_red forState:UIControlStateSelected];
    [buttonItem addTarget:self action:@selector(buttonItemTouchHandler:) forControlEvents:UIControlEventTouchUpInside];
    [self.buttonItems addObject:buttonItem];
    [self addSubview:buttonItem];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat itemWidth = self.width;
    CGFloat offsetX = 0.0f;
    if(_buttonItems.count > 0){
        itemWidth = self.width / _buttonItems.count;
    }
    for(HMHeaderButtonItem *buttonItem in _buttonItems){
        buttonItem.width = itemWidth;
        buttonItem.height = self.height;
        buttonItem.x = offsetX;
        offsetX = buttonItem.x + buttonItem.width;
    }
}

- (NSMutableArray *)buttonItems
{
    if (!_buttonItems) {
        _buttonItems = @[].mutableCopy;
    }
    return _buttonItems;
}


@end

@implementation HMHeaderDataItem

-(void)dealloc{
    _title = nil;
}

@end

@implementation HMHeaderButtonItem

-(void)dealloc{
    _itemData = nil;
}

@end
