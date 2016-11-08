//
//  XCBussViewController.m
//  新城商业
//
//  Created by 王潇 on 16/4/25.
//  Copyright © 2016年 王潇. All rights reserved.
//

#import "XCBussViewController.h"

@interface XCBussViewController () //<UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, strong) UITableView					*tableView;
@property (nonatomic, strong) UICollectionView				*collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout	*layout;			// 布局
@property (nonatomic, strong) XCBussDelegate				*delegate;			// 代理对象

@property (nonatomic, strong) NSMutableArray<XCBussNewsModel *> *newsModels;	// 右侧新闻数据源
@property (nonatomic, strong) NSMutableArray<XCBussVideoModel *> *videoModels;	// 右侧新闻数据源

@end

@implementation XCBussViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	[self setupView];
	[self setupLoadView];
}

- (void)setupView {
	// 1. 基础设置
	self.tableLabel.text		= @"《新城商业》节目";
	self.collectionLabel.text	= @"新城商业";
	self.delegate = [[XCBussDelegate alloc] init];
	self.delegate.owner = self;
	
	// 2. tableView
	self.tableView = ({
		UITableView *tableView	= [[UITableView alloc] initWithFrame:CGRectMake(0, 44, XCTLIN_X, SCREEN_H - 44)
															   style:UITableViewStyleGrouped];
		tableView.delegate		= self.delegate;
		tableView.dataSource	= self.delegate;
		[self.view addSubview:tableView];
		tableView;
	});
	
	// 3. collectionView
	self.collectionView = ({
		UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(XCTLIN_X, 44, SCREEN_W - XCTLIN_X, SCREEN_H - 44)
															  collectionViewLayout:self.layout];
		collectionView.dataSource		= self.delegate;
		collectionView.delegate			= self.delegate;
		collectionView.backgroundColor	= [UIColor whiteColor];
		[collectionView registerClass:[XCBussCollectionViewCell class] forCellWithReuseIdentifier:@"collection"];
		[self.view addSubview:collectionView];
		collectionView;
	});
}

- (void)setupLoadView {
	
	XCRefreshHeader *header = [XCRefreshHeader headerWithRefreshingTarget:self
														 refreshingAction:@selector(loadDataNews)];

//	// 设置自动切换透明度(在导航栏下面自动隐藏)
//	header.automaticallyChangeAlpha = YES;
//	// 隐藏时间
//	header.lastUpdatedTimeLabel.hidden = YES;
	// 下拉加载数据
	self.collectionView.mj_header = header;
	
	
	XCRefreshHeader *header2 = [XCRefreshHeader headerWithRefreshingTarget:self
														  refreshingAction:@selector(loadDataVideos)];
//	// 设置自动切换透明度(在导航栏下面自动隐藏)
//	header2.automaticallyChangeAlpha = YES;
//	// 隐藏时间
//	header2.lastUpdatedTimeLabel.hidden = YES;
	// 下拉加载数据
	self.tableView.mj_header = header2;
	
	
	[self.collectionView.mj_header beginRefreshing];
	[self.tableView.mj_header beginRefreshing];
}
/// 右侧数据
- (void)loadDataNews {
	//
	[XCBussNewsModel loadWithURL:nil success:^(NSMutableArray *models) {
		self.newsModels = models;
		[self.collectionView.mj_header endRefreshing];
	} failure:^(NSURLSessionDataTask *task, NSError *error) {
		[self.collectionView.mj_header endRefreshing];
	}];
}
/// 左侧数据
- (void)loadDataVideos {
	[XCBussVideoModel loadWithURL:nil success:^(NSMutableArray *models) {
		self.videoModels = models;
		self.delegate.videoModels = models;
		[self.tableView reloadData];
		[self.tableView.mj_header endRefreshing];
	} failure:^(NSURLSessionDataTask *task, NSError *error) {
		[self.tableView.mj_header endRefreshing];
	}];
}

- (void)setNewsModels:(NSMutableArray<XCBussNewsModel *> *)newsModels {
	_newsModels = newsModels;
	self.delegate.newsModels = newsModels;
	[self.collectionView reloadData];
}

#pragma mark -
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
	
}

#pragma mark - Layzing Loading
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








