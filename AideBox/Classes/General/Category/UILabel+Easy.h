//
//  UILabel+Easy.h
//  Design
//
//  Created by fanghailong on 15-4-20.
//  Copyright (c) 2015年 superd3d. All rights reserved.
//  UILabel扩展

#import <UIKit/UIKit.h>

@interface UILabel (Easy)

+(UILabel *)labelWithText:(NSString *)aText fontSize:(CGFloat)afSize textColor:(UIColor *)aColor wordWrap:(BOOL)wrap;

@end
