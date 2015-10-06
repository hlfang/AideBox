//
//  HLFormItem.m
//  AideBox
//
//  Created by 方海龙 on 15/9/28.
//  Copyright (c) 2015年 方海龙. All rights reserved.
//

#import "HLFormItem.h"

@interface HLFormItem()

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *detailLabel;

@property (nonatomic, strong) UIImageView *accessImageView;

@end

@implementation HLFormItem

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initSubviews];
        self.margin = kAppGap;
    }
    return self;
}

-(void)initSubviews{
    [self addSubview:self.titleLabel];
    [self addSubview:self.detailLabel];
    [self addSubview:self.accessImageView];
}

-(void)layoutSubviews{
    CGFloat offestX = kAppGap;
    if([self.subviews containsObject:self.imageView]){
        self.imageView.height = self.imageView.width = self.height - self.margin;
        self.imageView.x = offestX * 3.0f;
        self.imageView.y = (self.height - self.imageView.height) * 0.5f;
        offestX = self.imageView.x + self.imageView.width + kAppGap;
    }
    
    [self.titleLabel sizeToFit];
    self.titleLabel.x = offestX;
    self.titleLabel.y = (self.height - self.titleLabel.height) * 0.5f;
    
    if([self.subviews containsObject:self.accessImageView]){
        self.accessImageView.size = self.accessImageView.image.size;
        self.accessImageView.x = self.width - kAppGap - self.accessImageView.width;
        self.accessImageView.y = (self.height - self.accessImageView.height) * 0.5f;
        offestX = self.accessImageView.x - kAppGap;
    }
    
    if([self.subviews containsObject:self.detailLabel]){
        [self.detailLabel sizeToFit];
        self.detailLabel.x = offestX - self.detailLabel.width - kAppGap * 4.0f;
        self.detailLabel.y = (self.height - self.detailLabel.height) * 0.5f;
    }
}


#pragma mark -------------------以下为Getters And Setters部分--------------------

-(void)setTitleFontSize:(CGFloat)aSize{
    _titleFontSize = aSize;
    self.titleLabel.font = [UIFont systemFontOfSize:_titleFontSize];
}

-(void)setFlagImage:(UIImage *)aImage{
    _flagImage = aImage;
    if(_flagImage){
        self.imageView.image = _flagImage;
        [self addSubview:self.imageView];
        
        [self setNeedsLayout];
    }
}

-(void)setAccessImage:(UIImage *)aImage{
    _accessImage = aImage;
    if(_accessImage){
        self.accessImageView.image = _accessImage;
        [self addSubview:self.accessImageView];
        
        [self setNeedsLayout];
    }
}

-(void)setTitle:(NSString *)aTitle{
    _title = aTitle;
    self.titleLabel.text = _title;
    
    [self setNeedsLayout];
}

-(void)setDetailTitle:(NSString *)aTitle{
    _detailTitle = aTitle;
    self.detailLabel.text = _detailTitle;
    
    [self setNeedsLayout];
}

-(void)setFlagImageVisible:(BOOL)aVisible{
    _flagImageVisible = aVisible;
    
    if(!_flagImageVisible){
        [self.imageView removeFromSuperview];
    }
}

-(void)setDetailTitleVisible:(BOOL)aVisible{
    _detailTitleVisible = aVisible;
    if(!_detailTitleVisible){
        [self.detailLabel removeFromSuperview];
    }
}

-(void)setAccessImageVisible:(BOOL)aVisible{
    _accessImageVisible = aVisible;
    if(!_accessImageVisible){
        [self.accessImageView removeFromSuperview];
    }
}

-(UIImageView *)imageView{
    if(!_imageView){
        _imageView = [[UIImageView alloc] init];
    }
    
    return _imageView;
}

-(UIImageView *)accessImageView{
    if(!_accessImageView){
        _accessImageView = [[UIImageView alloc] init];
    }
    
    return _accessImageView;
}

-(UILabel *)titleLabel{
    if(!_titleLabel){
        _titleLabel = [UILabel labelWithText:nil fontSize:15.0f textColor:color_font_black wordWrap:NO];
    }
    
    return _titleLabel;
}

-(UILabel *)detailLabel{
    if(!_detailLabel){
        _detailLabel = [UILabel labelWithText:nil fontSize:15.0f textColor:color_font_black wordWrap:NO];
    }
    
    return _detailLabel;
}

-(void)dealloc{
    _imageView.image = nil;
    _imageView = nil;
    _titleLabel = nil;
    _detailLabel = nil;
    _accessImage = nil;
    _accessImageView.image = nil;
    _accessImageView = nil;
    _title = nil;
    _detailTitle = nil;
}

@end
