//
//  AppDelegate.m
//  新城商业
//
//  Created by 王潇 on 16/4/24.
//  Copyright © 2016年 王潇. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()
///////
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

	[[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
	[[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
	
	[self setWindow];
	[self loadBaseData];
	return YES;
}

#pragma mark -
- (void)setWindow {
	self.window					= [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
	XCTabBarController *viewVC	= [[XCTabBarController alloc] init];
//	UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:viewVC];
	self.window.rootViewController = viewVC;
	[self.window makeKeyAndVisible];
}
/// 左侧菜单
- (void)loadBaseData {
	[XCLeftBarModel loadModelsuccess:^(NSArray *models) {
		[XCLeftBarControl sharedLeftBarControl].channels = models;
	} failure:^(NSURLSessionDataTask *task, NSError *error) {
	}];
}

#pragma mark -
- (void)applicationWillResignActive:(UIApplication *)application {
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
	// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
	// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
	// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
