//
//  UILabel+Easy.m
//  Camera3D
//
//  Created by fanghailong on 15-4-20.
//  Copyright (c) 2015年 superd3d. All rights reserved.
//

#import "UILabel+Easy.h"

@implementation UILabel (Easy)

+(UILabel *)labelWithText:(NSString *)aText fontSize:(CGFloat)afSize textColor:(UIColor *)aColor wordWrap:(BOOL)wrap{
    UILabel *label = [[UILabel alloc] init];
    label.text = aText;
    label.backgroundColor = [UIColor clearColor];
  label.font = [UIFont systemFontOfSize:afSize];
    label.textColor = aColor;
    if(wrap){
        label.lineBreakMode = NSLineBreakByWordWrapping;
        label.numberOfLines = 0;
    }
    return label;
}

@end
