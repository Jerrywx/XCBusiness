//
//  XCPlayerViewController.m
//  新城商业
//
//  Created by 王潇 on 16/6/9.
//  Copyright © 2016年 王潇. All rights reserved.
//

#import "XCPlayerViewController.h"
#import "XCBottonExtenController.h"
#import "XCRightExtenController.h"
#import "XCBussNewsModel.h"
#import "XCRightVideo.h"

@interface XCPlayerViewController () <XCRightExtenControllerDelegate>
@property (nonatomic, strong) UIWebView		*webView;		// 视频内容
@property (nonatomic, strong) UIButton		*closeBtn;		// 关闭按钮

@property (nonatomic, strong) XCBottonExtenController	*bottonExten;		// 拓展内容
@property (nonatomic, strong) XCRightExtenController	*rightExten;	// 右侧扩展内容

@end

@implementation XCPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	[self setupView];
	[self addSubController];
}

- (void)setupView {
	// 1. 设置背景色
	self.view.backgroundColor = [UIColor blackColor];
	self.automaticallyAdjustsScrollViewInsets = NO;
	
	// 2. webView
	self.webView = ({
		UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
		webView.scrollView.bounces = NO;
		webView.scrollView.scrollEnabled = NO;
		[self.view addSubview:webView];
		webView;
	});

	// 3. 拼接 HTML
//	NSString *html2 = [NSString stringWithFormat:@"<!DOCTYPE html>\
//					   <html>\
//					   <head>\
//					   <title></title>\
//					   </head>\
//					   <body style=\"background-color:#000000;\" >\
//					   <iframe  height=%f width= %f src='%@' frameborder=0 allowfullscreen></iframe>\
//					   </body>\
//					   </html>", SCREEN_H - 20, SCREEN_W - 20, self.videoUrl];
//	
//	// 4. 加载 HTML
//	[self.webView loadHTMLString:html2 baseURL:nil];
	
	[self loadVideoWithURL:self.videoUrl];
	
	// 5. 关闭按钮
	self.closeBtn = ({
		UIButton *button		= [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_W - 80, 20, 60, 60)];
		button.backgroundColor	= [UIColor orangeColor];
		[self.view addSubview:button];
		[button addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
		button;
	});
	
	// 6. 添加手势
	UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self
																				action:@selector(swipeAct:)];

	swipe.direction = UISwipeGestureRecognizerDirectionUp;
	[self.webView addGestureRecognizer:swipe];
	
	UISwipeGestureRecognizer *swipe2 = [[UISwipeGestureRecognizer alloc] initWithTarget:self
																				action:@selector(swipeAct2:)];
	swipe2.direction = UISwipeGestureRecognizerDirectionLeft;
	[self.webView addGestureRecognizer:swipe2];
	
}

- (void)loadVideoWithURL:(NSString *)urlString {
	NSString *html2 = [NSString stringWithFormat:@"<!DOCTYPE html>\
					   <html>\
					   <head>\
					   <title></title>\
					   </head>\
					   <body style=\"background-color:#000000;\" >\
					   <iframe  height=%f width= %f src='%@' frameborder=0 allowfullscreen></iframe>\
					   </body>\
					   </html>", SCREEN_H - 20, SCREEN_W - 20, urlString];
	
	// 4. 加载 HTML
	[self.webView loadHTMLString:html2 baseURL:nil];
}

-(void)loadNewsWithURL:(NSString *)urlString {
	
	self.webView.scrollView.scrollEnabled = YES;
	
	NSURL *url = [NSURL URLWithString:urlString];
	NSURLRequest *req = [NSURLRequest requestWithURL:url];
	[self.webView loadRequest:req];
}

- (void)addSubController {
	
	// 1. 底部拓展
	self.bottonExten = [[XCBottonExtenController alloc] init];
	[self.bottonExten loadData];
	[self addChildViewController:self.bottonExten];
	
	// 2. 右侧拓展
	self.rightExten = [[XCRightExtenController alloc] init];
	self.rightExten.delegate = self;
	[self.rightExten loadData];
	[self addChildViewController:self.rightExten];
}

#pragma mark - XCRightExtenControllerDelegate
- (void)itemDidSelectedModel:(XCRightVideo *)model {
	
	if ([model.norv_type isEqualToString:@"1"]) {
		[self loadNewsWithURL:model.url];
	} else {
		NSArray *array = [model.url componentsSeparatedByString:@"'"];
		if (array.count < 2) return;
		
		if ([array[1] hasPrefix:@"http"]) {
			[self loadVideoWithURL:array[1]];
		}
	}
}

#pragma mark - 手势操作
- (void)swipeAct:(UISwipeGestureRecognizer *)gesture {
	if (gesture.direction == UISwipeGestureRecognizerDirectionUp) {
		[self.view addSubview:self.bottonExten.view];
	}
}

- (void)swipeAct2:(UISwipeGestureRecognizer *)gesture {
	[self.view addSubview:self.rightExten.view];
}

- (void)setModel:(XCBussVideoModel *)model {
	_model = model;
	NSArray *array = [model.vb_link componentsSeparatedByString:@"'"];
	if (array.count < 2) return;

	if ([array[1] hasPrefix:@"http"]) {
		self.videoUrl = array[1];
	}
}

- (void)setNewsModel:(XCBussNewsModel *)newsModel {
	_newsModel = newsModel;
	NSArray *array = [newsModel.nvg_url componentsSeparatedByString:@"'"];
	if (array.count < 2) return;
	if ([array[1] hasPrefix:@"http"]) {
		self.videoUrl = array[1];
	}
}

// 返回
- (void)close {
	[self.navigationController popViewControllerAnimated:YES];
}

@end
