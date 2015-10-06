//
//  HLLoopImageScrollView.m
//  AideBox
//
//  Created by 方海龙 on 15/10/3.
//  Copyright (c) 2015年 方海龙. All rights reserved.
//

#import "HLLoopImageScrollView.h"
#import "HLImageView.h"

@interface HLLoopImageScrollView(){
    
}

@property (nonatomic, strong) HLImageView * leftImageView;

@property (nonatomic, strong) HLImageView * centerImageView;

@property (nonatomic, strong) HLImageView * rightImageView;

@end

@implementation HLLoopImageScrollView

#pragma mark -------------------以下是页面交互部分--------------------

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self scrollCompleteHandler];
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    [self scrollCompleteHandler];
}

-(void)setWillShowImageIndex:(NSInteger)aIndex{
    NSInteger centerIndex = self.centerImageView.index;
    CGFloat targetPosiX = 0.0f;
    if(aIndex < centerIndex){
        targetPosiX = 0.0f;
    }else if(aIndex > centerIndex){
        targetPosiX = self.width * 2.0f;
    }
    CGRect targetRect = CGRectMake(targetPosiX, 0.0f, self.width, self.height);
    [self scrollRectToVisible:targetRect animated:YES];
}

-(void)scrollCompleteHandler{
    if(self.imageList.count <= 1){
        return;
    }
    CGFloat stdWidth = self.width;
    NSInteger leftIndex = self.leftImageView.index;
    NSInteger centerIndex = self.centerImageView.index;
    NSInteger rightIndex = self.rightImageView.index;
    
    //首先根据当前位置判断活动方向，然后根据滑动方向确定滑动后中心图片的索引
    if(self.contentOffset.x == 0){//向右侧滑动
        centerIndex = leftIndex;
    }else if(self.contentOffset.x == stdWidth * 2.0f){//向左侧滑动
        centerIndex = rightIndex;
    }
    
    //根据中心图片的索引确定左右两侧的图片索引
    if(centerIndex == 0){
        leftIndex = self.imageList.count - 1;
        rightIndex = centerIndex + 1;
    }else if(centerIndex == (self.imageList.count - 1)){
        leftIndex = centerIndex - 1;
        rightIndex = 0;
    }else{
        leftIndex = centerIndex - 1;
        rightIndex = centerIndex + 1;
    }
    self.leftImageView.index = leftIndex;
    self.centerImageView.index = centerIndex;
    self.rightImageView.index = rightIndex;
    
    self.leftImageView.image = [self.imageList objectAtIndex:leftIndex];
    self.centerImageView.image = [self.imageList objectAtIndex:centerIndex];
    self.rightImageView.image = [self.imageList objectAtIndex:rightIndex];
    
    self.contentOffset = CGPointMake(self.width, 0.0f);
    
    if([self.loopDelegate respondsToSelector:@selector(loopImageScrollView:currentIndex:)]){
        [self.loopDelegate loopImageScrollView:self currentIndex:self.centerImageView.index];
    }
}

#pragma mark -------------------以下是页面初始化部分--------------------

-(void)clear{
    self.leftImageView.image = nil;
    self.centerImageView.image = nil;
    self.rightImageView.image = nil;
}

-(void)applyData{
    if(self.imageList.count == 0){
        return;
    }
    
    NSInteger leftIndex = -1, centerIndex = -1, rightIndex = -1;
    if(self.imageList.count == 1){//图片列表只有一张图片
        centerIndex = 0;
    }else{//图片列表大于一张图片
        leftIndex = self.imageList.count - 1;
        centerIndex = 0;
        rightIndex = centerIndex + 1;
    }
    
    CGFloat stdWidth = self.width;
    CGFloat stdHeight = self.height;
    if(leftIndex != -1){
        self.leftImageView.image = [self.imageList objectAtIndex:leftIndex];
        self.leftImageView.index = leftIndex;
        [self addSubview:self.leftImageView];
    }
    if(centerIndex != -1){
        self.centerImageView.image = [self.imageList objectAtIndex:centerIndex];
        self.centerImageView.index = centerIndex;
        [self addSubview:self.centerImageView];
    }
    if(rightIndex != -1){
        self.rightImageView.image = [self.imageList objectAtIndex:1];
        self.rightImageView.index = rightIndex;
        [self addSubview:self.rightImageView];
    }
    
    if(leftIndex != -1 && centerIndex != -1 && rightIndex != -1){//图片列表大于一张图片
        self.leftImageView.frame = CGRectMake(0.0f, 0.0f, stdWidth, stdHeight);
        self.centerImageView.frame = CGRectMake(stdWidth, 0.0f, stdWidth, stdHeight);
        self.rightImageView.frame = CGRectMake(stdWidth*2.0f, 0.0f, stdWidth, stdHeight);
        self.contentSize = CGSizeMake(stdWidth * 3.0f, stdHeight);
        self.contentOffset = CGPointMake(stdWidth, 0.0f);
    }else if(leftIndex == -1 && centerIndex == 0 && rightIndex == -1){//图片列表只有一张图片
        self.centerImageView.frame = CGRectMake(0.0f, 0.0f, stdWidth, stdHeight);
        self.contentSize = CGSizeMake(stdWidth, stdHeight);
        self.contentOffset = CGPointZero;
    }
}

-(instancetype)init{
    self = [super init];
    if (self) {
        self.pagingEnabled = YES;
        self.bounces = NO;
        self.userInteractionEnabled = YES;
        self.showsHorizontalScrollIndicator=NO;
        self.showsVerticalScrollIndicator= NO;
        self.delegate = self;
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
}

-(void)setImageList:(NSArray *)aList{
    _imageList = aList;
    
    [self clear];
    
    [self applyData];
    
    [self setNeedsLayout];
}

@synthesize leftImageView = _leftImageView;

- (HLImageView *)leftImageView
{
    if (!_leftImageView) {
        _leftImageView = [[HLImageView alloc] init];
    }
    return _leftImageView;
}

@synthesize centerImageView = _centerImageView;

- (HLImageView *)centerImageView
{
    if (!_centerImageView) {
        _centerImageView = [[HLImageView alloc] init];
    }
    return _centerImageView;
}

@synthesize rightImageView = _rightImageView;

- (HLImageView *)rightImageView
{
    if (!_rightImageView) {
        _rightImageView = [[HLImageView alloc] init];
    }
    return _rightImageView;
}

-(NSUInteger)currentIndex{
    return self.centerImageView.index;
}

-(void)dealloc{
    _leftImageView = nil;
    _centerImageView = nil;
    _rightImageView = nil;
    _imageList = nil;
}

@end
