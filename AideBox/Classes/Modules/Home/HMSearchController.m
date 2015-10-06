//
//  HMSearchController.m
//  AideBox
//
//  Created by 方海龙 on 15/10/4.
//  Copyright (c) 2015年 方海龙. All rights reserved.
//

#import "HMSearchController.h"
#import "HLTextField.h"

@interface HMSearchController ()

@property (nonatomic, strong) HLTextField *textField;

@end

@implementation HMSearchController


#pragma mark -------------------以下为页面交互部分--------------------


#pragma mark -------------------以下为请求数据部分--------------------



#pragma mark -------------------以下为请求返回部分--------------------



#pragma mark -------------------以下是进度显示部分--------------------



#pragma mark -------------------以下是页面跳转部分--------------------



#pragma mark -------------------以下是页面初始化部分--------------------

-(void)initSubviews{
    [super initSubviews];
    [self.view addSubview:self.textField];
    [self addBottomBackButton];
}


#pragma mark -------------------以下是页面布局部分--------------------

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    self.textField.width = self.view.width - kAppGap * 2.0f;
    self.textField.x = (self.view.width - self.textField.width) * 0.5f;
    self.textField.height = 40.0f;
    self.textField.y = statuBarHeight + kAppGap;
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
    [self.mNavgationBar removeFromSuperview];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.textField becomeFirstResponder];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}


#pragma mark -------------------以下为Getters And Setters部分--------------------

- (HLTextField *)textField
{
    if (!_textField) {
        _textField = [[HLTextField alloc] init];
        _textField.placeholder = @"热门搜索";
        _textField.textColor = [UIColor whiteColor];
        _textField.rightImageName = @"ic_close";
        _textField.leftImageName = @"ic_serach_up";
        _textField.layer.borderColor = [UIColor whiteColor].CGColor;
        _textField.layer.borderWidth = 0.5f;
        _textField.layer.cornerRadius = 5.0f;
        _textField.layer.masksToBounds = YES;
    }
    return _textField;
}


@end
