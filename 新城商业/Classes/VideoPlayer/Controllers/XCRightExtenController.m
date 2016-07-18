//
//  XCRightExtenController.m
//  新城商业
//
//  Created by 王潇 on 16/7/7.
//  Copyright © 2016年 王潇. All rights reserved.
//

#import "XCRightExtenController.h"
#import "XCBottomNewCell.h"
#import "XCRightVideo.h"

#define TABLE_W (SCREEN_W / 3)

@interface XCRightExtenController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UIView			*contentView;
@property (nonatomic, strong) UITableView		*tableView;
@property (nonatomic, strong) NSArray			*models;
@end

@implementation XCRightExtenController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	[self setupView];
}

- (void)setupView {
	//
	self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.0];
	
	// 1.
	self.contentView = ({
		UIView *view = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_W, 0, TABLE_W, SCREEN_H)];
		[self.view addSubview:view];
		view;
	});
	
	// 2.
	self.tableView = ({
		UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, TABLE_W, SCREEN_H)
															  style:UITableViewStyleGrouped];
		tableView.delegate	 = self;
		tableView.dataSource = self;
		tableView.rowHeight  = 80;
		[tableView registerClass:[XCBottomNewCell class] forCellReuseIdentifier:@"rightCell"];
		[self.contentView addSubview:tableView];
		tableView;
	});
	
	//
	self.contentView.backgroundColor = [UIColor orangeColor];
}

- (void)loadData {
	[XCRightVideo loadSuccess:^(NSMutableArray *models) {
		self.models = models;
		[self.tableView reloadData];
	} failure:^(NSURLSessionDataTask *task, NSError *error) {
		
	}];
}

#pragma mark -
- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	
	[UIView animateWithDuration:0.5 animations:^{
		self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
		self.contentView.frame	  = CGRectMake(SCREEN_W - TABLE_W, 0, TABLE_W, SCREEN_H);
	}];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
	[UIView animateWithDuration:0.5 animations:^{
		self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.0];
		self.contentView.frame	  = CGRectMake(SCREEN_W, 0, TABLE_W, SCREEN_H);
	} completion:^(BOOL finished) {
		[self.view removeFromSuperview];
	}];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return self.models.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	XCBottomNewCell *cell	= [tableView dequeueReusableCellWithIdentifier:@"rightCell"];
	cell.videoModel			= self.models[indexPath.row];
	cell.backgroundColor	= [UIColor colorWithRed:0.25f green:0.24f blue:0.29f alpha:1.00f];
	
	return cell;
}

#pragma mark - UITableViewDelagete
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	
	XCRightVideo *model = self.models[indexPath.row];
	
	if ([self.delegate respondsToSelector:@selector(itemDidSelectedModel:)]) {
		[self.delegate itemDidSelectedModel:model];
	}
}


@end
