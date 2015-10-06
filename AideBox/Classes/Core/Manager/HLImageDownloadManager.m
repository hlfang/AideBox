//
//  HLImageDownloadManager.m
//  AideBox
//
//  Created by 方海龙 on 15/9/28.
//  Copyright (c) 2015年 方海龙. All rights reserved.
//

#import "HLImageDownloadManager.h"
#import "HLTableViewCell.h"

@interface HLImageDownloadManager()

@property (nonatomic, weak) id <ImageDownloadDelegate> delegate;

@property (nonatomic, strong) NSURLConnection *downloadConn;
//下载图片数据
@property (nonatomic, retain) NSMutableData *downloadData;

@property (nonatomic, strong) HLTableViewCell *tableCell;

@property (nonatomic, strong) NSString *imagePath;

@property (nonatomic, copy) void (^imageDownloadCompletion)(UIImage *aImage);

@end

@implementation HLImageDownloadManager

-(NSString *)encodeToPercentEscapeString:(NSString *)input{
    NSString *outputStr = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,                                                                                            (CFStringRef)input,NULL, (CFStringRef)@"!*'();:@&=+$,/?%#[]", kCFStringEncodingUTF8));
    
    return outputStr;
}

-(UIImage *)loadCacheImage{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *storePath = [self imageStorePath];
    NSString *aImageName = [self imageName];
    storePath = [storePath stringByAppendingPathComponent:aImageName];
    NSData *imageData = [fileManager contentsAtPath:storePath];
    UIImage *image = [UIImage imageWithData:imageData];
    
    return image;
}

-(void)beginRequestImage{
    UIImage *aCacheImage = [self loadCacheImage];
    if(aCacheImage){
        [self requestImageCompleteHandler:aCacheImage];
    }else{
        [self imageDownloadImpl];
    }
}

-(void)imageDonloadWithImagePath:(NSString *)imgPath completion:(void (^)(UIImage *aImage))completion{
    self.imageDownloadCompletion = completion;
    self.imagePath = imgPath;
    UIImage *aCacheImage = [self loadCacheImage];
    if(aCacheImage){
        if(completion){
            completion(aCacheImage);
        }
    }else{
        [self imageDownloadImpl];
    }
}

-(void)imageDonloadWithImagePath:(NSString *)imgPath delegate:(id<ImageDownloadDelegate>)aDelegate{
    self.imagePath = imgPath;
    self.delegate = aDelegate;
    
    [self beginRequestImage];
}

-(void)imageDonloadWithImagePath:(NSString *)imgPath delegate:(id<ImageDownloadDelegate>)aDelegate forTableCell:(HLTableViewCell *)tableCell{
    self.imagePath = imgPath;
    self.delegate = aDelegate;
    self.tableCell = tableCell;
    
    [self beginRequestImage];
}

-(void)imageDownloadImpl{
    NSURL *imageUrl = [NSURL URLWithString:self.imagePath];
    NSURLRequest *request = [NSURLRequest requestWithURL:imageUrl cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    self.downloadConn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

//连接建立成功，初始化图片数据对象
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    self.downloadData = [NSMutableData data];
}

//每当有数据返回，加入数据对象中
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [self.downloadData appendData:data];
}

//连接失败
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    self.downloadConn = nil;
    self.downloadData = nil;
}
//加载完成后将图片加入硬盘缓存，并调用回调方法
- (void)connectionDidFinishLoading:(NSURLConnection*)theConnection{
    UIImage *image = [[UIImage alloc] initWithData:self.downloadData];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *storePath = [self imageStorePath];
    BOOL isExist = [fileManager fileExistsAtPath:storePath];
    if(!isExist){
        [fileManager createDirectoryAtPath:storePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    NSString *aImageName = [self imageName];
    storePath = [storePath stringByAppendingPathComponent:aImageName];
    NSError *error;
    [self.downloadData writeToFile:storePath options:NSDataWritingAtomic error:&error];
    
    [self requestImageCompleteHandler:image];
    
    _downloadConn = nil;
    _downloadData = nil;
    _imagePath = nil;
    _delegate = nil;
    _tableCell = nil;
}

-(void)requestImageCompleteHandler:(UIImage *)aImage{
    if([self.delegate respondsToSelector:@selector(imageDownloadCompleteWithImage:)]){
        [self.delegate imageDownloadCompleteWithImage:aImage];
    }
    
    if([self.delegate respondsToSelector:@selector(imageDownloadCompleteForTableCell:imagePath:image:)]){
        [self.delegate imageDownloadCompleteForTableCell:self.tableCell imagePath:self.imagePath image:aImage];
    }
    
    if([self.delegate respondsToSelector:@selector(imageDownloadCompleteWithPath:image:)]){
        [self.delegate imageDownloadCompleteWithPath:self.imagePath image:aImage];
    }
    
    if(self.imageDownloadCompletion){
        self.imageDownloadCompletion(aImage);
    }
}


-(NSString *)imageStorePath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [paths objectAtIndex:0];
    NSString *storePath = [documentPath stringByAppendingPathComponent:@"ImageCache"];
    
    return storePath;
}

-(NSString *)imageName{
    if(self.imagePath.length == 0){
        return nil;
    }
    
    NSString *aImgName = [self encodeToPercentEscapeString:self.imagePath];
    
//    NSRange range = [self.imagePath rangeOfString:@"/" options:NSBackwardsSearch];
//    NSRange nameRange = NSMakeRange(range.location + 1, self.imagePath.length - range.location - 1);
//    NSString *tempName = [self.imagePath substringWithRange:nameRange];
    
    return aImgName;
}

-(void)dealloc{
    _downloadConn = nil;
    _downloadData = nil;
    _delegate = nil;
    _tableCell = nil;
    _imagePath = nil;
}

@end
