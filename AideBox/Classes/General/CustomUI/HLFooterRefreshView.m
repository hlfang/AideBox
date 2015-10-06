//
//  HLFooterRefreshView.m
//  AideBox
//
//  Created by 方海龙 on 15/10/6.
//  Copyright (c) 2015年 方海龙. All rights reserved.
//

#define ROUND_TIME 1.5
#define DEFAULT_LINE_WIDTH 2.0
#define DEFAULT_COLOR [UIColor orangeColor]

#import "HLFooterRefreshView.h"

@interface HLFooterRefreshView()

@property (nonatomic, strong) HLFooterProgress *progress;

@end

@implementation HLFooterRefreshView


#pragma mark -------------------以下是页面初始化部分--------------------

-(void)startAnimation{
    [self.progress startAnimation];
}

-(void)stopAnimation{
    [self.progress stopAnimation];
}

-(BOOL)isAnimating{
    return [self.progress isAnimating];
}

-(instancetype)init{
    self = [super init];
    if (self) {
        [self initSubviews];
    }
    return self;
}

-(void)initSubviews{
}

-(void)layoutSubviews{
    [super layoutSubviews];
}

-(void)dealloc{
    _lineColor = nil;
    [_progress stopAnimation];
    _progress = nil;
}

-(void)setLineColor:(UIColor *)aColor{
    _lineColor = aColor;
    _progress.lineColor = _lineColor;
}

-(void)setLineWidth:(CGFloat)aValue{
    _lineWidth = aValue;
    _progress.lineWidth = _lineWidth;
}

- (HLFooterProgress *)progress
{
    if (!_progress) {
        _progress = [[HLFooterProgress alloc] init];
    }
    return _progress;
}


@end

@interface HLFooterProgress()

@property (nonatomic, strong) CAShapeLayer *circleLayer;
@property (nonatomic, strong) CAAnimationGroup *strokeLineAnimation;
@property (nonatomic, strong) CAAnimation *rotationAnimation;
@property (nonatomic, strong) CAAnimation *strokeColorAnimation;
@property (nonatomic, assign) BOOL animating;

@end

@implementation HLFooterProgress

- (instancetype)init {
    self = [super init];
    if(self) {
        self.lineColor = [UIColor redColor];
        self.lineWidth = 1.0f;
        [self initialSetup];
    }
    return self;
}

- (void)initialSetup {
    self.circleLayer = [CAShapeLayer layer];
    [self.layer addSublayer:self.circleLayer];
    
    self.backgroundColor = [UIColor clearColor];
    self.circleLayer.fillColor = nil;
    self.circleLayer.lineWidth = 1.0f;
    self.circleLayer.lineCap = kCALineCapRound;
    
    [self updateAnimations];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGPoint center = CGPointMake(self.bounds.size.width / 2.0, self.bounds.size.height / 2.0);
    CGFloat radius = MIN(self.bounds.size.width, self.bounds.size.height)/2.0 - self.circleLayer.lineWidth / 2.0;
    CGFloat startAngle = 0;
    CGFloat endAngle = 2*M_PI;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center
                                                        radius:radius
                                                    startAngle:startAngle
                                                      endAngle:endAngle
                                                     clockwise:YES];
    self.circleLayer.path = path.CGPath;
    self.circleLayer.frame = self.bounds;
}

- (void)startAnimation {
    _animating = YES;
    [self.circleLayer addAnimation:self.strokeLineAnimation forKey:@"strokeLineAnimation"];
    [self.circleLayer addAnimation:self.rotationAnimation forKey:@"rotationAnimation"];
    [self.circleLayer addAnimation:self.strokeColorAnimation forKey:@"strokeColorAnimation"];
}

- (void)stopAnimation {
    _animating = NO;
    [self.circleLayer removeAnimationForKey:@"strokeLineAnimation"];
    [self.circleLayer removeAnimationForKey:@"rotationAnimation"];
    [self.circleLayer removeAnimationForKey:@"strokeColorAnimation"];
}

- (BOOL)isAnimating {
    return _animating;
}

- (void)updateAnimations {
    // Stroke Head
    CABasicAnimation *headAnimation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    headAnimation.beginTime = ROUND_TIME/3.0;
    headAnimation.fromValue = @0;
    headAnimation.toValue = @1;
    headAnimation.duration = 2*ROUND_TIME/3.0;
    headAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    // Stroke Tail
    CABasicAnimation *tailAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    tailAnimation.fromValue = @0;
    tailAnimation.toValue = @1;
    tailAnimation.duration = 2*ROUND_TIME/3.0;
    tailAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    // Stroke Line Group
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.duration = ROUND_TIME;
    animationGroup.repeatCount = INFINITY;
    animationGroup.animations = @[headAnimation, tailAnimation];
    self.strokeLineAnimation = animationGroup;
    
    // Rotation
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotationAnimation.fromValue = @0;
    rotationAnimation.toValue = @(2*M_PI);
    rotationAnimation.duration = ROUND_TIME;
    rotationAnimation.repeatCount = INFINITY;
    self.rotationAnimation = rotationAnimation;
    
    CAKeyframeAnimation *strokeColorAnimation = [CAKeyframeAnimation animationWithKeyPath:@"strokeColor"];
    strokeColorAnimation.values = @[(id)_lineColor.CGColor];
    strokeColorAnimation.keyTimes = @[[NSNumber numberWithFloat:1.0f]];
    strokeColorAnimation.calculationMode = kCAAnimationDiscrete;
    strokeColorAnimation.duration = 0.35f;
    strokeColorAnimation.repeatCount = INFINITY;
    self.strokeColorAnimation = strokeColorAnimation;
}


-(void)dealloc{
    _lineColor = nil;
    [self stopAnimation];
    [_circleLayer removeFromSuperlayer];
    _circleLayer = nil;
    _strokeLineAnimation = nil;
    _rotationAnimation = nil;
    _strokeColorAnimation = nil;
}

- (void)setLineWidth:(CGFloat)lineWidth {
    _lineWidth = lineWidth;
    self.circleLayer.lineWidth = _lineWidth;
}

@end
