//
//  HLScrollView.m
//  AideBox
//
//  Created by 方海龙 on 15/9/28.
//  Copyright (c) 2015年 方海龙. All rights reserved.
//

#import "HLScrollView.h"

@implementation HLScrollView


-(void)hiddenKeyboard{
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    if(!self.dragging){
        [self.nextResponder touchesBegan:touches withEvent:event];
    }
    [super touchesBegan:touches withEvent:event];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    if(!self.dragging){
        [self.nextResponder touchesEnded:touches withEvent:event];
    }
    
    [self hiddenKeyboard];
    
    [super touchesEnded:touches withEvent:event];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]] || [otherGestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]] ) {
        return YES;
    }
    return NO;
}

-(BOOL)touchesShouldCancelInContentView:(UIView *)view{
    return YES;
}

@end
