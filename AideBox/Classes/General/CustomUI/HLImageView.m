//
//  HLImageView.m
//  AideBox
//
//  Created by 方海龙 on 15/10/3.
//  Copyright (c) 2015年 方海龙. All rights reserved.
//

#import "HLImageView.h"

@interface HLImageView()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation HLImageView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.layer.masksToBounds = YES;
        self.imageView.userInteractionEnabled = YES;
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    if(self.imageView.image){
        CGFloat tw = self.bounds.size.width;
        CGFloat th = tw * self.imageView.image.size.height / self.imageView.image.size.width;
        if(th < self.bounds.size.height){
            th = self.bounds.size.height;
            tw = th * self.imageView.image.size.width / self.imageView.image.size.height;
        }
        CGFloat tx = (self.bounds.size.width - tw) * 0.5f;
        CGFloat ty = (self.bounds.size.height - th) * 0.5f;
        self.imageView.frame = CGRectMake(tx, ty, tw, th);
    }
}

-(void)setImage:(UIImage *)aImage{
    _image = aImage;
    if(_image){
        self.imageView.image = aImage;
        [self addSubview:self.imageView];
    }else{
        self.imageView.image = nil;
        [self.imageView removeFromSuperview];
    }
    
    [self setNeedsLayout];
}

- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
    }
    return _imageView;
}

-(void)dealloc{
    [_imageView removeFromSuperview];
    _imageView = nil;
    _image = nil;
}

@end
