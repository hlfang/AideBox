//
//  AppEnum.h
//  AideBox
//
//  Created by 方海龙 on 15/9/27.
//  Copyright (c) 2015年 方海龙. All rights reserved.
//

#ifndef AideBox_AppEnum_h
#define AideBox_AppEnum_h

typedef NS_ENUM(NSUInteger, HTTRequestMethod){
    HTTRequestGET = 1,
    HTTRequestPOST = 2
};

typedef NS_ENUM(NSUInteger, HTTPRequestType){
    HTTPRequestSynchronous = 1,
    HTTPRequestAsynchronous = 2
};

/**
 *  栏目枚举
 */
typedef NS_ENUM(NSUInteger, ChannelType){
    /**
     *  排行
     */
    ChannelRanking = 1,
    /**
     *  必备
     */
    ChannelMust = 2,
    /**
     *  H5游戏
     */
    ChannelHTML5 = 3,
    /**
     *  限时免费
     */
    ChannelTimeFree = 4
};


#endif
