//
//  XCRefreshHeader.m
//  新城商业
//
//  Created by 王潇 on 16/11/8.
//  Copyright © 2016年 王潇. All rights reserved.
//

#import "XCRefreshHeader.h"

@implementation XCRefreshHeader

+ (instancetype)headerWithRefreshingTarget:(id)target refreshingAction:(SEL)action {
	XCRefreshHeader *header = [super headerWithRefreshingTarget:target refreshingAction:action];
	// 设置自动切换透明度(在导航栏下面自动隐藏)
	header.automaticallyChangeAlpha = YES;
	// 隐藏时间
	header.lastUpdatedTimeLabel.hidden = YES;
	return header;
}

@end
