//
//  XCTabBarControl.h
//  新城商业
//
//  Created by 王潇 on 16/4/27.
//  Copyright © 2016年 王潇. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XCTabBarControlDelegate <NSObject>

- (void)tabBarControllerDidSelected:(NSInteger)index;

@end


@interface XCTabBarControl : UIControl

@property (nonatomic, weak) id<XCTabBarControlDelegate> delegate;

/**
 *  创建 tabBarControl 单粒
 *
 *  @return 返回单粒对象
 */
+ (instancetype)sharedTabBarControl;

/**
 *  显示 tabBarControl
 */
- (void)tabBarControlAppear;

/**
 *  隐藏 tabBarControl
 */
- (void)tabBarControlDisAppear;

@end
