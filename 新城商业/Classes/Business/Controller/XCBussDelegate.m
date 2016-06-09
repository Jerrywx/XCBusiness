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
	cell.model = self.videoModels[indexPath.row];
	
	// 3. 返回 cell
	return cell;
}

#pragma mark - UITableViewDelegaet
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
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
	cell.model = self.newsModels[indexPath.row];
	return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
	NSLog(@"---------- %@", indexPath);
}

@end
