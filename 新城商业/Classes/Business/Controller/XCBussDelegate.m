//
//  XCBussDelegate.m
//  新城商业
//
//  Created by 王潇 on 16/6/7.
//  Copyright © 2016年 王潇. All rights reserved.
//

#import "XCBussDelegate.h"

@interface XCBussDelegate () 

@end

@implementation XCBussDelegate

#pragma mark - UItableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	if (self.videoModels.count == 0) {
		return 8;
	}
	return self.videoModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	// 1. 创建 cell
	XCBussTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tableCell"];
	if (!cell) {
		cell = [[XCBussTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"tableCell"];
	}
	
	// 2. 设置 cell
	cell.backgroundColor = [UIColor colorWithRed:0.25f green:0.24f blue:0.29f alpha:1.00f];
	if (self.videoModels.count > 0) {
		cell.model = self.videoModels[indexPath.row];
	}
	
	// 3. 返回 cell
	return cell;
}

#pragma mark - UITableViewDelegaet
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	XCBussVideoModel *model = self.videoModels[indexPath.row];
	XCPlayerViewController *playerVC = [[XCPlayerViewController alloc] init];
	playerVC.model = model;
	[self.owner.navigationController pushViewController:playerVC animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return TABLECELL_H;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
	return 0.1;
}

#pragma mark - UICollectipnViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
	
	if (self.newsModels.count == 0) {
		return 8;
	}
	return self.newsModels.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	
	XCBussCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collection" forIndexPath:indexPath];
	if (self.newsModels.count > 0) {
		cell.model = self.newsModels[indexPath.row];
		[cell clearColor];
	} else {
		[cell setColor];
	}
	
	return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
	
	XCBussNewsModel *model = self.newsModels[indexPath.row];
	
	NSInteger type = [model.nvg_t integerValue];
	
	switch (type) {
		case 1: {
			XCNewsViewController *newVC = [[XCNewsViewController alloc] init];
			newVC.model = model;
			[self.owner.navigationController pushViewController:newVC animated:YES];
		}
			break;
		case 2: {
			XCPlayerViewController *playerVC = [[XCPlayerViewController alloc] init];
			playerVC.newsModel = model;
			[self.owner.navigationController pushViewController:playerVC animated:YES];
		}
			break;
		case 3:{
			
		}
			break;
			
		default:
			break;
	}
	
	
}

- (NSString *)getVideoUrl:(NSString *)html {
	
	return nil;
}

@end
