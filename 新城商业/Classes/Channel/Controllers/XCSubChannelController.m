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
#import "XCChannelHeaderView.h"
#import "XCChannelCell.h"

@interface XCSubChannelController () <UITableViewDelegate, UITableViewDataSource,
									UICollectionViewDelegate, UICollectionViewDataSource,
									XCChannelCellDelegate>
@property (nonatomic, strong) UITableView			*tableView;
@property (nonatomic, strong) UICollectionView		*collectionView;
@property (nonatomic, strong) UIView				*lineView;
@property (nonatomic, strong) XCChannelHeaderView	*headerView;


@property (nonatomic, strong) UICollectionViewFlowLayout	*layout;			// 布局
@property (nonatomic, strong) NSMutableArray				*newsModels;		// 新闻模型 (右侧)
@property (nonatomic, strong) NSMutableArray<XCChannelLog*>	*logModels;			// 目录模型 (左侧)
@property (nonatomic, strong) NSMutableArray<NSArray *>		*section;
@property (nonatomic, strong) NSIndexPath					*indexPath;			//

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
		tableView.delegate			= self;
		tableView.dataSource		= self;
//		tableView.rowHeight			= 150;
		tableView.tableHeaderView	= self.headerView;
		[tableView registerClass:[XCChannelCell class] forCellReuseIdentifier:@"channelCell"];
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
	[XCChannelLog loadDataSuccess:^(NSMutableArray *models) {
		self.logModels = models.copy;
		[self.tableView reloadData];
	} failure:^(NSURLSessionDataTask *task, NSError *error) {
		
	}];
}

- (void)setLogModels:(NSMutableArray *)logModels {
	_logModels = logModels;
	
	self.section = [NSMutableArray arrayWithCapacity:logModels.count];
	for (XCChannelLog *model in logModels) {
		
		NSMutableArray *arrayM = [NSMutableArray array];
		for (Industry *stry in model.keywords) {
			[arrayM addObject:stry];
		}
		[self.section addObject:arrayM];
	}
}

#pragma mark - UIViewController Methond
- (void)viewWillAppear:(BOOL)animated {
	NSLog(@"======AAAAA");
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	NSLog(@"=======lll %zd", self.logModels.count);
	return self.section.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	
	return self.section[section].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	XCChannelCell *cell = [tableView dequeueReusableCellWithIdentifier:@"channelCell"];
	Industry *stry	= self.section[indexPath.section][indexPath.row];
	cell.delegate   = self;
	cell.industry	= stry;
	cell.index		= indexPath;
	
	return cell;
}

#pragma mark - UItableViewDelagte
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	if ([self.indexPath isEqual:indexPath]) {
		Industry *stry	= self.section[indexPath.section][indexPath.row];
		CGFloat heigh = 25 + stry.ptpe.count * 25;
		return heigh;
	}
	
	return 25;
}

- (void)openCellDetial:(NSIndexPath *)index isOpen:(BOOL)isOpen{
	
	if (isOpen) {
		self.indexPath = index;
	} else {
		self.indexPath = [NSIndexPath indexPathForRow:1000 inSection:1000];
	}
	
	[self.tableView reloadData];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
	return self.newsModels.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

	XCBussCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"channelIetm"
																		   forIndexPath:indexPath];
	cell.model = self.newsModels[indexPath.row];
	return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	return @"sadsa";
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

- (XCChannelHeaderView *)headerView {
	
	if (_headerView) {
		return _headerView;
	}
	
	_headerView = [[XCChannelHeaderView alloc] initWithFrame:CGRectMake(0, 0, XCTLIN_X, 80)];

	return _headerView;
}

@end










