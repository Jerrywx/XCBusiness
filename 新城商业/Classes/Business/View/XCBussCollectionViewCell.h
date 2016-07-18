//
//  XCBussCollectionViewCell.h
//  新城商业
//
//  Created by 王潇 on 16/4/28.
//  Copyright © 2016年 王潇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XCBussCollectionViewCell : UICollectionViewCell

/**
 *  数据模型
 */
@property (nonatomic, strong) XCBussNewsModel	*model;

/**
 *  设置颜色
 */
- (void)setColor;

/**
 *  清除颜色
 */
- (void)clearColor;

@end
