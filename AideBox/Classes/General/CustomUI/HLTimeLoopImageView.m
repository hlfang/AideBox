//
//  HLImageLoopView.m
//  AideBox
//
//  Created by 方海龙 on 15/10/2.
//  Copyright (c) 2015年 方海龙. All rights reserved.
//

#import "HLTimeLoopImageView.h"

@interface HLTimeLoopImageView(){
    NSTimer *_loopTimer;
}

@property (nonatomic, strong) NSMutableArray *imageList;

@property (nonatomic, strong) HLLoopImageScrollView *contentView;

@property (nonatomic, strong) UIPageControl * pageControl;

@end

@implementation HLTimeLoopImageView

#pragma mark -------------------以下是页面交互部分--------------------

-(void)loopImageScrollView:(HLLoopImageScrollView *)loopScrollView currentIndex:(NSUInteger)currentIndex{
    self.pageControl.currentPage = currentIndex;
}


#pragma mark -------------------以下是页面初始化部分--------------------

-(void)clear{
    [self.imageList removeAllObjects];
}

-(void)applyData{
    [self stopLoop];
    
    for(HLImageModel *model in _imageModelList){
        [self.imageList addObject:model.image];
    }
    self.contentView.imageList = _imageList;
    self.pageControl.numberOfPages = _imageModelList.count;
    
    if(_imageList.count > 1){
        [self startLoop];
    }
}

-(void)startLoop{
    _loopTimer = [NSTimer scheduledTimerWithTimeInterval:self.loopInterval target:self selector:@selector(loopTimerHandler) userInfo:nil repeats:YES];
}

-(void)loopTimerHandler{
    if(!self.contentView.dragging){
        NSUInteger futureIndex = self.contentView.currentIndex + 1;
        [self.contentView setWillShowImageIndex:futureIndex];
    }
}

-(void)stopLoop{
    [_loopTimer invalidate];
    _loopTimer = nil;
}

-(void)removeFromSuperview{
    [super removeFromSuperview];
    [self stopLoop];
}

-(instancetype)init{
    self = [super init];
    if (self) {
        [self initSubviews];
        [self.contentView.panGestureRecognizer addTarget:self action:@selector(panGestureHandler:)];
    }
    return self;
}

-(void)panGestureHandler:(UIPanGestureRecognizer *)gesture{
    if(gesture.state == UIGestureRecognizerStateBegan){
        [self stopLoop];
    }else if(gesture.state == UIGestureRecognizerStateEnded){
        [self startLoop];
    }
}

-(void)initSubviews{
    self.backgroundColor = [UIColor blackColor];
    [self addSubview:self.contentView];
    [self addSubview:self.pageControl];
}

-(void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    self.contentView.frame = self.bounds;
    [self.pageControl sizeForNumberOfPages:self.pageControl.numberOfPages];
    self.pageControl.width = self.width;
    self.pageControl.x = (self.width - self.pageControl.width) * 0.5f;
    self.pageControl.y = self.height - self.pageControl.height - 10.0f;
    self.contentView.height = self.height - 20.0f;
}

-(void)layoutSubviews{
    [super layoutSubviews];
}

-(void)dealloc{
    [_contentView.panGestureRecognizer removeTarget:self action:@selector(panGestureHandler:)];
    [_contentView removeFromSuperview];
    _imageModelList = nil;
    _imageList = nil;
    _contentView = nil;
    _pageControl = nil;
    [_loopTimer invalidate];
    _loopTimer = nil;
}

-(void)setImageModelList:(NSArray *)aList{
    _imageModelList = aList;
    [self clear];
    [self applyData];
    [self setNeedsLayout];
}

- (NSMutableArray *)imageList
{
    if (!_imageList) {
        _imageList = @[].mutableCopy;
    }
    return _imageList;
}

- (HLLoopImageScrollView *)contentView
{
    if (!_contentView) {
        _contentView = [[HLLoopImageScrollView alloc] init];
        _contentView.loopDelegate = self;
    }
    return _contentView;
}

- (UIPageControl *)pageControl
{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] init];
    }
    return _pageControl;
}


@end

@implementation HLImageModel

-(void)dealloc{
    _image = nil;
}

@end
