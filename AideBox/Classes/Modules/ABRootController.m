//
//  ABRootController.m
//  AideBox
//
//  Created by 方海龙 on 15/9/28.
//  Copyright (c) 2015年 方海龙. All rights reserved.
//

#import "ABRootController.h"
#import "MenuParser.h"
#import "MenuViewModel.h"

@interface ABRootController ()

@property (nonatomic, strong) HLTabBar *mTabBar;

@end

@implementation ABRootController

#pragma mark -------------------以下是页面交互部分--------------------

-(void)selectTabAtIndex:(NSInteger)index{
    self.mTabBar.selectedIndex = index;
}

-(void)tabBar:(HLTabBar *)tabBar didChangeSelectedIndex:(NSUInteger)selectedIndex{
    [self setSelectedIndex:selectedIndex];
}

#pragma mark -------------------以下是与调度器相关部分--------------------

-(id<IDispatch>)fetchDispatchInIdle:(NSString *)clazzName{
    
    id<IDispatch> resultDispatch = nil;
    
    for(NSObject *dispatchObj in self.dispatchArr){
        NSString *adClazzName = NSStringFromClass([dispatchObj class]);
        if(adClazzName.length == 0 || ![clazzName isEqualToString:adClazzName]){
            continue;
        }
        if(![dispatchObj conformsToProtocol:@protocol(IDispatch)]){
            continue;
        }
        
        id<IDispatch> aDispatch = (id<IDispatch>)dispatchObj;
        
        if(aDispatch.isIdle){
            resultDispatch = aDispatch;
            resultDispatch.idle = NO;
            break;
        }
    }
    
    return resultDispatch;
}

-(id<IDispatch>)fetchIdleDispatchWithDispatcher:(NSString *)dispatcher interactor:(NSString *)interactor{
    id<IDispatch> resultDispatch = [self fetchDispatchInIdle:dispatcher];
    if(!resultDispatch){
        resultDispatch = [HLAssemblyFactory assemblySpecificForView:self dispatcher:dispatcher interactor:interactor];
    }
    
    return resultDispatch;
}

#pragma mark -------------------以下是页面初始化部分--------------------

-(void)initConfigureUsingBlock:(void (^)(void))configureCompleteBlock{
    MenuParser *parser = [[MenuParser alloc] init];
    BOOL success = [parser parsing:nil];
    if(success){
        NSArray *menuList = (NSArray *)parser.successData;
        [self initMenuWithList:menuList];
    }
    if(configureCompleteBlock){
        configureCompleteBlock();
    }
}

-(void)initMenuWithList:(NSArray *)aList{
    NSMutableArray *controllerList = @[].mutableCopy;
    NSMutableArray *items = @[].mutableCopy;
    for(MenuViewModel *model in aList){
        UIViewController *controller = [self fetchControllerWithClazzName:model.className title:model.title];
        [controllerList addObject:controller];
        HLTabBarItem *item = [[HLTabBarItem alloc] init];
        item.titleFontSize = size_font_tabbar;
        item.title = model.title;
//        item.normalImage = model.normalImage;
//        item.highlightImage = model.highlightImage;
        item.gap = 2.0f;
        [items addObject:item];
    }
    self.viewControllers = controllerList;
    self.mTabBar.items = items;
    [self.tabBar addSubview:self.mTabBar];
}

-(void)initSubviews{
}

-(UINavigationController *)fetchControllerWithClazzName:(NSString *)clazzName title:(NSString *)aTitle{
    UINavigationController *navController;
    UIViewController *controller = (UIViewController *)[HLAssemblyFactory assemblyWithClassName:clazzName];
    if(controller){
        controller.title = aTitle;
        navController = [[UINavigationController alloc] initWithRootViewController:controller];
    }else{
        navController = [[UINavigationController alloc] init];
    }
    return navController;
}

#pragma mark -------------------以下是页面布局部分--------------------

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    self.mTabBar.frame = self.tabBar.bounds;
    [self.tabBar bringSubviewToFront:self.mTabBar];
}

#pragma mark -------------------以下是Controller生命周期部分--------------------

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"";
    }
    return self;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    
    [self initSubviews];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

-(void)destory{
    [_dispatchArr removeAllObjects];
    _dispatchArr = nil;
    _mTabBar = nil;
}

-(void)dealloc{
    [self destory];
}

#pragma mark -------------------以下为Getters And Setters部分--------------------

@synthesize dispatchArr = _dispatchArr;

-(NSMutableArray *)dispatchArr{
    if(!_dispatchArr){
        _dispatchArr = @[].mutableCopy;
    }
    
    return _dispatchArr;
}

- (HLTabBar *)mTabBar
{
    if (!_mTabBar) {
        _mTabBar = [[HLTabBar alloc] init];
        _mTabBar.showUnderLine = YES;
        _mTabBar.lineColor = color_tabBar_under_line;
        _mTabBar.delegate = self;
    }
    return _mTabBar;
}


@end
