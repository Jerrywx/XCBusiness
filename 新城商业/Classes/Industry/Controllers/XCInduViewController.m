 //
//  XCInduViewController.m
//  新城商业
//
//  Created by 王潇 on 16/4/25.
//  Copyright © 2016年 王潇. All rights reserved.
//

#import "XCInduViewController.h"
#import "XCXCInduModel.h"
#import "XCIconHeader.h"
#import "XCInduDetialModel.h"
#import "XCInduHeaderView.h"
#import "XCInduContentCell.h"
#import "XCInduService.h"

#define LOGTAB_W (150)
#define CURRENTCHANNEL @"10"

@interface XCInduViewController () <UITableViewDelegate, UITableViewDataSource, XCInduHeaderViewDelegate>
/// 目录
@property (nonatomic, strong) UITableView		*logTableView;
/// 内容
@property (nonatomic, strong) XCTableView		*contentTableView;
/// 目录标题
@property (nonatomic, strong) NSArray			*models;
/// 目录内容
@property (nonatomic, strong) NSArray			*logModels;
/// 内容标题
@property (nonatomic, strong) NSMutableArray	*models2;
/// 内容内容
@property (nonatomic, strong) NSMutableArray	*logModels2;

/// ICON
@property (nonatomic, strong) XCIconHeader		*header;
/// 选择频道
@property (nonatomic, strong) HMSegmentedControl	*segment;
/// 当前 标题ID
@property (nonatomic, strong) NSString				*currentChannel;
/// 当前 频道模型
@property (nonatomic, strong) XCXCInduModel			*curretnModel;
/// 当前页数
@property (nonatomic, assign) NSInteger				currentPage;
@property (nonatomic, assign) BOOL					loadingFlag;

@end

@implementation XCInduViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	[self setupView];
	[self setupRefreshView];
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	if (self.models == 0) {
		[self loadData];
	}
}

/// 刷新视图
- (void)setupRefreshView {
	/// 加载更多
	self.contentTableView.mj_footer
	= [MJRefreshBackNormalFooter footerWithRefreshingTarget:self
										   refreshingAction:@selector(loadMoreData)];
}
/// 初始化界面
- (void)setupView {

	self.tableLabel.text = @"";
	self.collectionLabel.text = @"行业矩阵";
	
	self.currentChannel = CURRENTCHANNEL;
	
	// 1.
	self.view.backgroundColor = [UIColor whiteColor];
//	[self hiddenAllNav];
	
	// 2.
	self.logTableView  = ({
		UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,
																0, LOGTAB_W, SCREEN_H)
															  style:UITableViewStylePlain];
		tableView.delegate		= self;
		tableView.dataSource	= self;
		tableView.tableHeaderView	 = self.header;
		[tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
		[self.view addSubview:tableView];
		tableView;
	});
	
	// 3.
	self.contentTableView = ({
		XCTableView *tableView = [[XCTableView alloc] initWithFrame:CGRectMake(LOGTAB_W,
													NAVBAR_H * 2, SCREEN_W - LOGTAB_W, SCREEN_H - NAVBAR_H * 2)
															  style:UITableViewStyleGrouped];
		tableView.delegate		= self;
		tableView.dataSource	= self;
		[tableView registerClass:[XCInduContentCell class] forCellReuseIdentifier:@"ccel"];
		[tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
		[self.view addSubview:tableView];
		tableView;
	});
	
	[self.view addSubview:self.segment];
}
/// 初始化加载
- (void)loadData {
	
	self.loadingFlag  = YES;
	[JRProgressHUD showHUDAddedTo:self.contentTableView];
	[XCInduService loadDataInduID:nil classify:self.currentChannel Success:^(NSArray *log, NSArray *sub, NSArray *log2, NSArray *sub2) {
		self.models			= sub;
		self.logModels		= log;
		self.models2		= sub2.mutableCopy;
		self.logModels2		= log2.mutableCopy;
		[self.logTableView reloadData];
		[self.contentTableView reloadData];
		if (log2.count == 0) {
			self.contentTableView.type = XCTableViewNoData;
		} else {
			self.contentTableView.type = XCTableViewNormal;
		}
		self.curretnModel = sub[0][0];
		self.currentPage  = 2;
		self.loadingFlag  = NO;
		[JRProgressHUD hideHUDForView:self.contentTableView];
	} failure:^(NSURLSessionDataTask *task, NSError *error) {
		self.loadingFlag  = NO;
		self.contentTableView.type = XCTableViewError;
		[JRProgressHUD hideHUDForView:self.contentTableView];
	}];
}
/// 加载更多数据
- (void)loadMoreData {
	NSLog(@"----- %zd", self.currentPage);
	
	if (_loadingFlag) {
		[self.contentTableView.mj_footer endRefreshing];
		return;
	}
	
	[XCInduDetialModel loadInduID:self.curretnModel.in_id classify:self.currentChannel pageNumb:self.currentPage Success:^(NSArray *logd, NSArray *subd) {
		
		if (logd.count == 0 || subd.count == 0) {
			[self.contentTableView.mj_footer endRefreshingWithNoMoreData];
		} else {
			[self.logModels2 addObjectsFromArray:logd];
			[self.models2 addObjectsFromArray:subd];
			[self.contentTableView reloadData];
			[self.contentTableView.mj_footer endRefreshing];
		}
		self.currentPage++;
	} failure:^(NSURLSessionDataTask *task, NSError *error) {
		[self.contentTableView.mj_footer endRefreshing];
	}];
}
/// 选择频道
- (void)loadDataWith:(XCXCInduModel *)model {
	/// 保存所选频道
	self.curretnModel = model;
	self.currentPage  = 0;
	self.loadingFlag  = YES;
	/// 清理数据
	self.models2 = nil;
	self.logModels2 = nil;
	[self.contentTableView reloadData];
	
	/// 加载数据
	[JRProgressHUD showHUDAddedTo:self.contentTableView];
	[XCInduDetialModel loadDataID:model.in_id classify:self.currentChannel Success:^(NSArray *logd, NSArray *subd, NSString *Id, NSString * classId) {
		if ([Id isEqualToString:self.curretnModel.in_id]
					&& [self.currentChannel isEqualToString:classId]) {
			
			if (logd.count == 0) {
				self.contentTableView.type = XCTableViewNoData;
			} else {
				self.contentTableView.type = XCTableViewNormal;
				self.models2		= subd.mutableCopy;
				self.logModels2		= logd.mutableCopy;
				[self.contentTableView reloadData];
				self.currentPage = 2;
			}
		}
		self.loadingFlag  = NO;
		[JRProgressHUD hideHUDForView:self.contentTableView];
	} failure:^(NSURLSessionDataTask *task, NSError *error) {
		self.loadingFlag  = NO;
		self.contentTableView.type = XCTableViewError;
		[JRProgressHUD hideHUDForView:self.contentTableView];
	}];
	
	[self.contentTableView.mj_footer endRefreshing];
}

