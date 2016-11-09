//
//  XCBussDelegate.h
//  新城商业
//
//  Created by 王潇 on 16/6/7.
//  Copyright © 2016年 王潇. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XCBussNewsModel;
@interface XCBussDelegate : NSObject <UITableViewDataSource, UITableViewDelegate,
								UICollectionViewDataSource, UICollectionViewDelegate>

/**
 *  所属控制器
 */
@property (nonatomic, weak) XCBussViewController *owner;

/**
 *  左侧视频列表模型
 */
@property (nonatomic, strong) NSMutableArray<XCBussVideoModel *> *videoModels;

/**
 *  右侧新闻列表
 */
@property (nonatomic, strong) NSArray<XCBussNewsModel *> *newsModels;

@end
