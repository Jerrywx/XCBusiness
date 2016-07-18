//
//  XCNewsDetialViewController.m
//  新城商业
//
//  Created by 王潇 on 16/6/24.
//  Copyright © 2016年 王潇. All rights reserved.
//

#import "XCNewsDetialViewController.h"
#import "XCNewsDetialModel.h"

@interface XCNewsDetialViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView	*tableView;
@property (nonatomic, assign) NSInteger		tableNumb;
@end

@implementation XCNewsDetialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	[self setupView];
}

- (void)setupView {
	self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
	
	// 1.
	self.tableView = ({
		UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(SCREEN_W, 0, XCTLIN_X, SCREEN_H)
															  style:UITableViewStyleGrouped];
		tableView.delegate	 = self;
		tableView.dataSource = self;
		[tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"detialCell"];
		[self.view addSubview:tableView];
		tableView;
	});
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
	CGRect frame = CGRectMake(SCREEN_W, 0, XCTLIN_X, SCREEN_H);
	[UIView animateWithDuration:0.5 animations:^{
		self.tableView.frame = frame;
		self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
	} completion:^(BOOL finished) {
		[self.view removeFromSuperview];
	}];
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	[XCNewsDetialModel loadDataSuccess:^(NSMutableArray *models, id responseObject) {
		
		self.tableNumb = [responseObject[0] allKeys].count;
		[self.tableView reloadData];
	} failure:^(NSURLSessionDataTask *task, NSError *error) {
		
	}];
	
	[self appeartableView];
}

- (void)appeartableView {
	CGRect frame = CGRectMake(SCREEN_W - XCTLIN_X, 0, XCTLIN_X, SCREEN_H);
	[UIView animateWithDuration:0.5 animations:^{
		self.tableView.frame = frame;
		self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
	}];
}

#pragma mark - 
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return self.tableNumb;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"detialCell"];
	cell.textLabel.text = @"cell";
	return cell;
}


@end
