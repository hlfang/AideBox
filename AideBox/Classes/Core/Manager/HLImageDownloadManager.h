//
//  HLImageDownloadManager.h
//  AideBox
//
//  Created by 方海龙 on 15/9/28.
//  Copyright (c) 2015年 方海龙. All rights reserved.
//  图片下载资源管理

#import <Foundation/Foundation.h>

@class HLImageDownloadManager;
@class HLTableViewCell;

@protocol ImageDownloadDelegate <NSObject>

@optional

-(void)imageDownloadCompleteWithImage:(UIImage *)image;

-(void)imageDownloadCompleteWithPath:(NSString *)imagePath image:(UIImage *)aImage;

-(void)imageDownloadCompleteForTableCell:(HLTableViewCell *)tableCell imagePath:(NSString *)imgPath image:(UIImage *)aImage;

@end

@interface HLImageDownloadManager : NSObject

-(void)imageDonloadWithImagePath:(NSString *)imgPath completion:(void (^)(UIImage *aImage))completion;

-(void)imageDonloadWithImagePath:(NSString *)imgPath delegate:(id<ImageDownloadDelegate>)aDelegate;

-(void)imageDonloadWithImagePath:(NSString *)imgPath delegate:(id<ImageDownloadDelegate>)aDelegate forTableCell:(UITableViewCell *)tableCell;

@end
