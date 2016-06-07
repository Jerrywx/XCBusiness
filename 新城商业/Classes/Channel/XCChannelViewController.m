//
//  XCChannelDetailViewController.m
//  新城商业
//
//  Created by 王潇 on 16/5/9.
//  Copyright © 2016年 王潇. All rights reserved.
//

#import "XCChannelViewController.h"
#import "XCBaseChannelViewController.h"

@interface XCChannelViewController ()
@property (nonatomic, strong) UIView				*navigationBar;
@property (nonatomic, strong) UIButton				*backBtn;

@property (nonatomic, strong) NSArray				*titles;
@property (nonatomic, strong) HMSegmentedControl	*segmentControl;

@property (nonatomic, strong) UIScrollView			*scrollView;
@end

@implementation XCChannelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.view.backgroundColor = [UIColor whiteColor];
	[self initNavigationBar];
	[self initScrollView];
	[self addChildViewControllers];
}

- (void)initNavigationBar {
	self.navigationBar = ({
		UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, NAVBAR_H)];
		view.backgroundColor = [UIColor blackColor];
		[self.view addSubview:view];
		view;
	});
	
	self.backBtn = ({
		UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_W - 140, 0, 130, NAVBAR_H)];
		button.titleLabel.font = [UIFont systemFontOfSize:16];
		[button setTitle:[NSString stringWithFormat:@"返回 %@",self.backTitle] forState:UIControlStateNormal];
		button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
		[button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
		[self.navigationBar addSubview:button];
		button;
	});
	
	self.segmentControl = ({
		HMSegmentedControl *segment = [[HMSegmentedControl alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W - 150, 44)];
		segment.sectionTitles		= self.titles;
		segment.segmentWidthStyle	= HMSegmentedControlSegmentWidthStyleFixed;
		segment.selectionIndicatorColor		= [UIColor redColor];
		segment.backgroundColor				= [UIColor colorWithRed:0.22f green:0.23f blue:0.23f alpha:1.00f];
		segment.selectionStyle				= HMSegmentedControlSelectionStyleBox;
		segment.borderColor					= [UIColor blackColor];
		segment.borderType					= HMSegmentedControlBorderTypeRight;
		segment.selectionIndicatorLocation	= HMSegmentedControlSelectionIndicatorLocationNone;
		segment.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor],
										NSFontAttributeName: [UIFont systemFontOfSize:11]};
		[segment addTarget:self action:@selector(segmentClicked:) forControlEvents:UIControlEventValueChanged];
		[self.navigationBar addSubview:segment];
		segment;
	});
}

- (void)initScrollView {
	self.scrollView = ({
		UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, NAVBAR_H, SCREEN_W, SCREEN_H - NAVBAR_H)];
		scrollView.contentSize	 = CGSizeMake(SCREEN_W * self.titles.count, SCREEN_H - NAVBAR_H);
		scrollView.pagingEnabled = YES;
		[self.view addSubview:scrollView];
		scrollView;
	});
}

- (void)addChildViewControllers {
	
	CGFloat vcY = 0;
	CGFloat vcH = SCREEN_H - vcY;
	
	for (int i = 0; i < self.titles.count; i++) {
		XCBaseChannelViewController *base = [[XCBaseChannelViewController alloc] init];
		[self addChildViewController:base];
		base.view.frame = CGRectMake(SCREEN_W * i, vcY, SCREEN_W, vcH);
		base.view.backgroundColor = [UIColor colorWithHue:( arc4random() % 256 / 256.0 )
											   saturation:( arc4random() % 256 / 256.0 )
											   brightness:( arc4random() % 256 / 256.0 ) alpha:1];
		[self.scrollView addSubview:base.view];
	}
}

- (void)back {
	[self.navigationController popViewControllerAnimated:YES];
}

- (void)segmentClicked:(HMSegmentedControl *)segment {
	NSLog(@"----------- %zd", segment.selectedSegmentIndex);
//	self.scrollView setContentOffset:<#(CGPoint)#> animated:<#(BOOL)#>
}

#pragma mark - 懒加载
- (NSArray *)titles {
	
	if (!_titles) {
		_titles = @[@"行业矩阵",
					@"重要科技",
					@"项目进行中",
					@"大事件",
					@"百科",
					@"机构检查",
					@"任务检查",];
	}
	return _titles;
}

@end
