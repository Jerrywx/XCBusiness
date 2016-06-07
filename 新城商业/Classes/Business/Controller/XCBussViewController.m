//
//  XCBussViewController.m
//  新城商业
//
//  Created by 王潇 on 16/4/25.
//  Copyright © 2016年 王潇. All rights reserved.
//

#import "XCBussViewController.h"

@interface XCBussViewController () <UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, strong) UITableView					*tableView;
@property (nonatomic, strong) UICollectionView				*collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout	*layout;
@end

@implementation XCBussViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	[self setupView];
}

- (void)setupView {
	// 1. 基础设置
	self.tableLabel.text		= @"《新城商业》节目";
	self.collectionLabel.text	= @"新城商业";
	
	// 2. tableView
	self.tableView = ({
		UITableView *tableView	= [[UITableView alloc] initWithFrame:CGRectMake(0, 44, XCTLIN_X, SCREEN_H - 44) style:UITableViewStyleGrouped];
		tableView.delegate		= self;
		tableView.dataSource	= self;
//		tableView.separatorStyle= UITableViewCellSeparatorStyleNone;
		[self.view addSubview:tableView];
		tableView;
	});
	
	// 3. collectionView
	self.collectionView = ({
		UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(XCTLIN_X, 44, SCREEN_W - XCTLIN_X, SCREEN_H - 44)
															  collectionViewLayout:self.layout];
		collectionView.dataSource	= self;
		collectionView.delegate		= self;
		collectionView.backgroundColor = [UIColor whiteColor];
		[collectionView registerClass:[XCBussCollectionViewCell class] forCellWithReuseIdentifier:@"collection"];
		[self.view addSubview:collectionView];
		collectionView;
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
	XCBussTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tableCell"];
	if (!cell) {
		cell = [[XCBussTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"tableCell"];
	}
	
	// 2. 设置 cell
	cell.backgroundColor = [UIColor colorWithRed:0.25f green:0.24f blue:0.29f alpha:1.00f];
	
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
	return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	
	XCBussCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collection" forIndexPath:indexPath];
	cell.backgroundColor = [UIColor grayColor];
	return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
	NSLog(@"---------- %@", indexPath);
}

#pragma mark -
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
	
	NSLog(@"------------------------ %zd", self.tabBarController.selectedIndex);	
//	XCTestViewController *test = [[XCTestViewController alloc] init];
//	[self.navigationController pushViewController:test animated:YES];
}

#pragma mark - Layzing Loading
- (UICollectionViewFlowLayout *)layout {
	
	if (_layout) {
		return _layout;
	}
	
	CGFloat itemW = (SCREEN_W - XCTLIN_X - 30) * 0.5;
	CGFloat itemH = (11 / 14.0) * itemW;
	
	_layout = [[UICollectionViewFlowLayout alloc] init];
	_layout.minimumLineSpacing = 10;
	_layout.minimumInteritemSpacing = 10;
	_layout.itemSize = CGSizeMake(itemW, itemH);
	_layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
	
	return _layout;
}

@end
