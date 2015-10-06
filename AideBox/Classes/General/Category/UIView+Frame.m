 //
//  UIView+Frame.m
//  Camera3D
//
//  Created by fanghailong on 15-4-17.
//  Copyright (c) 2015年 superd3d. All rights reserved.
//  

#import "UIView+Frame.h"

@implementation UIView (Frame)

-(void)setSize:(CGSize)size{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

-(void)setWidth:(CGFloat)width{
    CGSize size = self.size;
    size.width = width;
    self.size = size;
}

-(void)setHeight:(CGFloat)height{
    CGSize size = self.size;
    size.height = height;
    self.size = size;
}

- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (void)setX:(CGFloat)x {
    CGPoint origin = self.origin;
    origin.x = x;
    self.origin = origin;
}

- (void)setY:(CGFloat)y {
    CGPoint origin = self.origin;
    origin.y = y;
    self.origin = origin;
}

#pragma mark - Getters

- (CGSize)size {
    return self.frame.size;
}

- (CGFloat)width {
    return self.size.width;
}

- (CGFloat)height {
    return self.size.height;
}

- (CGPoint)origin {
    return self.frame.origin;
}

- (CGFloat)x {
    return self.origin.x;
}

- (CGFloat)y {
    return self.origin.y;
}

@end
