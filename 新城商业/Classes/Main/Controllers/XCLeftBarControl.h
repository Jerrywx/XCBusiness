//
//  XCLeftBarControl.h
//  新城商业
//
//  Created by 王潇 on 16/5/6.
//  Copyright © 2016年 王潇. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XCLeftBarControlDelegate <NSObject>
@optional
/**
 *  侧滑栏 点击回调
 *
 *  @param index 索引
 *  @param model 模型
 */
- (void)leftBarCellDidSelected:(NSIndexPath *)index model:(id)model;

@end


@interface XCLeftBarControl : UIControl

/**
 *  代理对象
 */
@property (nonatomic, weak) id<XCLeftBarControlDelegate> delegate;

/**
 *  数据源
 */
@property (nonatomic, strong) NSArray *channels;

/**
 *  创建侧滑列表单粒
 *
 *  @return 返回侧滑列表
 */
+ (instancetype)sharedLeftBarControl;

/**
 *  显示 LeftBarControl
 */
- (void)leftBarControlAppear;

/**
 *  隐藏 LeftBarControl
 */
- (void)leftBarControlDisAppear;

@end
