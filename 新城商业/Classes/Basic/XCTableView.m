//
//  XCTableView.m
//  新城商业
//
//  Created by 王潇 on 16/11/8.
//  Copyright © 2016年 王潇. All rights reserved.
//

#import "XCTableView.h"

@interface XCTableView ()
/// 暂无数据提示
@property (nonatomic, strong) UILabel	*noDataLabel;
/// 网络错误提示
@property (nonatomic, strong) UIButton	*errorDataButton;
@end


@implementation XCTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
	
	self = [super initWithFrame:frame style:style];
	
	[self commonInit];
	
	return self;
}

//// 初始化操作
- (void)commonInit {
	
}

- (void)loadAgain {
	NSLog(@"======== loadAgain");
}

#pragma mark - Setter / Getter Methond
- (void)setType:(XCTableViewType)type {
	_type = type;
	self.scrollEnabled = NO;
	switch (type) {
		case XCTableViewNormal:
			self.scrollEnabled = YES;
			self.backgroundView = nil;
			break;
		case XCTableViewError:
			self.backgroundView = self.errorDataButton;
			break;
		case XCTableViewNoData:
			self.backgroundView = self.noDataLabel;
			break;
		default:
			break;
	}
}

- (UILabel *)noDataLabel {
	
	if (_noDataLabel) {
		return _noDataLabel;
	}
	_noDataLabel = [[UILabel alloc] init];
	_noDataLabel.textColor = [UIColor grayColor];
	_noDataLabel.textAlignment = NSTextAlignmentCenter;
	_noDataLabel.text = @"暂无数据!";
	
	return _noDataLabel;
}

- (UIButton *)errorDataButton {
	
	if (_errorDataButton) {
		return _errorDataButton;
	}
	
	_errorDataButton = [[UIButton alloc] init];
	[_errorDataButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
	[_errorDataButton setTitle:@"网络异常请重试!" forState:UIControlStateNormal];
	[_errorDataButton addTarget:self action:@selector(loadAgain) forControlEvents:UIControlEventTouchUpInside];
	
	return _errorDataButton;
}

@end
