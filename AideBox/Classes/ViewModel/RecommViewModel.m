//
//  RecommViewModel.m
//  AideBox
//
//  Created by 方海龙 on 15/10/4.
//  Copyright (c) 2015年 方海龙. All rights reserved.
//

#import "RecommViewModel.h"

@implementation RecommViewModel

- (NSString *)title
{
    return self.model.title;
}

-(NSString *)icon{
    return self.model.icon;
}

-(NSString *)size{
    return self.model.size;
}

-(NSString *)url{
    return self.model.url;
}

-(NSString *)downCount{
    NSString *aCount = [NSString stringWithFormat:@"下载次数: %@次", self.model.downCount];
    return aCount;
}

-(NSString *)recommDesc{
    return self.model.recommDesc;
}

-(NSString *)category{
    return self.model.category;
}

-(NSString *)appid{
    NSString *appidString = [NSString stringWithFormat:@"%@", self.model.appid];
    return appidString;
}

-(void)dealloc{
    _model = nil;
}

@end
