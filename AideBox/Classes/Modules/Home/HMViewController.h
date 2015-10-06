//
//  HMViewController.h
//  AideBox
//
//  Created by 方海龙 on 15/9/28.
//  Copyright (c) 2015年 方海龙. All rights reserved.
//  首页controller

#import "HLViewController.h"
#import "HLImageDownloadManager.h"
#import "HMRecommItemView.h"
#import <StoreKit/StoreKit.h>
#import "HMTableHeader.h"
#import "LGRefreshView.h"

@interface HMViewController : HLViewController<UITableViewDataSource, UITableViewDelegate, ImageDownloadDelegate, HMRecommItemDelegate, SKStoreProductViewControllerDelegate, HMHeaderDelegate, LGRefreshViewDelegate>

@end
