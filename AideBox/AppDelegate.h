//
//  AppDelegate.h
//  AideBox
//
//  Created by 方海龙 on 15/9/27.
//  Copyright (c) 2015年 方海龙. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ABRootController.h"

#define kRootViewController [(AppDelegate *)[[UIApplication sharedApplication] delegate] rootController]

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong) ABRootController *rootController;

@end

