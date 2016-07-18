//
//  XCSubChannelController.m
//  新城商业
//
//  Created by 王潇 on 16/7/14.
//  Copyright © 2016年 王潇. All rights reserved.
//

#import "XCSubChannelController.h"
#import "XCBussNewsModel.h"
#import "XCChannelLog.h"

@interface XCSubChannelController () <UITableViewDelegate, UITableViewDataSource,
									UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UITableView			*tableView;
@property (nonatomic, strong) UICollectionView		*collectionView;
@property (nonatomic, strong) UIView				*lineView;

@property (nonatomic, strong) UICollectionViewFlowLayout	*layout;			// 布局
@property (nonatomic, strong) NSMutableArray				*newsModels;		// 新闻模型 (右侧)
@property (nonatomic, strong) NSMutableArray				*logModels;			// 目录模型 (左侧)

@end

@implementation XCSubChannelController

- (void)viewDidLoad {
    [super viewDidLoad];
	[self setupView];
}

/// SetUp UI
- (void)setupView {
	
	// 1.
	self.view.backgroundColor = [UIColor whiteColor];
	
	// 2.
	self.tableView = ({
		UITableView *tableView	= [[UITableView alloc] initWithFrame:CGRectMake(0, 0, XCTLIN_X, SCREEN_H - 44)
															   style:UITableViewStylePlain];
		tableView.delegate		= self;
		tableView.dataSource	= self;
		tableView.rowHeight		= TABLECELL_H;
		[tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"channelCell"];
		[self.view addSubview:tableView];
		tableView;
	});
	
	// 3.
	self.collectionView = ({
		UICollectionView *collection = [[UICollectionView alloc] initWithFrame:CGRectMake(XCTLIN_X, 0, SCREEN_W - XCTLIN_X, SCREEN_H - 44)
														  collectionViewLayout:self.layout];
		collection.delegate			 = self;
		collection.dataSource		 = self;
		collection.backgroundColor	 = [UIColor whiteColor];
		[collection registerClass:[XCBussCollectionViewCell class] forCellWithReuseIdentifier:@"channelIetm"];
		[self.view addSubview:collection];
		collection;
	});
	
	// 4. 分割线
	self.lineView = ({
		UIView *view = [[UIView alloc] initWithFrame:CGRectMake(XCTLIN_X - 1, 0, 1, SCREEN_H - 44)];
		view.backgroundColor = [UIColor blackColor];
		[self.view addSubview:view];
		view;
	});
	
}
/// Load Data
- (void)loadData {
	
	// 1. 新闻数据是否加载过
	if (self.newsModels.count != 0) return;
	
	// 2. 加载新闻数据
	[XCBussNewsModel loadChannel:nil success:^(NSMutableArray *models) {
		self.newsModels = models;
		[self.collectionView reloadData];
	} failure:^(NSURLSessionDataTask *task, NSError *error) {
	}];
	
	// 3. 目录数据是否加载过
	if (self.logModels.count != 0) return;
	
	// 4. 加载目录数据
	[XCChannelLog loadData];
}

#pragma mark - UIViewController Methond
- (void)viewWillAppear:(BOOL)animated {
	NSLog(@"======AAAAA");
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 11;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"channelCell"];
	cell.textLabel.text   = @"channelCell";
	
	return cell;
}

#pragma mark - UItableViewDelagte
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
	return self.newsModels.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	
	XCBussCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"channelIetm"
																		   forIndexPath:indexPath];
	cell.model = self.newsModels[indexPath.row];
//	cell.backgroundColor  = [UIColor colorWithHue:( arc4random() % 256 / 256.0 )
//									   saturation:( arc4random() % 256 / 256.0 )
//									   brightness:( arc4random() % 256 / 256.0 ) alpha:1];
	
	return cell;
}

#pragma mark - Lazy Loading
- (UICollectionViewFlowLayout *)layout {
	
	if (_layout) {
		return _layout;
	}
	
	CGFloat itemW = (SCREEN_W - XCTLIN_X - 30) * 0.5;
	CGFloat itemH = (11 / 14.0) * itemW;
	
	_layout							= [[UICollectionViewFlowLayout alloc] init];
	_layout.itemSize				= CGSizeMake(itemW, itemH);
	_layout.sectionInset			= UIEdgeInsetsMake(10, 10, 10, 10);
	_layout.minimumLineSpacing		= 10;
	_layout.minimumInteritemSpacing = 10;

	return _layout;
}

@end










