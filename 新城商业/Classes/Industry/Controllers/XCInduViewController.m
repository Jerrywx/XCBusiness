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

@interface XCInduViewController () <UITableViewDelegate, UITableViewDataSource, XCInduHeaderViewDelegate>
@property (nonatomic, strong) UITableView		*logTableView;
@property (nonatomic, strong) UITableView		*contentTableView;
@property (nonatomic, strong) NSArray			*models;
@property (nonatomic, strong) NSArray			*logModels;

@property (nonatomic, strong) NSArray			*models2;
@property (nonatomic, strong) NSArray			*logModels2;

@property (nonatomic, strong) XCIconHeader		*header;
@end

@implementation XCInduViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	[self setupView];
	
	[self loadData];
}

- (void)setupView {
	
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
													NAVBAR_H, SCREEN_W - LOGTAB_W, SCREEN_H - NAVBAR_H)
															  style:UITableViewStyleGrouped];
		tableView.delegate		= self;
		tableView.dataSource	= self;
		[tableView registerClass:[XCInduContentCell class] forCellReuseIdentifier:@"ccel"];
		[tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
		[self.view addSubview:tableView];
		tableView;
	});
}

- (void)loadData {

	[XCInduService loadDataInduID:nil classify:@"10" Success:^(NSArray *log, NSArray *sub, NSArray *log2, NSArray *sub2) {
		self.models			= sub;
		self.logModels		= log;
		self.models2		= sub2;
		self.logModels2		= log2;
		[self.logTableView reloadData];
		[self.contentTableView reloadData];
	} failure:^(NSURLSessionDataTask *task, NSError *error) {
	}];
}
/// 
- (void)loadDataWith:(XCXCInduModel *)model {
	
	[XCInduDetialModel loadDataID:model.in_id classify:@"10" Success:^(NSArray *logd, NSArray *subd, NSString *Id) {
		self.models2		= subd;
		self.logModels2		= logd;
		[self.contentTableView reloadData];
	} failure:^(NSURLSessionDataTask *task, NSError *error) {
		
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

#pragma mark - Getter Methond
- (XCIconHeader *)header {
	
	if (_header) {
		return _header;
	}
	
	_header = [[XCIconHeader alloc] initWithFrame:CGRectMake(0, 0, LOGTAB_W, LOGTAB_W / 5 * 2)];
	
	return _header;
}

@end

