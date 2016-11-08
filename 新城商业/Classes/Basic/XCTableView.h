//
//  XCTableView.h
//  新城商业
//
//  Created by 王潇 on 16/11/8.
//  Copyright © 2016年 王潇. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
	XCTableViewNormal,
	XCTableViewError,
	XCTableViewNoData,
} XCTableViewType;


@interface XCTableView : UITableView

/// 当前类型
@property (nonatomic, assign) XCTableViewType type;

@end
