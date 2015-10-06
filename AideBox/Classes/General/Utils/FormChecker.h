//
//  FormChecker.h
//  AideBox
//
//  Created by 方海龙 on 15/9/28.
//  Copyright (c) 2015年 方海龙. All rights reserved.
//  表单验证器

#import <Foundation/Foundation.h>

@interface FormChecker : NSObject

/**
 *  验证密码，如果返回nil则验证通过，否则返回错误信息
 *
 *  @param aPassword 密码
 *
 *  @return 返回值
 */
+(NSString *)checkPassword:(NSString *)aPassword;

+ (NSString *)checkMobile:(NSString *)aMobile;

+(NSString *)checkVerifyCode:(NSString *)verifyCode;

@end
