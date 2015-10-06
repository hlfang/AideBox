//
//  HLImageButton.m
//  AideBox
//
//  Created by 方海龙 on 15/9/28.
//  Copyright (c) 2015年 方海龙. All rights reserved.
//

#import "HLImageButton.h"

@interface HLImageButton()

@property (nonatomic, strong) CALayer *normalImageLayer;

@property (nonatomic, strong) CALayer *highlightImageLayer;

@property (nonatomic, strong) UITapGestureRecognizer *tapGestrue;

@end

@implementation HLImageButton

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    self.selected = YES;
    return YES;
}

-(void)tapGestureHandler:(UITapGestureRecognizer *)gesture{
    self.selected = NO;
    [self sendActionsForControlEvents:UIControlEventTouchUpInside];
}

-(void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    
    if(selected){
        self.highlightImageLayer.hidden = NO;
        self.normalImageLayer.hidden = YES;
    }else{
        self.highlightImageLayer.hidden = YES;
        self.normalImageLayer.hidden = NO;
    }
    
    [self setNeedsLayout];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initSubviews];
        [self addGestureRecognizer:self.tapGestrue];
    }
    return self;
}

-(void)initSubviews{
    [self.layer addSublayer:self.highlightImageLayer];
    [self.layer addSublayer:self.normalImageLayer];
    self.highlightImageLayer.hidden = YES;
}

-(void)layoutSubviews{
    self.normalImageLayer.frame = self.bounds;
    self.highlightImageLayer.frame = self.bounds;
}


-(void)setNormalImage:(UIImage *)aImage{
    _normalImage = aImage;
    if(_normalImage){
        self.normalImageLayer.contents = (id)_normalImage.CGImage;
    }
}

-(void)setHighlightImage:(UIImage *)aImage{
    _highlightImage = aImage;
    
    if(_highlightImage){
        self.highlightImageLayer.contents = (id)_highlightImage.CGImage;
    }
}

-(CALayer *)normalImageLayer{
    if(!_normalImageLayer){
        _normalImageLayer = [CALayer layer];
    }
    
    return _normalImageLayer;
}

-(CALayer *)highlightImageLayer{
    if(!_highlightImageLayer){
        _highlightImageLayer = [CALayer layer];
    }
    
    return _highlightImageLayer;
}

-(UITapGestureRecognizer *)tapGestrue{
    if(!_tapGestrue){
        _tapGestrue = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureHandler:)];
        _tapGestrue.delegate = self;
    }
    
    return _tapGestrue;
}

-(void)dealloc{
    [_normalImageLayer removeFromSuperlayer];
    _normalImageLayer = nil;
    [_highlightImageLayer removeFromSuperlayer];
    _highlightImageLayer = nil;
    _normalImage = nil;
    _highlightImage = nil;
    if(_tapGestrue){
        [self removeGestureRecognizer:_tapGestrue];
        _tapGestrue = nil;
    }
    _normalImage = nil;
    _highlightImage = nil;
}

@end
