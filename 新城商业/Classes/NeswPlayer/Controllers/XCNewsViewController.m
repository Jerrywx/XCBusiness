//
//  XCNewsViewController.m
//  新城商业
//
//  Created by 王潇 on 16/6/14.
//  Copyright © 2016年 王潇. All rights reserved.
//

#import "XCNewsViewController.h"
#import "XCNewsTableViewCell.h"
#import "XCNewsDetialViewController.h"
#import "XCNewsModel.h"

@interface XCNewsViewController () <UITableViewDelegate, UITableViewDataSource,
									UIGestureRecognizerDelegate>
@property (nonatomic, strong) UIButton		*closeBtn;
@property (nonatomic, strong) UITableView	*tableView;
@property (nonatomic, strong) UIWebView		*webView;
@property (nonatomic, strong) NSArray		*models;
@end

@implementation XCNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	[self setupView];
	
	[self setupLoadView];
}

- (void)setupView {
	self.view.backgroundColor = [UIColor whiteColor];
	self.automaticallyAdjustsScrollViewInsets = NO;
	
	CGFloat tableView_W = SCREEN_W / 3.0 - 1 - 20;
	CGFloat webView_W = SCREEN_W - tableView_W;
	
	self.tableView = ({
		CGRect frame = CGRectMake(0, 0, tableView_W, SCREEN_H);
		UITableView *tableView	= [[UITableView alloc] initWithFrame:frame
															   style:UITableViewStylePlain];
		tableView.delegate		= self;
		tableView.dataSource	= self;
		[self.view addSubview:tableView];
		tableView;
	});
	
	// 分割线
	UIView *view = [[UIView alloc] initWithFrame:CGRectMake(tableView_W, 0, 1, SCREEN_H)];
	view.backgroundColor = [UIColor grayColor];
	[self.view addSubview:view];
	
	// webView
	self.webView = ({
		UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(tableView_W + 1, 0, webView_W, SCREEN_H)];
		NSURLRequest *req = [NSURLRequest requestWithURL:[NSURL URLWithString:self.model.nvg_url]];
		[webView loadRequest:req];
		[self.view addSubview:webView];
		webView;
	});
	
	// 添加手势
	UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self
																				action:@selector(swipAction:)];
	swipe.direction = UISwipeGestureRecognizerDirectionLeft;
	swipe.delegate  = self;
	[self.webView addGestureRecognizer:swipe];
//	[self.tableView addGestureRecognizer:swipe];
	
	
	// 关闭按钮
	self.closeBtn = ({
		UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_W - 80, 20, 60, 60)];
		button.backgroundColor = [UIColor orangeColor];
		[self.view addSubview:button];
		[button addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
		button;
	});
}

- (void)setupLoadView {
	// 下拉加载数据
	self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self
																refreshingAction:@selector(loadData)];
	[self.tableView.mj_header beginRefreshing];
}

- (void)loadData {
	[XCNewsModel loadWithURL:nil success:^(NSMutableArray *models) {
		self.models = models;
		[self.tableView.mj_header endRefreshing];
	} failure:^(NSURLSessionDataTask *task, NSError *error) {
		[self.tableView.mj_header endRefreshing];
	}];
}

- (void)setModels:(NSArray *)models {
	_models = models;
	[self.tableView reloadData];
}

- (void)swipAction:(UIGestureRecognizer *)gesture {
	NSLog(@"----- GES: %@", gesture);
	XCNewsDetialViewController *detial = [[XCNewsDetialViewController alloc]  init];
	[self addChildViewController:detial];
	[self.view addSubview:detial.view];
	
}

/*
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
	if ([touch.view isKindOfClass:[UIWebView class]]){
		return NO;
	}
	return YES;
}
 */

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
	return YES;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return self.models.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	// 1. 创建 cell
	XCNewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"newsCell"];
	if (!cell) {
		cell = [[XCNewsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"newsCell"];
	}
	
	// 2. 设置 cell
	cell.backgroundColor = [UIColor colorWithRed:0.25f green:0.24f blue:0.29f alpha:1.00f];
	cell.model = self.models[indexPath.row];
	
	// 3. 返回 cell
	return cell;
}

#pragma mark - UITableViewDelegate

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
#pragma mark - 
- (void)close {
	[self.navigationController popViewControllerAnimated:YES];
}


@end
