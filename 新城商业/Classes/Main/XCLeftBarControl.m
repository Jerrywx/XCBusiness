//
//  XCLeftBarControl.m
//  新城商业
//
//  Created by 王潇 on 16/5/6.
//  Copyright © 2016年 王潇. All rights reserved.
//

#import "XCLeftBarControl.h"

@interface XCLeftBarControl () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UIView		*bgView;
@property (nonatomic, strong) UITableView	*leftTableView;
@end

@implementation XCLeftBarControl

+ (instancetype)sharedLeftBarControl {
	static XCLeftBarControl *instance;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		instance = [[XCLeftBarControl alloc] init];
	});
	return instance;
}

- (instancetype)init {
	if (self = [super initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H)]) {
		// 1. 创建 背景View
		self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
//		self.bgView = ({
//			UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H)];
//			view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
//			[self addSubview:view];
//			view;
//		});
		// 2. 添加左侧列表
		self.leftTableView = ({
			UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(-XCLEFT_W, 0, XCLEFT_W, SCREEN_H)
																  style:UITableViewStyleGrouped];
			tableView.delegate	   = self;
			tableView.dataSource   = self;
			[self addSubview:tableView];
			tableView;
		});
	}
	return self;
}

- (void)leftBarControlAppear {
	UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
	[keyWindow addSubview:self];
	
	[UIView animateWithDuration:0.4 animations:^{
		self.leftTableView.frame = CGRectMake(0, 0, XCLEFT_W, SCREEN_H);
		self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
	}];
}

- (void)leftBarControlDisAppear {
	[UIView animateWithDuration:0.4 animations:^{
		self.leftTableView.frame = CGRectMake(-XCLEFT_W, 0, XCLEFT_W, SCREEN_H);
		self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.0];
	} completion:^(BOOL finished) {
		[self removeFromSuperview];
	}];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
	[self leftBarControlDisAppear];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"leftCell"];
	if (!cell) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"leftCell"];
	}
	
	cell.textLabel.text = @"text - cell";
	
	return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	// 1. 关闭侧滑栏
	[self leftBarControlDisAppear];
	
	// 2. 点击回调
	if ([self.delegate respondsToSelector:@selector(leftBarCellDidSelected:model:)]) {
		[self.delegate leftBarCellDidSelected:indexPath model:nil];
	}
}

@end
