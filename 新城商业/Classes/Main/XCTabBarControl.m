//
//  XCTabBarControl.m
//  新城商业
//
//  Created by 王潇 on 16/4/27.
//  Copyright © 2016年 王潇. All rights reserved.
//

#import "XCTabBarControl.h"


@interface XCTabBarControl ()
@property (nonatomic, strong) UIView		*controlView;
@property (nonatomic, strong) UIView		*line1;
@property (nonatomic, strong) UIView		*line2;
@end


@implementation XCTabBarControl

+ (instancetype)sharedTabBarControl {
	static XCTabBarControl *instance;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		instance = [[XCTabBarControl alloc] init];
	});
	return instance;
}

- (instancetype)init {
	if (self = [super initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H)]) {
	
		// 1. 设置背景色
		self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
		self.controlView = ({
			UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, -XCTABB_H, SCREEN_W, XCTABB_H)];
			view.backgroundColor = [UIColor blackColor];
			[self addSubview:view];
			view;
		});
		
		// 2. Icon 分割线
		self.line1 = ({
			UIView *view = [[UIView alloc] initWithFrame:CGRectMake(XCTLIN_X, 10, 1.5, XCTABB_H - 20)];
			view.backgroundColor = [UIColor whiteColor];
			[self.controlView addSubview:view];
			view;
		});
		
		// 3. 标题分割线
		for (int i = 1; i < 5; i++) {
			UIView *line = [[UIView alloc] initWithFrame:CGRectMake(XCTLIN_X + i * XCTABB_H, 30, 1.4, 20)];
			line.backgroundColor = [UIColor whiteColor];
			[self.controlView addSubview:line];
		}
		
		// 4. 添加标题按钮
		NSArray *titles = @[@"新城商业", @"创投界", @"行业矩阵", @"数据库"];
		for (int i = 0; i < 4; i++) {
			UIButton *btn	= [[UIButton alloc] initWithFrame:CGRectMake(XCTLIN_X + i * XCTABB_H, 30, 80, 20)];
			btn.tag			= i;
			btn.contentMode	= UIViewContentModeCenter;
			btn.titleLabel.font = [UIFont systemFontOfSize:14];
			[btn setTitle:titles[i] forState:UIControlStateNormal];
			[btn addTarget:self action:@selector(selectedController:) forControlEvents:UIControlEventTouchUpInside];
			[self.controlView addSubview:btn];
		}
	}
	return self;
}

- (void)tabBarControlAppear {
	// 1. 添加 tabBar
	UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
	[keyWindow addSubview:self];
	
	// 2. 计算 frame
	CGRect frame = self.controlView.frame;
	frame.origin.y = 0;
	
	// 3. 设置动画
	[UIView animateWithDuration:0.5 animations:^{
		self.controlView.frame = frame;
		self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
	}];
}

- (void)tabBarControlDisAppear {
	
	// 1. 计算 frame
	CGRect frame = self.controlView.frame;
	frame.origin.y = - XCTABB_H;
	
	// 2. 设施动画
	[UIView animateWithDuration:0.5 animations:^{
		self.controlView.frame = frame;
		self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
	} completion:^(BOOL finished) {
		// 3. 移除 view
		[self removeFromSuperview];
	}];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
	[self tabBarControlDisAppear];
}

- (void)selectedController:(UIButton *)button {
	[self tabBarControlDisAppear];
	
	if ([self.delegate respondsToSelector:@selector(tabBarControllerDidSelected:)]) {
		[self.delegate tabBarControllerDidSelected:button.tag];
	}
}

@end
