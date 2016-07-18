//
//  XCBaseViewController.m
//  新城商业
//
//  Created by 王潇 on 16/4/24.
//  Copyright © 2016年 王潇. All rights reserved.
//

#import "XCBaseViewController.h"

@interface XCBaseViewController () <XCTabBarControlDelegate, XCLeftBarControlDelegate>

@property (nonatomic, strong) UIButton	*menuBtn;								// tabBar 控制按钮
@property (nonatomic, strong) UIView	*leftView;								// tabBar left View
@property (nonatomic, strong) UIView	*lineView;								// 分割线

@end

@implementation XCBaseViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	
	// 界面设置
	[self initializeView];
}

#pragma mark - Setup View

- (void)initializeView {
	
	[self initView];
	
	[self initNavigationBar];
}

- (void)initView {
	// 1. 背景色
	self.view.backgroundColor = [UIColor whiteColor];
	
	// 2. 隐藏导航控制
	self.navigationController.navigationBarHidden = YES;
	
	// 2. 添加手势
	UISwipeGestureRecognizer *swipeleft = [[UISwipeGestureRecognizer alloc] initWithTarget:self
																					action:@selector(rightAction:)];
	swipeleft.direction = UISwipeGestureRecognizerDirectionRight;
	[self.view addGestureRecognizer:swipeleft];
}

- (void)initNavigationBar {
	
	// 1. tabBar 控制按钮
	self.menuBtn = ({
		UIButton *btn		= [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_W - 70, 10, 60, 30)];
		btn.backgroundColor = [UIColor blueColor];
		[btn addTarget:self action:@selector(menuControl) forControlEvents:UIControlEventTouchUpInside];
		btn;
	});
	
	// 4. create TabBar
	self.myNavigationBar = ({
		UIView *view		 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, NAVBAR_H)];
		view.backgroundColor = [UIColor blackColor];
		[view addSubview:self.menuBtn];
		[self.view addSubview:view];
		view;
	});
	
	// 3. tabBar left View
	self.leftView = ({
		UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, XCTLIN_X, NAVBAR_H)];
		view.backgroundColor = [UIColor redColor];
		[self.myNavigationBar addSubview:view];
		view;
	});
	
	// 4. tabBar tabelView title Label
	self.tableLabel = ({
		UILabel *label	= [[UILabel alloc] initWithFrame:CGRectMake(0, 0, XCTLIN_X - 10, NAVBAR_H)];
		label.text		= @"《新城商业》节目";
		label.font		= [UIFont systemFontOfSize:16];
		label.textColor = [UIColor whiteColor];
		label.textAlignment = NSTextAlignmentRight;
		[self.myNavigationBar addSubview:label];
		label;
	});
	
	// 5. tabBar collection Title Label
	self.collectionLabel = ({
		UILabel *label	= [[UILabel alloc] initWithFrame:CGRectMake(XCTLIN_X, 0, 90, NAVBAR_H)];
		label.text		= @"新城商业";
		label.font		= [UIFont systemFontOfSize:16];
		label.textColor = [UIColor whiteColor];
		label.textAlignment = NSTextAlignmentCenter;
		[self.myNavigationBar addSubview:label];
		label;
	});
	
	// 6. 分割线
	self.lineView = ({
		UIView *view = [[UIView alloc] initWithFrame:CGRectMake(XCTLIN_X + 90, 12, 1.5, 20)];
		view.backgroundColor = [UIColor whiteColor];
		[self.myNavigationBar addSubview:view];
		view;
	});
	
	// 7. tabBar collection Class Label
	self.collectionClass = ({
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(XCTLIN_X + 90, 0, 60, NAVBAR_H)];
		label.text		= @"最新";
		label.font		= [UIFont systemFontOfSize:18];
		label.textColor = [UIColor whiteColor];
		label.textAlignment = NSTextAlignmentCenter;
		[self.myNavigationBar addSubview:label];
		label;
	});
	
}

// 自定义 tabBar 控制
- (void)menuControl {
	[[XCTabBarControl sharedTabBarControl] tabBarControlAppear];
	[XCTabBarControl sharedTabBarControl].delegate = self;
}

#pragma mark - UISwipeGesture Action
- (void)rightAction:(UISwipeGestureRecognizer *)swip {

	[[XCLeftBarControl sharedLeftBarControl] leftBarControlAppear];
	[XCLeftBarControl sharedLeftBarControl].delegate = self;
}

#pragma mark - XCTabBarControlDelegate
- (void)tabBarControllerDidSelected:(NSInteger)index {
	
	self.tabBarController.selectedIndex = index;
}

#pragma mark - XCLeftBarControlDelegate
- (void)leftBarCellDidSelected:(NSIndexPath *)index model:(id)model {
	XCChannelViewController *channel = [[XCChannelViewController alloc] init];
	channel.channels				 = [XCLeftBarControl sharedLeftBarControl].channels;
	channel.backTitle				 = self.collectionLabel.text;
	channel.index					 = index.row;
	[self.navigationController pushViewController:channel animated:YES];
}

@end



