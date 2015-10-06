//
//  ABViewController.m
//  AideBox
//
//  Created by 方海龙 on 15/9/27.
//  Copyright (c) 2015年 方海龙. All rights reserved.
//

#import "HLViewController.h"
#import "AppDelegate.h"
#import "HLAssemblyFactory.h"
#import "HLBaseDispatch.h"

@interface HLViewController ()

/**
 *  记录当前栈的controller数量(如果自身是由UINavigationController管理的)
 */
@property (nonatomic, assign) NSNumber *curentStackCount;

/**
 *  背景图层
 */
@property (nonatomic, strong) UIImageView *backgroundImageView;

/**
 *  导航栏
 */
@property (nonatomic, strong) UIView *mNavgationBar;

/**
 *  内容容器
 */
@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIButton *leftButton;

@property (nonatomic, strong) UIButton *rightButton;

@property (nonatomic, strong) UIView *mBottomBar;

@end

@implementation HLViewController

#pragma mark -------------------以下是页面交互部分--------------------

-(void)backButtonTouchHandler:(id)sender{
    if(self.navigationController){
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self dismissViewControllerAnimated:YES completion:NULL];
    }
}

#pragma mark -------------------以下是与调度器相关部分--------------------

-(id<IDispatch>)fetchIdleDispatchWithDispatcher:(NSString *)dispatcher interactor:(NSString *)interactor{
    id<IDispatch> resultDispatch = [self fetchDispatchInIdle:dispatcher];
    if(!resultDispatch){
        resultDispatch = [HLAssemblyFactory assemblySpecificForView:self dispatcher:dispatcher interactor:interactor];
        resultDispatch.idle = NO;
    }
    
    return resultDispatch;
}

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
        
        if(!aDispatch.isIdle){
            resultDispatch = aDispatch;
            resultDispatch.idle = YES;
            break;
        }
    }
    
    if(!resultDispatch){
        resultDispatch = [HLAssemblyFactory assemblySpecificForView:self dispatcher:@"HLBaseDispatch" interactor:@"HLBaseInteractor"];
    }
    
    return resultDispatch;
}

-(id<IDispatch>)fetchBaseDispatchInIdle{
    return [self fetchDispatchInIdle:@"HLBaseDispatch"];
}

-(id<IDispatch>)assemblyDispatch{
    id<IDispatch> resultDispatch = [HLAssemblyFactory assemblyBaseDispatch:self];
    resultDispatch.idle = NO;
    [self.dispatchArr addObject:resultDispatch];
    
    return resultDispatch;
}

-(void)acceptParam:(id)aParam{
    self.parameter = aParam;
}

#pragma mark -------------------以下是页面布局部分--------------------

-(void)layoutSubElements{
    _invalid = NO;
    if(_backgroundImageView){
        self.backgroundImageView.frame = self.view.bounds;
        [self.view sendSubviewToBack:self.backgroundImageView];
    }

    self.mNavgationBar.width = self.view.width;
    self.mNavgationBar.height = statuBarHeight + kNavigationBarHeight;
    
    if([self.view.subviews containsObject:self.mBottomBar]){
        self.mBottomBar.width = self.view.width;
        self.mBottomBar.height = kBottomBarHeight;
        self.mBottomBar.y = self.view.height - self.mBottomBar.height;
    }
    
    [self.titleLabel sizeToFit];
    self.titleLabel.x = (self.mNavgationBar.width - self.titleLabel.width) * 0.5f;
    self.titleLabel.y = statuBarHeight + (self.mNavgationBar.height - statuBarHeight - self.titleLabel.height) * 0.5f;
    
    [self.leftButton sizeToFit];
    self.leftButton.x = kAppGap;

    if([self.mNavgationBar.subviews containsObject:self.leftButton]){
        self.leftButton.y = statuBarHeight + (self.mNavgationBar.height - statuBarHeight - self.leftButton.height) * 0.5f;
    }else if([self.mBottomBar.subviews containsObject:self.leftButton]){
        self.leftButton.y = (self.mBottomBar.height - self.leftButton.height) * 0.5f;
    }
    
    [self.rightButton sizeToFit];
    self.rightButton.x = self.mNavgationBar.width - kAppGap - self.rightButton.width;
    self.rightButton.y = statuBarHeight + (self.mNavgationBar.height - statuBarHeight - self.rightButton.height) * 0.5f;
    
    self.contentView.frame = self.contentRect;
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    [self.view bringSubviewToFront:self.mNavgationBar];
}

