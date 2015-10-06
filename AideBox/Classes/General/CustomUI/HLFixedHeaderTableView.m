//
//  HLFixedHeaderTableView.m
//  AideBox
//
//  Created by 方海龙 on 15/10/6.
//  Copyright (c) 2015年 方海龙. All rights reserved.
//

#import "HLFixedHeaderTableView.h"

@implementation HLFixedHeaderTableView


#pragma mark -------------------以下是页面初始化部分--------------------

-(instancetype)init{
    self = [super init];
    if (self) {
        [self initSubviews];
        [self addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    }
    return self;
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if([keyPath isEqualToString:@"contentOffset"] && object == self){
        CGFloat offsetY = self.contentOffset.y;
        CGFloat fixedHeight = _fixedHeaderView.topView.height;
        UIView *topView = _fixedHeaderView.topView;
        UIView *bottomView = _fixedHeaderView.bottomView;
        if(offsetY >= fixedHeight && bottomView.superview == _fixedHeaderView){
            [bottomView removeFromSuperview];
            [self.superview insertSubview:bottomView aboveSubview:self];
            bottomView.frame = CGRectMake(self.x, self.y, bottomView.width, bottomView.height);
        }else if(offsetY < fixedHeight && bottomView.superview == self.superview){
            [_fixedHeaderView addSubview:bottomView];
            bottomView.frame = CGRectMake(topView.x, (topView.y + topView.height), bottomView.width, bottomView.height);
        }
    }
}

-(void)initSubviews{
}

-(void)layoutSubviews{
    [super layoutSubviews];
}

-(void)setFixedHeaderView:(HLFixedHeaderView *)aView{
    if(!aView){
        return;
    }
    _fixedHeaderView = aView;
    [self setTableHeaderView:aView];
}

-(void)dealloc{
    [self removeObserver:self forKeyPath:@"contentOffset" context:nil];
    _fixedHeaderView = nil;
}

@end

@interface HLFixedHeaderView()

@property (nonatomic, strong) UIView *topView;

@property (nonatomic, strong) UIView *bottomView;

@property (nonatomic, assign) CGFloat topHeight;

@end

@implementation HLFixedHeaderView

-(instancetype)initWithFrame:(CGRect)frame topView:(UIView *)topView bottomView:(UIView *)bottomView topHeight:(CGFloat)topHeight{
    self = [super initWithFrame:frame];
    if(self){
        self.topView = topView;
        self.bottomView = bottomView;
        self.topHeight = topHeight;
        
        [self addSubview:self.topView];
        [self addSubview:self.bottomView];
        
        [self initSubviewsLayout];
    }
    return self;
}

-(void)initSubviewsLayout{
    self.topView.width = self.width;
    self.topView.height = self.topHeight;
    self.bottomView.width = self.width;
    self.bottomView.height = self.height - self.topView.height;
    self.bottomView.y = self.topView.y + self.topView.height;
}

-(void)dealloc{
    _topView = nil;
    _bottomView = nil;
}

@end