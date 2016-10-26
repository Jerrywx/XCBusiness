//
//  Header.h
//  新城商业
//
//  Created by 王潇 on 16/4/24.
//  Copyright © 2016年 王潇. All rights reserved.
//

#ifndef Header_h
#define Header_h

// 头文件
#import "XCTabBarController.h"													// 程序 根控制器
#import "XCBaseViewController.h"												// 程序 基控制器

// 网络接口 PAI
#import "XCResponse.h"
#import "XCNetWorkManager.h"
#import "XCURLConstantString.h"

// 自定义: TabBar、LeftBar
#import "XCTabBarControl.h"
#import "XCLeftBarControl.h"

// 播放器界面
#import "XCPlayerViewController.h"
#import "XCNewsViewController.h"

// 频道详情
#import "XCChannelViewController.h"

// 程序四大模块控制器 (新城商业、投资界、行业矩阵、数据库)
#import "XCBussViewController.h"
#import "XCInveViewController.h"
#import "XCInduViewController.h"
#import "XCDataViewController.h"

// 新城商业 模块 代理对象
#import "XCBussDelegate.h"
#import "XCBussVideoModel.h"
#import "XCBussNewsModel.h"

#import "XCLeftBarModel.h"

// 第三方框架
#import <Masonry.h>
#import <MJRefresh.h>
#import <MJExtension.h>
#import <AFNetworking.h>
#import <HMSegmentedControl.h>
#import <UIImageView+WebCache.h>

// 新城商业
#import "XCBussTableViewCell.h"
#import "XCBussCollectionViewCell.h"

// 测试头文件
#import "XCTestViewController.h"

#endif /* Header_h */