#pragma mark -------------------以下是页面初始化部分--------------------

-(void)initConfigure{
    if([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]){
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.title = @"";
    self.navigationController.navigationBarHidden = YES;
}

-(void)initSubviews{
    [self.view addSubview:self.mNavgationBar];
    [self.view addSubview:self.contentView];
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

-(BOOL)prefersStatusBarHidden{
    return self.hiddenStatusBar;
}

-(void)addTopBackButton{
    [self addLeftButtonWithNormalImage:ic_back_normal highlightImage:ic_back_highlight selector:@selector(backButtonTouchHandler:)];
}

-(void)addBottomBackButton{
    self.leftButton = [[UIButton alloc] init];
    [_leftButton didSetImageWithNormalImage:ic_back_normal highlightImage:ic_back_highlight];
    [_leftButton addTarget:self action:@selector(backButtonTouchHandler:) forControlEvents:UIControlEventTouchUpInside];
    [self.mBottomBar addSubview:self.leftButton];
    [self.view addSubview:self.mBottomBar];
}

-(void)addLeftButtonWithNormalImage:(UIImage *)normalImg highlightImage:(UIImage *)highlightImg selector:(SEL)aSelector{
    self.leftButton = [[UIButton alloc] init];
    [_leftButton didSetImageWithNormalImage:normalImg highlightImage:highlightImg];
    [_leftButton addTarget:self action:aSelector forControlEvents:UIControlEventTouchUpInside];
    [self.mNavgationBar addSubview:_leftButton];
}

-(void)addLeftButtonWithText:(NSString *)aText normalTextColor:(UIColor *)normalColor highlightColor:(UIColor *)highlightColor selector:(SEL)aSelector{
    self.leftButton = [UIButton buttonWithTitle:aText normalTitleColor:normalColor highlightTitleColor:highlightColor fontSize:size_font_navBar_subTitle];
    [_leftButton addTarget:self action:aSelector forControlEvents:UIControlEventTouchUpInside];
    [self.mNavgationBar addSubview:_leftButton];
}

-(void)addRightButtonWithNormalImage:(UIImage *)normalImg highlightImage:(UIImage *)highlightImg selector:(SEL)aSelector{
    self.rightButton = [[UIButton alloc] init];
    [_rightButton didSetImageWithNormalImage:normalImg highlightImage:highlightImg];
    [_rightButton addTarget:self action:aSelector forControlEvents:UIControlEventTouchUpInside];
    [self.mNavgationBar addSubview:_rightButton];
}

-(void)addRightButtonWithText:(NSString *)aText normalTextColor:(UIColor *)normalColor highlightColor:(UIColor *)highlightColor selector:(SEL)aSelector{
    self.rightButton = [UIButton buttonWithTitle:aText normalTitleColor:normalColor highlightTitleColor:highlightColor fontSize:size_font_navBar_subTitle];
    [_rightButton addTarget:self action:aSelector forControlEvents:UIControlEventTouchUpInside];
    [self.mNavgationBar addSubview:_rightButton];
}

#pragma mark -------------------以下是生命周期部分--------------------

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initConfigure];
    }
    return self;
}

-(void)destory{
    [_dispatchArr removeAllObjects];
    [_backgroundImageView removeFromSuperview];
    _backgroundImageView = nil;
    _backgroundColor = nil;
    _backgroundImage = nil;
    _dispatchArr = nil;
    _mNavgationBar = nil;
    _leftButton = nil;
    _rightButton = nil;
    _titleLabel = nil;
    _contentView = nil;
    _mBottomBar = nil;
}

-(void)dealloc{
    [self destory];
}

