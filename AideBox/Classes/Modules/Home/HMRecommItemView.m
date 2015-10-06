//
//  HMRecommItemView.m
//  AideBox
//
//  Created by 方海龙 on 15/10/4.
//  Copyright (c) 2015年 方海龙. All rights reserved.
//

#import "HMRecommItemView.h"
#import "RecommViewModel.h"

@interface HMRecommItemView()

@property (nonatomic, strong) UIImageView *flagImageView;

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) UILabel *categoryLabel;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *downCountLabel;

@property (nonatomic, strong) UILabel *descLabel;

@property (nonatomic, strong) UIButton *downButton;

@end

@implementation HMRecommItemView

#pragma mark -------------------以下是页面交互部分--------------------

-(void)downButtonTouchHandler:(id)sender{
    if(![_itemData isKindOfClass:[RecommViewModel class]]){
        return;
    }
    if([self.delegate respondsToSelector:@selector(itemView:appid:)]){
        RecommViewModel *vm = (RecommViewModel *)_itemData;
        [self.delegate itemView:self appid:vm.appid];
    }
}

#pragma mark -------------------以下是页面初始化部分--------------------

-(void)clear{
    
}

-(void)applyData{
    if(![_itemData isKindOfClass:[RecommViewModel class]]){
        return;
    }
    
    RecommViewModel *vm = (RecommViewModel *)_itemData;
    self.titleLabel.text = vm.title;
    self.categoryLabel.text = vm.category;
    self.downCountLabel.text = vm.downCount;
    self.descLabel.text = vm.recommDesc;
}

-(instancetype)init{
    self = [super init];
    if (self) {
        [self initSubviews];
    }
    return self;
}

-(void)initSubviews{
    [self addSubview:self.flagImageView];
    [self addSubview:self.lineView];
    [self addSubview:self.categoryLabel];
    [self addSubview:self.titleLabel];
    [self addSubview:self.downCountLabel];
    [self addSubview:self.descLabel];
    [self addSubview:self.downButton];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.lineView.width = self.width;
    self.lineView.height = 0.5f;
    self.lineView.y = self.height - self.lineView.height;

    CGFloat offsetX = 0.0f;
    CGFloat offsetY = 0.0f;
    
    [self.downButton sizeToFit];
    self.downButton.height = 20.0f;
    self.downButton.width = 40.0f;
    self.downButton.x = self.width - kAppGap - self.downButton.width;
    self.downButton.y = (self.height - self.downButton.height) * 0.5f;
    
    self.flagImageView.width = self.flagImageView.height = self.height - kAppGap * 2.0f;
    self.flagImageView.x = kAppGap;
    self.flagImageView.y = (self.height - self.flagImageView.height) * 0.5f;
    
    offsetX = self.flagImageView.x + self.flagImageView.width + kAppGap;
    
    CGFloat contentWidth = self.width - self.flagImageView.width - self.downButton.width - kAppGap * 3.0f;
    
    [self.titleLabel sizeToFit];
    self.titleLabel.width = contentWidth;

    [self.categoryLabel sizeToFit];
    [self.downCountLabel sizeToFit];
    
    [self.descLabel sizeToFit];
    self.descLabel.width = self.width - self.flagImageView.width - kAppGap * 3.0f;
    
    CGFloat gap = 2.0f;
    
    CGFloat totalHeight = _titleLabel.height + _categoryLabel.height + _downCountLabel.height + _descLabel.height + gap * 3.0f;
    offsetY = (self.height - totalHeight) * 0.5f;
    
    _categoryLabel.x = _titleLabel.x = _downCountLabel.x = _descLabel.x = offsetX;
    
    _categoryLabel.y = offsetY;
    offsetY = _categoryLabel.y + _categoryLabel.height + gap;
    _titleLabel.y = offsetY;
    offsetY = _titleLabel.y + _titleLabel.height +gap;
    _downCountLabel.y = offsetY;
    offsetY = _downCountLabel.y + _downCountLabel.height + gap;
    _descLabel.y = offsetY;
}

@synthesize itemData = _itemData, flagImage = _flagImage;

-(void)setItemData:(id)aData{
    _itemData = aData;
    [self clear];
    [self applyData];
    [self setNeedsLayout];
}

-(void)setFlagImage:(UIImage *)aImage{
    _flagImage = aImage;
    if(_flagImage){
        self.flagImageView.image = _flagImage;
    }else{
        self.flagImageView.image = img_place_quare;
    }
    [self setNeedsLayout];
}

- (UIImageView *)flagImageView
{
    if (!_flagImageView) {
        _flagImageView = [[UIImageView alloc] initWithImage:img_place_quare];
        _flagImageView.layer.cornerRadius = 5.0f;
        _flagImageView.layer.masksToBounds = YES;
    }
    return _flagImageView;
}

- (UIView *)lineView
{
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2f];
    }
    return _lineView;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [UILabel labelWithText:nil fontSize:13.0f textColor:color_font_black wordWrap:NO];
        _descLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _titleLabel;
}

- (UILabel *)categoryLabel
{
    if (!_categoryLabel) {
        _categoryLabel = [UILabel labelWithText:nil fontSize:12.0f textColor:color_font_gray wordWrap:NO];
    }
    return _categoryLabel;
}

- (UILabel *)downCountLabel
{
    if (!_downCountLabel) {
        _downCountLabel = [UILabel labelWithText:nil fontSize:12.0f textColor:color_font_black wordWrap:NO];
    }
    return _downCountLabel;
}

- (UILabel *)descLabel
{
    if (!_descLabel) {
        _descLabel = [UILabel labelWithText:nil fontSize:12.0f textColor:color_font_black wordWrap:NO];
        _descLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _descLabel;
}

- (UIButton *)downButton
{
    if (!_downButton) {
        _downButton = [[UIButton alloc] init];
        _downButton.titleLabel.font = [UIFont systemFontOfSize:13.0f];
        [_downButton setTitle:@"获取" forState:UIControlStateNormal];
        [_downButton setTitleColor:color_font_black forState:UIControlStateNormal];
        [_downButton addTarget:self action:@selector(downButtonTouchHandler:) forControlEvents:UIControlEventTouchUpInside];
        _downButton.layer.borderColor = [UIColor blueColor].CGColor;
        _downButton.layer.cornerRadius = 5.0f;
        _downButton.layer.borderWidth = 0.5f;
        _downButton.layer.masksToBounds = YES;
        
    }
    return _downButton;
}


-(void)dealloc{
    _itemData = nil;
    _flagImageView = nil;
    _flagImage = nil;
    _lineView = nil;
    _titleLabel = nil;
    _downButton = nil;
}

@end
