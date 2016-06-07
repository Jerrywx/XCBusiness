//
//  XCNetWorkManager.h
//  新城商业
//
//  Created by 王潇 on 16/6/7.
//  Copyright © 2016年 王潇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XCNetWorkManager : NSObject

/**
 *  创建网络管理单粒
 *
 *  @return 返回网络管理单粒
 */
+ (instancetype)shareManager;

@end
