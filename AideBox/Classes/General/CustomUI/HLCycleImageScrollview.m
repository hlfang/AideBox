//
//  HLImageScrollview.m
//  AideBox
//
//  Created by 方海龙 on 15/10/2.
//  Copyright (c) 2015年 方海龙. All rights reserved.
//

#import "HLCycleImageScrollview.h"
#import "HLImageView.h"

@interface HLCycleImageScrollview ()

@property (nonatomic, strong) NSMutableSet *recycledQueue;

@property (nonatomic, strong) NSMutableSet *visibleQueue;

@property (nonatomic, assign) NSUInteger lastIndex;

@end

@implementation HLCycleImageScrollview


#pragma mark -------------------以下是页面初始化部分--------------------

-(void)clear{
    [self.visibleQueue makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.recycledQueue makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.visibleQueue removeAllObjects];
    [self.recycledQueue removeAllObjects];
}

-(void)applyData{
    [self recyclePages];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self recyclePages];
}

-(void)recyclePages{
    if(self.imageList.count == 0){
        return;
    }
    CGRect visibleBounds = self.bounds;
    if(visibleBounds.origin.x < 0){
        return;
    }
    NSUInteger firstPageIndex = floorf(CGRectGetMinX(visibleBounds) / CGRectGetWidth(visibleBounds));
    NSUInteger lastPageIndex = floorf((CGRectGetMaxX(visibleBounds) - 1) / CGRectGetWidth(visibleBounds));
    
    firstPageIndex = MAX(firstPageIndex, 0);
    lastPageIndex = MIN(lastPageIndex, self.imageList.count - 1);
    
    for(HLImageView *imageView in self.visibleQueue){
        if(imageView.index < firstPageIndex || imageView.index > lastPageIndex){
            [self.recycledQueue addObject:imageView];
            [imageView removeFromSuperview];
        }
    }
    
    [self.visibleQueue minusSet:self.recycledQueue];
    
    for(NSInteger idx = firstPageIndex; idx <= lastPageIndex; idx++){
        if(idx < 0 && idx >= self.imageList.count){
            continue;
        }
        BOOL isShowing = [self showingViewForIndex:idx];
        if(!isShowing){
            HLImageView *imageView = [self dequeueRecycled];
            if(!imageView){
                imageView = [[HLImageView alloc] init];
            }
            [self configureView:imageView index:idx];
            [self addSubview:imageView];
            [self.visibleQueue addObject:imageView];
        }
    }
}

-(void)configureView:(HLImageView *)imageView index:(NSUInteger)index{
    UIImage *aImage = [self.imageList objectAtIndex:index];
    imageView.index = index;
    imageView.image = aImage;
    CGFloat tw = self.frame.size.width;
    CGFloat th = self.frame.size.height;
    CGFloat tx = self.frame.size.width * index + (self.frame.size.width - tw) * 0.5f;
    CGFloat ty = (self.frame.size.height - th) * 0.5f;
    imageView.frame = CGRectMake(tx, ty, tw, th);
}

-(HLImageView *)dequeueRecycled{
    HLImageView *imageView = [self.recycledQueue anyObject];
    if(imageView){
        [self.recycledQueue removeObject:imageView];
    }
    
    return imageView;
}

-(BOOL)showingViewForIndex:(NSUInteger)index{
    BOOL isShowing = NO;
    
    for(HLImageView *imageView in self.visibleQueue){
        if(imageView.index == index){
            isShowing = YES;
            break;
        }
    }
    
    return isShowing;
}

-(instancetype)init{
    self = [super init];
    if (self) {
        self.delegate = self;
        [self initSubviews];
    }
    return self;
}

-(void)initSubviews{
    self.pagingEnabled = YES;
    self.bounces = NO;
    self.delegate = self;
    self.userInteractionEnabled = YES;
    self.showsHorizontalScrollIndicator=NO;
    self.showsVerticalScrollIndicator= NO;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.contentSize = CGSizeMake(self.frame.size.width * self.imageList.count, self.bounds.size.height);
}

-(void)dealloc{
    [_visibleQueue makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [_recycledQueue makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [_recycledQueue removeAllObjects];
    [_visibleQueue removeAllObjects];
    _visibleQueue = nil;
    _recycledQueue = nil;
    _imageList = nil;
}

-(void)setImageList:(NSArray *)aList{
    _imageList = aList;
    [self clear];
    [self applyData];
    [self setNeedsLayout];
}

- (NSMutableSet *)recycledQueue
{
    if (!_recycledQueue) {
        _recycledQueue = [[NSMutableSet alloc] init];
    }
    return _recycledQueue;
}

- (NSMutableSet *)visibleQueue
{
    if (!_visibleQueue) {
        _visibleQueue = [[NSMutableSet alloc] init];
    }
    return _visibleQueue;
}

@end
