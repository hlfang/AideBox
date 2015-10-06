//
//  HLEffectsButton.m
//  AideBox
//
//  Created by 方海龙 on 15/9/28.
//  Copyright (c) 2015年 方海龙. All rights reserved.
//

#import "HLEffectsButton.h"

@interface HLEffectsButton()

@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;

@property (nonatomic, strong) UIPanGestureRecognizer *panGesture;

@property (nonatomic, strong) UIView *maskView;

@end

@implementation HLEffectsButton

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if([touch.view isKindOfClass:[UIButton class]]){
        self.selected = NO;
    }else{
        self.selected = YES;
    }
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]] || [otherGestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]] ) {
        self.selected = NO;
    }
    return YES;
}

-(void)tapGestureHandler:(id)sender{
    self.selected = NO;
    [self sendActionsForControlEvents:UIControlEventTouchUpInside];
}

-(void)setSelected:(BOOL)selected{
    if(selected){
        [self showHighlight];
    }else{
        [self showNormal];
    }
    
    [self setNeedsLayout];
}

-(void)showHighlight{
    if(!self.highlightEnable){
        return;
    }
    if(self.highlightImage){
        self.imageView.image = self.highlightImage;
        [self addSubview:self.imageView];
        [self.maskView removeFromSuperview];
    }else{
        [self addSubview:self.maskView];
    }
}

-(void)showNormal{
    [self.maskView removeFromSuperview];
    if(self.normalImage){
        self.imageView.image = self.normalImage;
        [self addSubview:self.imageView];
    }else{
        [self.maskView removeFromSuperview];
    }
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initSubviews];
        self.highlightEnable = YES;
    }
    return self;
}

-(void)initSubviews{
    [self addGestureRecognizer:self.tapGesture];
    [self addGestureRecognizer:self.panGesture];
    self.layer.cornerRadius = 5.0f;
    self.layer.masksToBounds = YES;
}

-(void)layoutSubviews{
    if([self.subviews containsObject:self.imageView]){
        self.imageView.size = [self scaleInWidth:self.imageView.image scaleSize:self.size];
        self.imageView.x = (self.width - self.imageView.width) * 0.5f;
        self.imageView.y = (self.height - self.imageView.height) * 0.5f;
        
        [self sendSubviewToBack:self.imageView];
    }
    
    if([self.subviews containsObject:self.maskView]){
        self.maskView.frame = self.bounds;
    }
}

-(CGSize)scaleInWidth:(UIImage *)image scaleSize:(CGSize)scaleSize{
    if(!image){
        return CGSizeZero;
    }
    CGFloat targetWidth = scaleSize.width;
    CGFloat targetHeight = targetWidth * image.size.height / image.size.width;
    
    if(targetHeight < scaleSize.height){
        targetHeight = scaleSize.height;
        targetWidth = targetHeight * image.size.width / image.size.height;
    }
    
    return CGSizeMake(targetWidth, targetHeight);
}

#pragma mark -------------------以下为Getters And Setters部分--------------------

-(void)setHighlightColor:(UIColor *)aColor{
    _highlightColor = aColor;
    
    if(_highlightColor){
        self.maskView.backgroundColor = _highlightColor;
    }
}

-(void)setNormalImage:(UIImage *)aImage{
    _normalImage = aImage;
    self.imageView.image = aImage;
    if(self.imageView.image){
        [self addSubview:self.imageView];
    }
    
    [self setNeedsLayout];
}

-(UIImageView *)imageView{
    if(!_imageView){
        _imageView = [[UIImageView alloc] init];
    }
    
    return _imageView;
}

-(UITapGestureRecognizer *)tapGesture{
    if(!_tapGesture){
        _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureHandler:)];
        _tapGesture.delegate = self;
    }
    
    return _tapGesture;
}

-(UIPanGestureRecognizer *)panGesture{
    if(!_panGesture){
        _panGesture = [[UIPanGestureRecognizer alloc] init];
    }
    
    return _panGesture;
}

-(UIView *)maskView{
    if(!_maskView){
        _maskView = [[UIView alloc] init];
        _maskView.backgroundColor = [UIColor colorWithRed:239.0f/255.0f green:239.0f/255.0f blue:244.0f/255.0f alpha:0.4f];
    }
    return _maskView;
}

@synthesize parameter = _parameter;

-(void)destory{
    if(_tapGesture){
        [self removeGestureRecognizer:_tapGesture];
        _tapGesture = nil;
    }
    if(_panGesture){
        [self removeGestureRecognizer:_panGesture];
        _panGesture = nil;
    }
    [_imageView removeFromSuperview];
    _imageView = nil;
    [_maskView removeFromSuperview];
    _maskView = nil;
    _normalImage = nil;
    _highlightImage = nil;
    _highlightColor = nil;
}

-(void)dealloc{
    [self destory];
}

@end
