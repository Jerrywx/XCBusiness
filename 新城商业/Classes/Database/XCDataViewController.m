//
//  XCDataViewController.m
//  新城商业
//
//  Created by 王潇 on 16/4/25.
//  Copyright © 2016年 王潇. All rights reserved.
//

#import "XCDataViewController.h"

@interface XCDataViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView			*tableView;
@property (nonatomic, strong) UICollectionView		*collectionView;
@end

@implementation XCDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
	[self setupView];
}

- (void)setupView {
	// 1. 基础设置
	self.tableLabel.text		= @"《数据库》节目";
	self.collectionLabel.text	= @"数据库";
	self.view.backgroundColor	= [UIColor grayColor];
	
	// 2. tableView
	self.tableView = ({
		UITableView *tableView	= [[UITableView alloc] initWithFrame:CGRectMake(0, 0, XCTLIN_X, SCREEN_H) style:UITableViewStyleGrouped];
		tableView.delegate		= self;
		tableView.dataSource	= self;
		[self.view addSubview:tableView];
		tableView;
	});
}

#pragma mark - UItableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 15;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	// 1. 创建 cell
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tableCell"];
	if (!cell) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"tableCell"];
	}
	
	// 2. 设置 cell
	cell.textLabel.text = @"cell - A";
	
	// 3. 返回 cell
	return cell;
}

#pragma mark - UITableViewDelegaet
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
