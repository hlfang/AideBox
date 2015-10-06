//
//  AppDelegate.m
//  AideBox
//
//  Created by 方海龙 on 15/9/27.
//  Copyright (c) 2015年 方海龙. All rights reserved.
//

#import "AppDelegate.h"
#import "MLTransition.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = [[UIViewController alloc] init];
    [self.window makeKeyAndVisible];
    self.window.backgroundColor = [UIColor whiteColor];
    
    [self initAPPConfigure];

    return YES;
}

/**
 *  初始化APP配置
 */
-(void)initAPPConfigure{
    [MLTransition validatePanPackWithMLTransitionGestureRecognizerType:MLTransitionGestureRecognizerTypePan];

    NSString *menuPath = [[NSBundle mainBundle] pathForResource:@"MenuConfigure.xml" ofType:nil];
    [HLResourceManager initMenuResourceWithPath:menuPath];
    
    self.rootController = (ABRootController *)[HLAssemblyFactory assemblyBaseView:@"ABRootController"];
    
    __weak typeof(self) welf = self;
    [self.rootController initConfigureUsingBlock:^{
        [welf.rootController selectTabAtIndex:0];
        welf.window.rootViewController = welf.rootController;
    }];
}

@end