//
//  JRProgressHUD.m
//  MBProgress-Demo
//
//  Created by 王潇 on 16/10/25.
//  Copyright © 2016年 王潇. All rights reserved.
//

#import "JRProgressHUD.h"
#import <MBProgressHUD.h>

@implementation JRProgressHUD

#pragma mark - 普通Loading
/// 开始Loading
+ (MBProgressHUD *)showHUDAddedTo:(UIView *)view {
	return [JRProgressHUD showHUDAddedTo:view
								animated:YES
								 hideAll:YES];
}

+ (MBProgressHUD *)showHUDAddedTo:(UIView *)view animated:(BOOL)animated {
	return [JRProgressHUD showHUDAddedTo:view 
								animated:animated 
								 hideAll:YES];
}

+ (MBProgressHUD *)showHUDAddedTo:(UIView *)view animated:(BOOL)animated hideAll:(BOOL)hide {
	if (hide) [self hideHUDForView:view];
	MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view 
											  animated:animated];
	hud.userInteractionEnabled = NO;
	return hud;
}

#pragma mark - 停止 Loading
/// 停止 Loading
+ (void)hideHUDForView:(UIView *)view {
	[self hideHUDForView:view animated:YES];
}

+ (void)hideHUDForView:(UIView *)view animated:(BOOL)animated {
	[MBProgressHUD hideHUDForView:view
						 animated:animated];
}

#pragma mark - Loading + Label
/// 开始显示
+ (MBProgressHUD *)showHUDAddedTo:(UIView *)view
							title:(NSString *)string {
	
	return [self showHUDAddedTo:view 
						  title:string 
					   animated:YES 
						hideAll:YES];
}

+ (MBProgressHUD *)showHUDAddedTo:(UIView *)view
							title:(NSString *)string
						animated:(BOOL)animated {
	
	return [self showHUDAddedTo:view 
						  title:string 
					   animated:animated 
						hideAll:YES];
}

+ (MBProgressHUD *)showHUDAddedTo:(UIView *)view 
							title:(NSString *)string 
						 animated:(BOOL)animated 
						  hideAll:(BOOL)hide {
	
	if (hide) [self hideHUDForView:view];
	MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view
											  animated:animated];
	hud.userInteractionEnabled = NO;
	hud.label.text = string;
	return hud;
}

#pragma mark - Toast

+ (MBProgressHUD *)showToastTo:(UIView *)view
					   message:(NSString *)message {

	return [JRProgressHUD showToastTo:view 
							  message:message 
							alignment:JRProgressAlignmentCenter 
						   afterDelay:3.f 
							  hideAll:YES];
}

+ (MBProgressHUD *)showToastTo:(UIView *)view
					   message:(NSString *)message
					 alignment:(JRProgressAlignment)alignment {
	
	return [JRProgressHUD showToastTo:view
							  message:message
							alignment:alignment
						   afterDelay:3.f
							  hideAll:YES];
}

+ (MBProgressHUD *)showToastTo:(UIView *)view
					   message:(NSString *)message
					 alignment:(JRProgressAlignment)alignment
					   hideAll:(BOOL)hide {
	
	return [JRProgressHUD showToastTo:view
							  message:message
							alignment:alignment
						   afterDelay:3.f
							  hideAll:hide];
}

+ (MBProgressHUD *)showToastTo:(UIView *)view 
					   message:(NSString *)message 
					 alignment:(JRProgressAlignment)alignment
					afterDelay:(NSTimeInterval)delay
					   hideAll:(BOOL)hide {
	
	if (hide) [self hideHUDForView:view];
	MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view
											  animated:YES];
	
	hud.userInteractionEnabled = NO;
	hud.mode = MBProgressHUDModeText;
	hud.label.text = message;
	
	switch (alignment) {
		case JRProgressAlignmentTop:
			hud.offset = CGPointMake(0.f, -[UIScreen mainScreen].bounds.size.width * 0.5);
			break;
		
		case JRProgressAlignmentCenter:
			break;
		
		case JRProgressAlignmentBottom:
			hud.offset = CGPointMake(0.f, MBProgressMaxOffset);
			break;
			
		default:
			break;
	}
	[hud hideAnimated:YES afterDelay:delay];
	return hud;
}

@end
