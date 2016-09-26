//
//  XCInduViewController.m
//  新城商业
//
//  Created by 王潇 on 16/4/25.
//  Copyright © 2016年 王潇. All rights reserved.
//

#import "XCInduViewController.h"

#define LOGTAB_W (120)

@interface XCInduViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView		*logTableView;
@property (nonatomic, strong) UITableView		*contentTableView;
@end

@implementation XCInduViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	[self setupView];
}

- (void)setupView {
	
	// 1.
	self.view.backgroundColor = [UIColor greenColor];
	[self hiddenAllNav];
	
	// 2.
	self.logTableView  = ({
		UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, LOGTAB_W, SCREEN_H)
															  style:UITableViewStylePlain];
		tableView.delegate		= self;
		tableView.dataSource	= self;
		[tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
		[self.view addSubview:tableView];
		tableView;
	});
	
	// 3.
	self.contentTableView = ({
		UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(LOGTAB_W, NAVBAR_H, SCREEN_W - LOGTAB_W, SCREEN_H)
															  style:UITableViewStyleGrouped];
		tableView.delegate		= self;
		tableView.dataSource	= self;
		[tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
		[self.view addSubview:tableView];
		tableView;
	});
}


#pragma mark -
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
	cell.textLabel.text = @"cccc";
	
	return cell;
}

#pragma mark -
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
	return [UIButton buttonWithType:UIButtonTypeContactAdd];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	return @"AAAA";
}



@end






















