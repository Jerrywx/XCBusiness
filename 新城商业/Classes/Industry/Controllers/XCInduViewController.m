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
@property (nonatomic, strong) UITableView		*contentTableView;
/// 目录标题
@property (nonatomic, strong) NSArray			*models;
/// 目录内容
@property (nonatomic, strong) NSArray			*logModels;
/// 内容标题
@property (nonatomic, strong) NSArray			*models2;
/// 内容内容
@property (nonatomic, strong) NSArray			*logModels2;

/// ICON
@property (nonatomic, strong) XCIconHeader		*header;
/// 选择频道
@property (nonatomic, strong) HMSegmentedControl	*segment;
/// 当前 标题ID
@property (nonatomic, strong) NSString				*currentChannel;
/// 当前 频道模型
@property (nonatomic, strong) XCXCInduModel			*curretnModel;

@end

@implementation XCInduViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	[self setupView];
	
	[self loadData];
}

- (void)setupView {

	self.currentChannel = CURRENTCHANNEL;
	
	// 1.
	self.view.backgroundColor = [UIColor greenColor];
	[self hiddenAllNav];
	
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
		UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(LOGTAB_W,
													NAVBAR_H * 2, SCREEN_W - LOGTAB_W, SCREEN_H - NAVBAR_H)
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

	[JRProgressHUD showHUDAddedTo:self.view];
	[XCInduService loadDataInduID:nil classify:self.currentChannel Success:^(NSArray *log, NSArray *sub, NSArray *log2, NSArray *sub2) {
		self.models			= sub;
		self.logModels		= log;
		self.models2		= sub2;
		self.logModels2		= log2;
		[self.logTableView reloadData];
		[self.contentTableView reloadData];
		
		self.curretnModel = sub[0][0];
		[JRProgressHUD hideHUDForView:self.view];
	} failure:^(NSURLSessionDataTask *task, NSError *error) {
		[JRProgressHUD hideHUDForView:self.view];
	}];
}
/// 点击分类加载
- (void)loadContent {
	
}
/// 选择频道
- (void)loadDataWith:(XCXCInduModel *)model {
	/// 保存所选频道
	self.curretnModel = model;
	
	/// 清理数据
	self.models2 = nil;
	self.logModels2 = nil;
	[self.contentTableView reloadData];
	
	/// 加载数据
	[JRProgressHUD showHUDAddedTo:self.view];
	[XCInduDetialModel loadDataID:model.in_id classify:self.currentChannel Success:^(NSArray *logd, NSArray *subd, NSString *Id) {
		NSLog(@"---- %@ - %@", Id, self.curretnModel.in_id);
		if ([Id isEqualToString:self.curretnModel.in_id]) {
			self.models2		= subd;
			self.logModels2		= logd;
			[self.contentTableView reloadData];
		}
		[JRProgressHUD hideHUDForView:self.view];
	} failure:^(NSURLSessionDataTask *task, NSError *error) {
		[JRProgressHUD hideHUDForView:self.view];
	}];
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
	
	_header = [[XCIconHeader alloc] initWithFrame:CGRectMake(0, 0, LOGTAB_W, LOGTAB_W / 5 * 2)];
	
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

