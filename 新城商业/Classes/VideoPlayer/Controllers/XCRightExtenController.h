//
//  XCRightExtenController.h
//  新城商业
//
//  Created by 王潇 on 16/7/7.
//  Copyright © 2016年 王潇. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XCRightVideo;
@protocol XCRightExtenControllerDelegate <NSObject>
@optional
/**
 *  点击项目
 *
 *  @param index <#index description#>
 */
- (void)itemDidSelectedModel:(XCRightVideo *)model;

@end

@interface XCRightExtenController : UIViewController

@property (nonatomic, weak) id<XCRightExtenControllerDelegate> delegate;

/**
 *  加载数据
 */
- (void)loadData;

@end
