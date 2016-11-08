//
//  JRProgressHUD.h
//  MBProgress-Demo
//
//  Created by 王潇 on 16/10/25.
//  Copyright © 2016年 王潇. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, JRProgressAlignment) {
	JRProgressAlignmentTop		=   0,	///< Top alignment.
	JRProgressAlignmentCenter	=	1,	///< Center alignment.
	JRProgressAlignmentBottom	=	2,	///< Bottom alignment.
};


@class MBProgressHUD;
@interface JRProgressHUD : NSObject

#pragma mark - 普通Loading
/// 菊花
+ (MBProgressHUD *)showHUDAddedTo:(UIView *)view;

+ (MBProgressHUD *)showHUDAddedTo:(UIView *)view animated:(BOOL)animated;

+ (MBProgressHUD *)showHUDAddedTo:(UIView *)view animated:(BOOL)animated hideAll:(BOOL)hide;

/// 停止 Loading
+ (void)hideHUDForView:(UIView *)view;

+ (void)hideHUDForView:(UIView *)view animated:(BOOL)animated;

#pragma mark - Loading + Label
/// 菊花 + Label
+ (MBProgressHUD *)showHUDAddedTo:(UIView *)view
							title:(NSString *)string;

+ (MBProgressHUD *)showHUDAddedTo:(UIView *)view
							title:(NSString *)string
						 animated:(BOOL)animated;

+ (MBProgressHUD *)showHUDAddedTo:(UIView *)view
							title:(NSString *)string
						 animated:(BOOL)animated
						  hideAll:(BOOL)hide;

#pragma mark - Toast
// Toast
+ (MBProgressHUD *)showToastTo:(UIView *)view
					   message:(NSString *)message;

+ (MBProgressHUD *)showToastTo:(UIView *)view
					   message:(NSString *)message
					 alignment:(JRProgressAlignment)alignment;

+ (MBProgressHUD *)showToastTo:(UIView *)view
					   message:(NSString *)message
					 alignment:(JRProgressAlignment)alignment
					afterDelay:(NSTimeInterval)delay;

+ (MBProgressHUD *)showToastTo:(UIView *)view
					   message:(NSString *)message
					 alignment:(JRProgressAlignment)alignment
					afterDelay:(NSTimeInterval)delay
					   hideAll:(BOOL)hide;

@end
