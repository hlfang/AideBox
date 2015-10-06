//
//  HLTextField.h
//  AideBox
//
//  Created by 方海龙 on 15/10/4.
//  Copyright (c) 2015年 方海龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HLTextField : UIControl<UITextFieldDelegate>

@property (nonatomic, strong) NSString *rightImageName;

@property (nonatomic, strong) NSString *leftImageName;

@property (nonatomic, strong) UIColor *textColor;

@property (nonatomic, assign) CGFloat fontSize;

@property (nonatomic, strong) NSString *placeholder;

@end
