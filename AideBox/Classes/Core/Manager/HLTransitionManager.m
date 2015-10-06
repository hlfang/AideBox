//
//  HLTransitionManager.m
//  AideBox
//
//  Created by 方海龙 on 15/9/28.
//  Copyright (c) 2015年 方海龙. All rights reserved.
//

#import "HLTransitionManager.h"

static const CGFloat kAnimationDuration = 0.3f;

@implementation HLTransitionManager

+(CATransition *)modalTransition{
    CATransition* transition = [CATransition animation];
    transition.duration = kAnimationDuration;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    transition.type = kCATransitionFade;
    transition.subtype = kCATransitionFromTop;
    
    return transition;
}

+(CATransition *)dismisTransition{
    CATransition* transition = [CATransition animation];
    transition.duration = kAnimationDuration;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    transition.type = kCATransitionFade;
    transition.subtype = kCATransitionFromBottom;
    
    return transition;
}

@end
