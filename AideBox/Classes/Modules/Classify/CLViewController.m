//
//  CLViewController.m
//  AideBox
//
//  Created by 方海龙 on 15/9/28.
//  Copyright (c) 2015年 方海龙. All rights reserved.
//

#import "CLViewController.h"

@interface CLViewController ()

@end

@implementation CLViewController


#pragma mark -------------------以下为页面交互部分--------------------


#pragma mark -------------------以下为请求数据部分--------------------



#pragma mark -------------------以下为请求返回部分--------------------



#pragma mark -------------------以下是进度显示部分--------------------



#pragma mark -------------------以下是页面跳转部分--------------------



#pragma mark -------------------以下是页面初始化部分--------------------

-(void)initSubviews{
    [super initSubviews];
}


#pragma mark -------------------以下是页面布局部分--------------------

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
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
    self.view.backgroundColor = [[UIColor blueColor] colorWithAlphaComponent:0.5f];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}


#pragma mark -------------------以下为Getters And Setters部分--------------------


@end
