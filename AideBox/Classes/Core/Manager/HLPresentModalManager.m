//
//  HLPresentModalManager.m
//  AideBox
//
//  Created by 方海龙 on 15/9/28.
//  Copyright (c) 2015年 方海龙. All rights reserved.
//

#import "HLPresentModalManager.h"

@interface HLPresentModalManager()

@property (nonatomic, strong) NSMutableArray *modalViewArr;

@property (nonatomic, strong) NSMutableArray *modalControllerArr;

@property (nonatomic, copy) void (^presentCompleteCallback)(void);

@end

@implementation HLPresentModalManager

static HLPresentModalManager *instance = nil;

+(HLPresentModalManager *)shareInstance{
    @synchronized(self){
        if(!instance){
            instance = [[self alloc] init];
        }
    }
    return instance;
}

+(void)presentModalController:(UIViewController *)modalController animation:(BOOL)animation completion:(void (^)(void))completion{
    HLPresentModalManager *aInstance = [HLPresentModalManager shareInstance];
    [aInstance presentModalController:modalController animation:animation completion:completion];
}

-(void)presentModalController:(UIViewController *)modalController animation:(BOOL)animation completion:(void (^)(void))completion{
    [self.modalControllerArr addObject:modalController];
    [self presentModalViewImpl:modalController.view animation:animation completion:completion];
}

+(void)presentModalView:(UIView *)modalView animation:(BOOL)animation completion:(void (^)(void))completion{
    HLPresentModalManager *aInstance = [HLPresentModalManager shareInstance];
    [aInstance presentModalViewImpl:modalView animation:animation completion:completion];
}

-(void)presentModalViewImpl:(UIView *)modalView animation:(BOOL)animation completion:(void (^)(void))completion{
    self.presentCompleteCallback = completion;
    [self.modalViewArr addObject:modalView];
    
    UIWindow *appWindow = [UIApplication sharedApplication].keyWindow;
    
    CGRect startFrame;
    if(animation){
        startFrame = CGRectMake(appWindow.bounds.origin.x, appWindow.bounds.size.height, appWindow.bounds.size.width, appWindow.bounds.size.height);
    }else{
        startFrame = appWindow.bounds;
    }
    
    modalView.frame = startFrame;
    
    [appWindow addSubview:modalView];
    
    if(animation){
        __block typeof(self) welf = self;
        
        CGRect targetFrame = appWindow.bounds;
        
        [UIView animateWithDuration:0.35f animations:^{
            modalView.frame = targetFrame;
        } completion:^(BOOL finished) {
            [welf presentModalCompleteHandler];
        }];
    }else{
        [self presentModalCompleteHandler];
    }
}

-(void)presentModalCompleteHandler{
    if(self.presentCompleteCallback){
        self.presentCompleteCallback();
        self.presentCompleteCallback = NULL;
    }
}

+(void)dismissModalController:(UIViewController *)modalController animation:(BOOL)animation completion:(void (^)(void))completion{
    HLPresentModalManager *aInstance = [HLPresentModalManager shareInstance];
    [aInstance dismissModalController:modalController animation:animation completion:completion];
}

-(void)dismissModalController:(UIViewController *)modalController animation:(BOOL)animation completion:(void (^)(void))completion{
    [self dismissModalViewImpl:modalController.view animation:animation completion:completion];
    
    if([self.modalControllerArr containsObject:modalController]){
        [self.modalControllerArr removeObject:modalController];
    }
}

+(void)dismissModalView:(UIView *)modalView animation:(BOOL)animation completion:(void (^)(void))completion{
    HLPresentModalManager *aInstance = [HLPresentModalManager shareInstance];
    [aInstance dismissModalViewImpl:modalView animation:animation completion:completion];
}

-(void)dismissModalViewImpl:(UIView *)modalView animation:(BOOL)animation completion:(void (^)(void))completion{
    
    UIWindow *appWindow = [UIApplication sharedApplication].keyWindow;
    
    CGRect targetFrame = CGRectMake(appWindow.bounds.origin.x, appWindow.bounds.size.height, appWindow.bounds.size.width, appWindow.bounds.size.height);
    
    if(animation){
        __weak typeof(self) welf = self;
        
        [UIView animateWithDuration:0.35f animations:^{
            modalView.frame = targetFrame;
        } completion:^(BOOL finished) {
            [welf dismissModalCompleteHandler:modalView];
            if(completion){
                completion();
            }
        }];
    }else{
        [self dismissModalCompleteHandler:modalView];
        if(completion){
            completion();
        }
    }
}


-(void)dismissModalCompleteHandler:(UIView *)modalView{
    [modalView removeFromSuperview];
    if([self.modalViewArr containsObject:modalView]){
        [self.modalViewArr removeObject:modalView];
        modalView = nil;
    }
}

-(NSMutableArray *)modalViewArr{
    if(!_modalViewArr){
        _modalViewArr = @[].mutableCopy;
    }
    
    return _modalViewArr;
}

-(NSMutableArray *)modalControllerArr{
    if(!_modalControllerArr){
        _modalControllerArr = @[].mutableCopy;
    }
    
    return _modalControllerArr;
}

-(void)dealloc{
    [_modalControllerArr removeAllObjects];
    [_modalViewArr removeAllObjects];
    _modalViewArr = nil;
    _modalControllerArr = nil;
}

@end
