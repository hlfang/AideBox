//
//  UIButton+Easy.h
//  Design
//
//  Created by 方海龙 on 15-6-22.
//  Copyright (c) 2015年 ptteng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Easy)


+(UIButton *)buttonWithTitle:(NSString *)aTitle normalTitleColor:(UIColor *)notColor highlightTitleColor:(UIColor *)hltColor disabledTitleColor:(UIColor *)distColor normalBGColor:(UIColor *)noBGColor highlightBGColor:(UIColor *)hlBGColor disabledBGColor:(UIColor *)disBGColor fontSize:(CGFloat)aSzie;

-(void)didSetImageWithNormalImage:(UIImage *)nImage highlightImage:(UIImage *)hImage;

+(UIButton *)buttonWithTitle:(NSString *)aTitle normalTitleColor:(UIColor *)notColor highlightTitleColor:(UIColor *)hltColor fontSize:(CGFloat)aSzie;

@end
