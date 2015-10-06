//
//  HLTabBar.m
//  AideBox
//
//  Created by 方海龙 on 15/9/28.
//  Copyright (c) 2015年 方海龙. All rights reserved.
//

#import "HLTabBar.h"

@interface HLTabBar()

@property (nonatomic, strong) HLTabBarItem *selectedItem;

@property (nonatomic, strong) CALayer *lineLayer;

@end

@implementation HLTabBar

-(void)tapGestureHandler:(UITapGestureRecognizer *)gesture{
    UIView *view = gesture.view;
    if([view isKindOfClass:[HLTabBarItem class]]){
        HLTabBarItem *item = (HLTabBarItem *)view;
        if([self.items containsObject:item]){
            NSUInteger aIndex = [self.items indexOfObject:item];
            self.selectedIndex = aIndex;
        }
    }
}

#pragma mark -------------------以下是页面初始化部分--------------------


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.showUnderLine = YES;
    }
    return self;
}


-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat offsetX = 0;
    CGFloat itemWidth = self.width / self.items.count;
    for(HLTabBarItem *barItem in self.items){
        barItem.height = self.height;
        barItem.width = itemWidth;
        barItem.x = offsetX;
        offsetX = barItem.x + barItem.width;
    }
    
    if([self.layer.sublayers containsObject:self.lineLayer]){
        CGFloat twidth = itemWidth;
        CGFloat theight = 2.0f;
        CGFloat tx = self.selectedIndex * itemWidth;
        CGFloat ty = self.height - theight;
        self.lineLayer.frame = CGRectMake(tx, ty, twidth, theight);
    }
}

-(void)setItems:(NSArray *)aItems{
    _items = aItems;
    
    for(HLTabBarItem *barItem in self.items){
        [self addSubview:barItem];
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureHandler:)];
        [barItem addGestureRecognizer:tapGesture];
    }
    [self setNeedsLayout];
}

-(void)setSelectedItem:(HLTabBarItem *)aItem{
    if(_selectedItem != aItem){
        _selectedItem.selected = NO;
        _selectedItem = aItem;
        _selectedItem.selected = YES;
        if([self.delegate respondsToSelector:@selector(tabBar:didChangeSelectedIndex:)]){
            [self.delegate tabBar:self didChangeSelectedIndex:self.selectedIndex];
        }
    }
}

-(void)setSelectedIndex:(NSInteger)aIndex{
    _selectedIndex = aIndex;
    if(_selectedIndex < 0){
        _selectedIndex = 0;
    }else if(_selectedIndex >= self.items.count){
        _selectedIndex = self.items.count - 1;
    }
    
    if(self.items.count > 0){
        HLTabBarItem *aItem = [self.items objectAtIndex:_selectedIndex];
        self.selectedItem = aItem;
        [self setNeedsLayout];
    }
}

-(void)setShowUnderLine:(BOOL)isShow{
    _showUnderLine = isShow;
    if(_showUnderLine){
        [self.layer addSublayer:self.lineLayer];
    }
}

- (CALayer *)lineLayer
{
    if (!_lineLayer) {
        _lineLayer = [CALayer layer];
    }
    return _lineLayer;
}

-(void)setLineColor:(UIColor *)aColor{
    _lineColor = aColor;
    self.lineLayer.backgroundColor = _lineColor.CGColor;
}

-(void)dealloc{
    [_items makeObjectsPerformSelector:@selector(removeFromSuperview)];
    _items = nil;
    _selectedItem = nil;
    _lineLayer = nil;
    _lineColor = nil;
}

@end

@interface HLTabBarItem()

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) CALayer *imageLayer;

@end

@implementation HLTabBarItem

- (instancetype)init
{
    self = [super init];
    if (self) {
        _normalTitleColor = [[UIColor blackColor] colorWithAlphaComponent:0.8f];
        _highlightTitleColor = [[UIColor redColor] colorWithAlphaComponent:0.8f];
        self.titleFontSize = 13.0f;
        self.gap = 5.0f;
        self.titleLabel.textColor = self.normalTitleColor;
    }
    return self;
}

-(void)layoutSubviews{
    [self.titleLabel sizeToFit];

    CGFloat totalItemHeight = self.titleLabel.height + self.imageLayer.bounds.size.height;
    CGFloat offsetY = (self.height - totalItemHeight) * 0.5f;
    
    if([self.layer.sublayers containsObject:self.imageLayer]){
        self.imageLayer.frame = CGRectMake((self.width - self.imageLayer.bounds.size.width) * 0.5f, offsetY, self.imageLayer.bounds.size.width, self.imageLayer.bounds.size.height);
        
        offsetY = self.imageLayer.frame.origin.y + self.imageLayer.frame.size.height + self.gap;
    }
    
    if([self.subviews containsObject:self.titleLabel]){
        self.titleLabel.x = (self.width - self.titleLabel.width) * 0.5f;
        self.titleLabel.y = offsetY;
    }
}

-(void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    if(selected){
        self.titleLabel.textColor = self.highlightTitleColor;
        if(self.highlightImage){
            self.imageLayer.contents = (id)self.highlightImage.CGImage;
        }
    }else{
        self.titleLabel.textColor = self.normalTitleColor;
        if(self.normalImage){
            self.imageLayer.contents = (id)self.normalImage.CGImage;
        }
    }
}

-(void)setTitle:(NSString *)aTitle{
    _title = aTitle;
    if(_title.length > 0){
        self.titleLabel.text = _title;
        [self addSubview:self.titleLabel];
    }else{
        [_titleLabel removeFromSuperview];
    }
    
    [self setNeedsLayout];
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
    }
    return _titleLabel;
}

-(void)setTitleFontSize:(CGFloat)aSize{
    _titleFontSize = aSize;
    self.titleLabel.font = [UIFont systemFontOfSize:_titleFontSize];
}

- (CALayer *)imageLayer
{
    if (!_imageLayer) {
        _imageLayer = [CALayer layer];
    }
    return _imageLayer;
}

-(void)setNormalImage:(UIImage *)aImage{
    _normalImage = aImage;
    if(_normalImage){
        self.imageLayer.contents = (id)_normalImage.CGImage;
        CGFloat stdHeight = 25.0f;
        CGFloat twidth = stdHeight * _normalImage.size.width / _normalImage.size.height;
        self.imageLayer.frame = CGRectMake(0.0f, 0.0f, twidth, stdHeight);
        [self.layer addSublayer:self.imageLayer];
    }
}

-(void)dealloc{
    _title = nil;
    _titleLabel = nil;
    _normalImage = nil;
    _highlightImage = nil;
    _normalTitleColor = nil;
    _highlightTitleColor = nil;
    _normalBGColor = nil;
    _highlightBGColor = nil;
    _imageLayer = nil;
}

@end
