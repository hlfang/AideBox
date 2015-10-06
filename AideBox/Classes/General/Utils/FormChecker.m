//
//  FormChecker.m
//  AideBox
//
//  Created by 方海龙 on 15/9/28.
//  Copyright (c) 2015年 方海龙. All rights reserved.
//

#import "FormChecker.h"

@implementation FormChecker

+ (NSString *)checkPassword:(NSString *)aPassword
{
    if (aPassword.length == 0) {
        return @"请输入密码";
    }
    if ( aPassword.length < 6 | aPassword.length > 16) {
        return @"密码长度应在6-16位，且不能含汉字或空格";
    }
    return  nil;
}

+ (NSString *)checkMobile:(NSString *)aMobile
{
    if (aMobile.length == 0)
    {
        return @"手机号不能为空";
    }else if (aMobile.length != 11)
    {
        return @"手机号长度只能是11位";
    }else{
        /**
         * 移动号段正则表达式
         */
        NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
        /**
         * 联通号段正则表达式
         */
        NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
        /**
         * 电信号段正则表达式
         */
        NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
        BOOL isMatch1 = [pred1 evaluateWithObject:aMobile];
        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
        BOOL isMatch2 = [pred2 evaluateWithObject:aMobile];
        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
        BOOL isMatch3 = [pred3 evaluateWithObject:aMobile];
        
        if (isMatch1 || isMatch2 || isMatch3) {
            return nil;
        }else{
            return @"请输入正确的手机号码";
        }
    }
    return nil;
}

+(NSString *)checkVerifyCode:(NSString *)verifyCode{
    if(verifyCode.length == 0){
        return @"请输入验证码";
    }
    if(verifyCode.length != 6){
        return @"请输入正确的验证码";
    }
    
    return nil;
}

@end
