//
//  AppMacro.h
//  AideBox
//
//  Created by 方海龙 on 15/9/27.
//  Copyright (c) 2015年 方海龙. All rights reserved.
//

#ifndef AideBox_AppMacro_h
#define AideBox_AppMacro_h

#define RGBACOLOR(R,G,B,A) [UIColor colorWithRed:(R)/255.0f green:(G)/255.0f blue:(B)/255.0f alpha:(A)]

#define appKeyWindow [[UIApplication sharedApplication] keyWindow]

#define ObjLog(args) NSLog(@"%@", args)
#define RectLog(args) NSLog(@"%@", NSStringFromCGRect(args))
#define SizeLog(args) NSLog(@"%@", NSStringFromCGSize(args))
#define PointLog(args) NSLog(@"%@", NSStringFromCGPoint(args))

#define ab_global_queue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)

#define statuBarHeight [UIApplication sharedApplication].statusBarFrame.size.height

/**
 *  通用背景颜色
 */
#define appBackgroundColor [UIColor colorWithRed:77.0f/255.0f green:77.0f/255.0f blue:77.0f/255.0f alpha:1.0f]
/**
 *  特殊背景颜色
 */
#define color_special_background [UIColor colorWithRed:246.0f/255.0f green:246.0f/255.0f blue:246.0f/255.0f alpha:1.0f]

/**
 *  导航栏背景颜色
 */
#define appNavigationBarBackgroundColor  RGBACOLOR(0.0f, 0.0f, 0.0f, 0.8f)

/**
 *  底部栏背景颜色
 */
#define appBottomBarBackgroundColor RGBACOLOR(0.0f, 0.0f, 0.0f, 0.8f)

#define appTabBarNormalBackgroundColor RGBACOLOR(77.0f, 77.0f, 77.0f, 1.0f)
#define appTabBarSelectedBackgroundColor RGBACOLOR(33.0f, 33.0f, 33.0f, 0.6f)

/**
 *  通用按钮颜色
 */
#define color_general_btn_normal [UIColor colorWithRed:225.0f/255.0f green:125.0f/255.0f blue:125.0f/255.0f alpha:1.0f]
#define color_general_btn_highlight [UIColor colorWithRed:255.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f]
#define color_general_btn_disable [UIColor colorWithRed:225.0f/255.0f green:125.0f/255.0f blue:125.0f/255.0f alpha:1.0f]
/**
 *  特殊按钮颜色
 */
#define color_special_btn_normal [UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f]
#define color_special_btn_highlight [UIColor colorWithRed:227.0f/255.0f green:227.0f/255.0f blue:227.0f/255.0f alpha:1.0f]
#define color_special_btn_disable [UIColor colorWithRed:227.0f/255.0f green:227.0f/255.0f blue:227.0f/255.0f alpha:1.0f]
#define color_borderColor_background [UIColor colorWithRed:175.0f/255.0f green:175.0f/255.0f blue:175.0f/255.0f alpha:1.0f]

/**
 *  透明色
 */
#define color_clear [UIColor clearColor]

/**
 *  分割线颜色
 */
#define color_spear_line [UIColor colorWithRed:239.0f/255.0f green:239.0f/255.0f blue:244.0f/255.0f alpha:0.8f]

#define color_tabBar_under_line [UIColor colorWithRed:255.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:0.8f]

/**
 *字体颜色
 */
#define color_font_white [UIColor colorWithHexString:@"0xefefef"]
#define color_font_gray [UIColor colorWithHexString:@"0x848484"]
#define color_font_black [UIColor colorWithHexString:@"0x595757"]
#define color_font_red [UIColor colorWithHexString:@"0xfc0202"]
#define color_font_blue [UIColor colorWithHexString:@"0x0480fe"]
#define color_font_bottom [UIColor colorWithHexString:@"0xdfb2f1"]
#define color_font_special [UIColor colorWithHexString:@"0xff6b00"]
#define color_font_LightGray [UIColor colorWithHexString:@"0xcccccc"]
#define color_border_gray [UIColor colorWithHexString:@"0xafafaf"]
#define color_font_navbar [UIColor colorWithHexString:@"0xefefef"]

/**
 *  字体大小
 */
#define size_font_tabbar 13.0f
/**
 *  导航栏字体大小
 *
 */
#define size_font_navBar_title 20.0f

/**
 *  导航栏左右两侧字体大小
 */
#define size_font_navBar_subTitle 18.0f

/**
 *  展位图片
 */
#define img_place_quare [UIImage imageNamed:@"placeholder_quare"]
#define img_place_rectangle [UIImage imageNamed:@"placeholder_rectangle"]

/**
 *  返回按钮图片
 */
#define ic_back_normal [UIImage imageNamed:@"ic_back_up"]
#define ic_back_highlight [UIImage imageNamed:@"ic_back_down"]

/**
 *  搜索按钮图片
 */
#define ic_search_normal [UIImage imageNamed:@"ic_serach_up"]
#define ic_search_highlight [UIImage imageNamed:@"ic_serach_down"]

/**
 *  首页tabBar图片
 */
#define ic_home_normal [UIImage imageNamed:@"icn_4"]
#define ic_home_highlight [UIImage imageNamed:@"icn_4"]
/**
 *  游戏tabBar图片
 */
#define ic_game_normal [UIImage imageNamed:@"icn_4"]
#define ic_game_highlight [UIImage imageNamed:@"icn_4"]
/**
 *  分类tabBar图片
 */
#define ic_classify_normal [UIImage imageNamed:@"icn_4"]
#define ic_classify_highlight [UIImage imageNamed:@"icn_4"]
/**
 *  发烧tabBar图片
 */
#define ic_launcher_normal [UIImage imageNamed:@"icn_4"]
#define ic_launcher_highlight [UIImage imageNamed:@"icn_4"]
/**
 *  我的tabBar图片
 */
#define ic_account_normal [UIImage imageNamed:@"icn_4"]
#define ic_account_highlight [UIImage imageNamed:@"icn_4"]




#endif