#pragma mark -
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	
	if (tableView == self.logTableView) {
		return self.models.count;
	} else if (tableView == self.contentTableView) {
		return self.models2.count;
	} else {
		return 0;
	}
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

	if (tableView == self.logTableView) {
		return [self.models[section] count];
	} else if (tableView == self.contentTableView) {
		XCInduDetialModel *model = self.logModels2[section];
		if (model.isOpen) {
			return [self.models2[section] count];
		} else {
			return 0;
		}
	} else {
		return 0;
	}
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

	if (tableView == self.logTableView) {
		UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
		cell.textLabel.font	= [UIFont systemFontOfSize:12];
		cell.textLabel.textAlignment = NSTextAlignmentRight;
		cell.textLabel.text = [self.models[indexPath.section][indexPath.row] in_cn];
		return cell;
		
	} else {
		XCInduContentCell *cell = [[XCInduContentCell alloc] init];
		cell.model = self.models2[indexPath.section][indexPath.row];
		return cell;
	}
}

#pragma mark -
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

	if (tableView == self.logTableView) {
		XCXCInduModel *model = self.models[indexPath.section][indexPath.row];
		/// 设置分类为第一个分类
		self.segment.selectedSegmentIndex = 0;
		self.currentChannel = CURRENTCHANNEL;
		[self loadDataWith:model];
	} else {
		[tableView deselectRowAtIndexPath:indexPath animated:YES];
	}
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	
	if (tableView == self.logTableView) {
		return [self.logModels[section] in_cn];
	} else {
//		return [self.logModels2[section] k_cn];
		return nil;
	}
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
	if (tableView == self.contentTableView) {
		XCInduHeaderView *view = [[XCInduHeaderView alloc] init];
		view.delegate = self;
		view.model = self.logModels2[section];
		return view;
	} else {
		return nil;
	}
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	
	if (tableView == self.logTableView) {
		return NAVBAR_H;
	} else {
		return 80;
	}
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
	return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	if (tableView == self.logTableView) {
		return NAVBAR_H;
	} else {
		NSArray *array = self.models2[indexPath.section];
		XCDetialModel *model = array[indexPath.row];
		return model.height;
	}
}

#pragma mark -
- (void)induHeaderViewDidSelected:(XCInduDetialModel *)model {

	BOOL tip = model.isOpen;
	for (XCInduDetialModel *model in self.logModels2) {
		model.isOpen = NO;
	}
	model.isOpen = !tip;
	[self.contentTableView reloadData];
}

/// 选择分类
- (void)selectedChannel {
	
	switch (self.segment.selectedSegmentIndex) {
		case 0:
			self.currentChannel = @"10";
			break;
		case 1:
			self.currentChannel = @"11";
			break;
		case 2:
			self.currentChannel = @"9";
			break;
		default:
			break;
	}
	[self loadDataWith:self.curretnModel];
}

#pragma mark - Getter Methond
- (XCIconHeader *)header {
	
	if (_header) {
		return _header;
	}
	_header = [[XCIconHeader alloc] initWithFrame:CGRectMake(0, 0, LOGTAB_W, LOGTAB_W / 3 * 2)];
	return _header;
}

- (HMSegmentedControl *)segment {
	
	if (_segment) {
		return _segment;
	}
	CGRect frame = CGRectMake(LOGTAB_W, NAVBAR_H, SCREEN_W - LOGTAB_W, NAVBAR_H);
	_segment = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"商业公司", @"人物", @"国家机构"]];
	_segment.segmentWidthStyle			= HMSegmentedControlSegmentWidthStyleFixed;
	_segment.selectionIndicatorColor	= [UIColor redColor];
	_segment.backgroundColor			= [UIColor colorWithRed:0.22f green:0.23f blue:0.23f alpha:1.00f];
	_segment.selectionStyle				= HMSegmentedControlSelectionStyleBox;
	_segment.borderColor				= [UIColor blackColor];
	_segment.borderType					= HMSegmentedControlBorderTypeRight;
	_segment.selectionIndicatorLocation	= HMSegmentedControlSelectionIndicatorLocationNone;
	_segment.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor],
									NSFontAttributeName: [UIFont systemFontOfSize:14]};
	[_segment addTarget:self action:@selector(selectedChannel) forControlEvents:UIControlEventValueChanged];
	_segment.frame = frame;

	return _segment;
}

@end