-(void)viewDidLoad{
    [super viewDidLoad];
    self.backgroundColor = appBackgroundColor;
    [self initSubviews];
    self.runFirst = YES;
    self.invalid = YES;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:self.hiddenStatusBar];
    self.navigationController.navigationBarHidden = YES;

    NSArray *controllers = self.navigationController.viewControllers;
    BOOL isPush = NO;
    NSUInteger count = self.curentStackCount.intValue;
    if(count > controllers.count){
        isPush = NO;
    }else if(count <= controllers.count){
        isPush = YES;
    }
    self.isPushView = isPush;
    
    self.curentStackCount = [NSNumber numberWithInteger:self.navigationController.viewControllers.count];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    self.curentStackCount = [NSNumber numberWithInteger:self.navigationController.viewControllers.count];
    
    [self hiddenKeyboard];
}


-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesEnded:touches withEvent:event];
    
    [self hiddenKeyboard];
}

-(void)hiddenKeyboard{
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
}

#pragma mark -------------------以下为Getters And Setters部分--------------------

@synthesize parameter = _parameter;

@synthesize dispatchArr = _dispatchArr;

-(NSMutableArray *)dispatchArr{
    if(!_dispatchArr){
        _dispatchArr = @[].mutableCopy;
    }
    
    return _dispatchArr;
}

-(void)setInvalid:(BOOL)aInvalid{
    if(_invalid != aInvalid){
        _invalid = aInvalid;
        if(_invalid){
            [self layoutSubElements];
        }
    }
}

-(void)setTitle:(NSString *)title{
    if(title.length > 0){
        self.titleLabel.text = title;
        [self.mNavgationBar addSubview:self.titleLabel];
        self.invalid = YES;
    }else{
        [self.titleLabel removeFromSuperview];
    }
}

- (UIImageView *)backgroundImageView
{
    if (!_backgroundImageView) {
        _backgroundImageView = [[UIImageView alloc] init];
        _backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _backgroundImageView;
}

-(void)setBackgroundColor:(UIColor *)aColor{
    _backgroundColor = aColor;
    self.view.backgroundColor = _backgroundColor;
}

-(void)setBackgroundImage:(UIImage *)aImage{
    _backgroundImage = aImage;
    if(_backgroundImage){
        self.backgroundImageView.image = self.backgroundImage;
        [self.view addSubview:self.backgroundImageView];
    }else{
        [self.backgroundImageView removeFromSuperview];
    }
}

- (CGRect)contentRect
{
    CGFloat bottomHeight = 0.0f;
    UIViewController *rootController = kRootViewController;
    if([rootController isKindOfClass:[UITabBarController class]]){
        UITabBarController *tabController = (UITabBarController *)rootController;
        bottomHeight = tabController.tabBar.frame.size.height;
    }
    CGFloat offsety;
    if([self.view.subviews containsObject:self.mNavgationBar]){
        offsety = self.mNavgationBar.y + self.mNavgationBar.height;
    }
    if(self.hidesBottomBarWhenPushed){
        bottomHeight = 0.0f;
    }
    
    if([self.view.subviews containsObject:self.mBottomBar]){
        bottomHeight += self.mBottomBar.height;
    }
    
    CGRect aRect = CGRectMake(0.0f, offsety, self.view.width, (self.view.height - offsety - bottomHeight));
    
    return aRect;
}


- (UIView *)mNavgationBar
{
    if (!_mNavgationBar) {
        _mNavgationBar = [[UIView alloc] init];
        _mNavgationBar.backgroundColor = appNavigationBarBackgroundColor;
    }
    return _mNavgationBar;
}

- (UIView *)mBottomBar
{
    if (!_mBottomBar) {
        _mBottomBar = [[UIView alloc] init];
        _mBottomBar.backgroundColor = appBottomBarBackgroundColor;
    }
    return _mBottomBar;
}


- (BOOL)hidesBottomBarWhenPushed {
    id firstObjInStack = [self.navigationController.viewControllers firstObject];
    if(!firstObjInStack || firstObjInStack == self){
        return NO;
    }
    return YES;
}

- (UIView *)contentView
{
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
    }
    return _contentView;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textColor = color_font_navbar;
        _titleLabel.font = [UIFont systemFontOfSize:size_font_navBar_title];
    }
    return _titleLabel;
}


@end
