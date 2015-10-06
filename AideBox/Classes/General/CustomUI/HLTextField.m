//
//  HLTextField.m
//  AideBox
//
//  Created by 方海龙 on 15/10/4.
//  Copyright (c) 2015年 方海龙. All rights reserved.
//

#import "HLTextField.h"

@interface HLTextField()

@property (nonatomic, strong) UITextField *textField;

@property (nonatomic, strong) UIImageView *leftImageView;

@property (nonatomic, strong) UIButton *closeButton;

@end

@implementation HLTextField


#pragma mark -------------------以下是页面初始化部分--------------------

-(void)closeButtonTouchHandler:(id)sender{
    self.textField.text = @"";
    [self.closeButton removeFromSuperview];
    [self sendActionsForControlEvents:UIControlEventEditingChanged];
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if(self.textField.text.length > 0){
        [self addSubview:self.closeButton];
    }else{
        [self.closeButton removeFromSuperview];
    }
    return YES;
}

-(instancetype)init{
    self = [super init];
    if (self) {
        [self initSubviews];
    }
    return self;
}

-(void)initSubviews{
    [self addSubview:self.textField];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.leftImageView.size = self.leftImageView.image.size;
    self.leftImageView.y = (self.height - self.leftImageView.height) * 0.5f;
    self.leftImageView.x = kAppGap;
    
    
    self.closeButton.size = self.closeButton.imageView.image.size;
    self.closeButton.x = self.width - kAppGap - self.closeButton.width;
    self.closeButton.y = (self.height - self.closeButton.height) * 0.5f;
    
    CGFloat contentWidth = self.closeButton.x - self.leftImageView.x - self.leftImageView.width - kAppGap;
    self.textField.width = contentWidth;
    self.textField.height = self.height;
    self.textField.x = self.leftImageView.x + self.leftImageView.width + kAppGap;
}

-(void)dealloc{
    _textColor = nil;
    _textField = nil;
    _placeholder = nil;
    _rightImageName = nil;
    _leftImageName = nil;
    _leftImageView = nil;
    _closeButton = nil;
}

-(void)setRightImageName:(NSString *)aName{
    _rightImageName = aName;
    if(_rightImageName.length == 0){
        return;
    }
    
    UIImage *aImage = [UIImage imageNamed:_rightImageName];
    if(aImage){
        self.closeButton = [[UIButton alloc] init];
        [_closeButton setImage:aImage forState:UIControlStateNormal];
        [_closeButton setImage:aImage forState:UIControlStateHighlighted];
        [_closeButton addTarget:self action:@selector(closeButtonTouchHandler:) forControlEvents:UIControlEventTouchUpInside];
    }else{
        [_closeButton removeFromSuperview];
    }
}

-(void)setLeftImageName:(NSString *)aName{
    _leftImageName = aName;
    if(_leftImageName.length == 0){
        return;
    }
    UIImage *aImage = [UIImage imageNamed:_leftImageName];
    if(aImage){
        self.leftImageView.image = aImage;
        [self addSubview:self.leftImageView];
    }else{
        [_leftImageView removeFromSuperview];
    }
}

-(void)setTextColor:(UIColor *)aColor{
    _textColor = aColor;
    _textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:@{NSForegroundColorAttributeName:_textColor}];
    _textField.textColor = _textColor;
}

-(void)setFontSize:(CGFloat)aSize{
    _fontSize = aSize;
    self.textField.font = [UIFont systemFontOfSize:_fontSize];
}

- (UITextField *)textField
{
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        _textField.delegate = self;
    }
    return _textField;
}


- (UIImageView *)leftImageView
{
    if (!_leftImageView) {
        _leftImageView = [[UIImageView alloc] init];
    }
    return _leftImageView;
}

-(BOOL)becomeFirstResponder{
    return [self.textField becomeFirstResponder];
}

-(BOOL)resignFirstResponder{
    return [self.textField resignFirstResponder];
}

@end

