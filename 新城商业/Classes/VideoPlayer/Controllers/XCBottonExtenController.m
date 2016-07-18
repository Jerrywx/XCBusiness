//
//  XCBottonExtenController.m
//  新城商业
//
//  Created by 王潇 on 16/7/7.
//  Copyright © 2016年 王潇. All rights reserved.
//

#import "XCBottonExtenController.h"
#import "XCBottomNewCell.h"
#import "XCBottonNews.h"

#define CONTENT_H (SCREEN_H * 0.8)
#define TABVIEW_W (SCREEN_W / 3 - 20)

@interface XCBottonExtenController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UIView		*contentView;
@property (nonatomic, strong) UITableView	*tableView;
@property (nonatomic, strong) UIWebView		*webView;
@property (nonatomic, strong) UIView		*webLoadError;

@property (nonatomic, strong) NSArray		*models;

@property (nonatomic, strong) NSString		*urlString;
@property (nonatomic, strong) UIView		*lineView;
@end

@implementation XCBottonExtenController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

	[self setupView];
}

- (void)setupView {
	
	// 0.
	self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.0];
	
	// 1. 内容View
	self.contentView = ({
		UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_H, SCREEN_W, CONTENT_H)];
		[self.view addSubview:view];
		view;
	});
	
	// 2. TableView
	self.tableView = ({
		UITableView *tableView	= [[UITableView alloc] initWithFrame:CGRectMake(0, 0, TABVIEW_W, CONTENT_H)
															   style:UITableViewStyleGrouped];
		tableView.delegate		= self;
		tableView.dataSource	= self;
		tableView.rowHeight		= 80;
		[tableView registerClass:[XCBottomNewCell class] forCellReuseIdentifier:@"bottonCell"];
		[self.contentView addSubview:tableView];
		tableView;
	});
	
	// 3. webView
	self.webView = ({
		UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(TABVIEW_W, 0, SCREEN_W - TABVIEW_W, CONTENT_H)];
		[self.contentView addSubview:webView];
		webView;
	});
	
	// 4. loadError
	self.webLoadError = ({
		UIView *view  = [[UIView alloc] initWithFrame:self.webView.frame];
		view.hidden   = YES;
		[self.contentView addSubview:view];
		view;
	});
	
	// 5. lineView
	self.lineView = ({
		UIView *view = [[UIView alloc] initWithFrame:CGRectMake(TABVIEW_W, 0, 1, CONTENT_H)];
		view.backgroundColor = [UIColor grayColor];
		[self.contentView addSubview:view];
		view;
	});
	
	self.contentView.backgroundColor = [UIColor orangeColor];
}

- (void)loadData {
	
	NSDictionary *param = @{@"v_id" : @"7"};
	[[XCNetWorkManager shareManager] postWithURL:@"http://api.xincheng.tv/api/getvideo1/"
									  parameters:param
										 success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
		
											 if ([responseObject[@"errorcode"] integerValue] == 1000) {
												 NSDictionary *dict = responseObject[@"data"][0];
												 self.urlString = dict[@"n_url"];
											 }
											 
											 
	} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error) {
		NSLog(@"失败: %@", error);
	}];
	
	[XCBottonNews loadSuccess:^(NSMutableArray *models) {
		self.models = models;
		[self.tableView reloadData];
	} failure:^(NSURLSessionDataTask *task, NSError *error) {
	}];
	
}

- (void)loadWebView {
	
	if (self.urlString.length == 0) return;
	NSURLRequest *req = [NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString]];
	[self.webView loadRequest:req];
}

#pragma mark - 动画
- (void)viewWillAppear:(BOOL)animated {
	[self loadWebView];
	
	[UIView animateWithDuration:0.5 animations:^{
		self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
		self.contentView.frame = CGRectMake(0, SCREEN_H - CONTENT_H, SCREEN_W, CONTENT_H);
	}];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
	
	[UIView animateWithDuration:0.4 animations:^{
		self.contentView.frame = CGRectMake(0, SCREEN_H, SCREEN_W, CONTENT_H);
		self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.0];
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
	XCBottomNewCell *cell	= [tableView dequeueReusableCellWithIdentifier:@"bottonCell"];
	cell.model				= self.models[indexPath.row];
	cell.backgroundColor	= [UIColor colorWithRed:0.25f green:0.24f blue:0.29f alpha:1.00f];
	return cell;
}

#pragma mark - UITableViewDelaget
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	
	self.urlString = [self.models[indexPath.row] n_url];
	[self loadWebView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
	return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
	
	UILabel *headLabel		= [[UILabel alloc] initWithFrame:CGRectMake(0, 0, TABVIEW_W, 30)];
	headLabel.text			= @"更多  ";
	headLabel.font			= [UIFont systemFontOfSize:15];
	headLabel.textAlignment = NSTextAlignmentRight;
	return headLabel;
}


@end
