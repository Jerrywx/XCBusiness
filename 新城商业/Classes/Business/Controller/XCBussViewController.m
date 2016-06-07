//
//  XCBussViewController.m
//  新城商业
//
//  Created by 王潇 on 16/4/25.
//  Copyright © 2016年 王潇. All rights reserved.
//

#import "XCBussViewController.h"
#import "XCBussVideoModel.h"

@interface XCBussViewController () //<UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, strong) UITableView					*tableView;
@property (nonatomic, strong) UICollectionView				*collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout	*layout;
@property (nonatomic, strong) XCBussDelegate				*delegate;
@end

@implementation XCBussViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	[self setupView];
	[self loadData];
}

- (void)setupView {
	// 1. 基础设置
	self.tableLabel.text		= @"《新城商业》节目";
	self.collectionLabel.text	= @"新城商业";
	self.delegate = [[XCBussDelegate alloc] init];
	
	// 2. tableView
	self.tableView = ({
		UITableView *tableView	= [[UITableView alloc] initWithFrame:CGRectMake(0, 44, XCTLIN_X, SCREEN_H - 44)
															   style:UITableViewStyleGrouped];
		tableView.delegate		= self.delegate;
		tableView.dataSource	= self.delegate;
//		tableView.separatorStyle= UITableViewCellSeparatorStyleNone;
		[self.view addSubview:tableView];
		tableView;
	});
	
	// 3. collectionView
	self.collectionView = ({
		UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(XCTLIN_X, 44, SCREEN_W - XCTLIN_X, SCREEN_H - 44)
															  collectionViewLayout:self.layout];
		collectionView.dataSource	= self.delegate;
		collectionView.delegate		= self.delegate;
		collectionView.backgroundColor = [UIColor whiteColor];
		[collectionView registerClass:[XCBussCollectionViewCell class] forCellWithReuseIdentifier:@"collection"];
		[self.view addSubview:collectionView];
		collectionView;
	});
}

- (void)loadData {
	NSLog(@"=====data");
	
//	self.delegate.videoModels = @[@"1", @"3",@"4",@"1", @"3",@"4"];
//	self.delegate.newsModels = @[@"1", @"3",@"4",@"1", @"3",@"4"];
//	
//	[self.tableView reloadData];
//	[self.collectionView reloadData];
	
	[XCBussVideoModel loadData];
}

#pragma mark -
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
	
	NSLog(@"------------------------ %zd", self.tabBarController.selectedIndex);	
//	XCTestViewController *test = [[XCTestViewController alloc] init];
//	[self.navigationController pushViewController:test animated:YES];
}

#pragma mark - Layzing Loading
- (UICollectionViewFlowLayout *)layout {
	
	if (_layout) {
		return _layout;
	}
	
	CGFloat itemW = (SCREEN_W - XCTLIN_X - 30) * 0.5;
	CGFloat itemH = (11 / 14.0) * itemW;
	
	_layout = [[UICollectionViewFlowLayout alloc] init];
	_layout.minimumLineSpacing = 10;
	_layout.minimumInteritemSpacing = 10;
	_layout.itemSize = CGSizeMake(itemW, itemH);
	_layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
	
	return _layout;
}

@end
