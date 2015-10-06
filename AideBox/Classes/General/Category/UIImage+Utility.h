//
//  UIImage+Utility.h
//  Camera3D
//
//  Created by fanghailong on 15/7/1.
//  Copyright (c) 2015年 superd3d. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Utility)

+ (UIImage*)decode:(UIImage*)image;

+ (UIImage*)fastImageWithData:(NSData*)data;
+ (UIImage*)fastImageWithContentsOfFile:(NSString*)path;

- (UIImage*)deepCopy;

- (UIImage*)grayScaleImage;

- (UIImage*)resize:(CGSize)size;
- (UIImage*)aspectFit:(CGSize)size;
- (UIImage*)aspectFill:(CGSize)size;
- (UIImage*)aspectFill:(CGSize)size offset:(CGFloat)offset;

- (UIImage*)crop:(CGRect)rect;

-(UIImage *)crop:(CGRect)rect scale:(CGFloat)ratio;

-(UIImage *)scaleImageWithRatio:(CGFloat)ratio;

- (UIImage*)maskedImage:(UIImage*)maskImage;

- (UIImage*)gaussBlur:(CGFloat)blurLevel;       //  {blurLevel | 0 ≤ t ≤ 1}

+(UIImage *)imageWithColor:(UIColor *)aColor;

+(UIImage *)snapshotForView:(UIView *)view;

+(CGSize)scaleInWidth:(UIImage *)image scaleSize:(CGSize)scaleSize;

+(CGSize)normalScale:(UIImage *)image scaleSize:(CGSize)scaleSize;

-(UIImage *)cropSquare;

@end
