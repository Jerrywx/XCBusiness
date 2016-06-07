//
//  XCTabBarController.m
//  新城商业
//
//  Created by 王潇 on 16/4/24.
//  Copyright © 2016年 王潇. All rights reserved.
//

#import "XCTabBarController.h"

@interface XCTabBarController ()

@end

@implementation XCTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	[self setupView];
	[self addChildViewControllers];
}

- (void)setupView {
	self.view.backgroundColor = [UIColor grayColor];
	self.tabBar.hidden = YES;
}

- (void)addChildViewControllers {
	[self addChildController:[[XCBussViewController alloc] init]];			//
	[self addChildController:[[XCInveViewController alloc] init]];			//
	[self addChildController:[[XCInduViewController alloc] init]];			//
	[self addChildController:[[XCDataViewController alloc] init]];			//
}

- (void)addChildController:(UIViewController *)subVC {
	UINavigationController *subNav = [[UINavigationController alloc] initWithRootViewController:subVC];
	subNav.title = @"AAAA";
	[self addChildViewController:subNav];
}

@end
