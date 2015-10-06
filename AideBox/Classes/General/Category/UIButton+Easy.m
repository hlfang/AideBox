//
//  UIButton+Easy.m
//  Design
//
//  Created by 方海龙 on 15-6-22.
//  Copyright (c) 2015年 ptteng. All rights reserved.
//

#import "UIButton+Easy.h"

@implementation UIButton (Easy)

+(UIButton *)buttonWithTitle:(NSString *)aTitle normalTitleColor:(UIColor *)notColor highlightTitleColor:(UIColor *)hltColor disabledTitleColor:(UIColor *)distColor normalBGColor:(UIColor *)noBGColor highlightBGColor:(UIColor *)hlBGColor disabledBGColor:(UIColor *)disBGColor fontSize:(CGFloat)aSzie{
    
    UIButton *button = [[UIButton alloc] init];
//   button.titleLabel.font = [UIFont systemFontOfSize:aSzie];
    button.titleLabel.font = [UIFont fontWithName:@"STHeitiSC-Medium" size:aSzie];



    [button setTitle:aTitle forState:UIControlStateNormal];
    [button setTitle:aTitle forState:UIControlStateHighlighted];
    [button setTitleColor:notColor forState:UIControlStateNormal];
    [button setTitleColor:hltColor forState:UIControlStateHighlighted];
    [button setTitleColor:distColor forState:UIControlStateDisabled];
    
    {
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(100,100), NO, 0);
        CGContextRef con = UIGraphicsGetCurrentContext();
        CGContextAddRect(con, CGRectMake(0,0,100,100));
        CGContextSetFillColorWithColor(con, noBGColor.CGColor);
        CGContextFillPath(con);
        UIImage* normalBGImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        [button setBackgroundImage:normalBGImage forState:UIControlStateNormal];
    }
    
    {
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(100,100), NO, 0);
        CGContextRef con = UIGraphicsGetCurrentContext();
        CGContextAddRect(con, CGRectMake(0,0,100,100));
        CGContextSetFillColorWithColor(con, hlBGColor.CGColor);
        CGContextFillPath(con);
        UIImage* highlightBGImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        [button setBackgroundImage:highlightBGImage forState:UIControlStateHighlighted];
        [button setBackgroundImage:highlightBGImage forState:UIControlStateSelected];
    }
    
    {
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(100,100), NO, 0);
        CGContextRef con = UIGraphicsGetCurrentContext();
        CGContextAddRect(con, CGRectMake(0,0,100,100));
        CGContextSetFillColorWithColor(con, disBGColor.CGColor);
        CGContextFillPath(con);
        UIImage* disabledBGImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        [button setBackgroundImage:disabledBGImage forState:UIControlStateDisabled];
    }
    
    return button;
}

+(UIButton *)buttonWithNormalImage:(UIImage *)nlImage highlightImage:(UIImage *)hlImage{
    UIButton *button = [[UIButton alloc] init];
    [button setImage:nlImage forState:UIControlStateNormal];
    [button setImage:hlImage forState:UIControlStateHighlighted];
    [button setImage:hlImage forState:UIControlStateSelected];
    
    return button;
}

-(void)didSetImageWithNormalImage:(UIImage *)nImage highlightImage:(UIImage *)hImage{
    [self setImage:nImage forState:UIControlStateNormal];
    [self setImage:hImage forState:UIControlStateHighlighted];
    [self setImage:hImage forState:UIControlStateSelected];
}

+(UIButton *)buttonWithTitle:(NSString *)aTitle normalTitleColor:(UIColor *)notColor highlightTitleColor:(UIColor *)hltColor fontSize:(CGFloat)aSzie{
    UIButton *button = [[UIButton alloc] init];
    button.titleLabel.font = [UIFont systemFontOfSize:aSzie];
    [button setTitle:aTitle forState:UIControlStateNormal];
    [button setTitle:aTitle forState:UIControlStateHighlighted];
    [button setTitle:aTitle forState:UIControlStateSelected];
    [button setTitleColor:notColor forState:UIControlStateNormal];
    [button setTitleColor:hltColor forState:UIControlStateHighlighted];
    [button setTitleColor:hltColor forState:UIControlStateSelected];
    
    return button;
}

@end
