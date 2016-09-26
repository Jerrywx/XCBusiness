//
//  XCChannelCell.h
//  新城商业
//
//  Created by 王潇 on 16/7/22.
//  Copyright © 2016年 王潇. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Industry;

@protocol XCChannelCellDelegate <NSObject>
@optional
- (void)openCellDetial:(NSIndexPath *)index isOpen:(BOOL)isOpen;

@end

@interface XCChannelCell : UITableViewCell


/**
 *  索引
 */
@property (nonatomic, assign) NSIndexPath *index;

/**
 *  模型
 */
@property (nonatomic, strong) Industry	*industry;

/**
 *  代理对象
 */
@property (nonatomic, strong) id<XCChannelCellDelegate> delegate;

@end
