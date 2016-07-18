//
//  XCBottomNewCell.h
//  新城商业
//
//  Created by 王潇 on 16/7/7.
//  Copyright © 2016年 王潇. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XCBottonNews;
@class XCRightVideo;
@interface XCBottomNewCell : UITableViewCell

/**
 *  模型
 */
@property (nonatomic, strong) XCBottonNews	*model;


@property (nonatomic, strong) XCRightVideo	*videoModel;

@end
