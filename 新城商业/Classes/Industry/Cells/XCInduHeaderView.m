//
//  XCInduHeaderView.m
//  新城商业
//
//  Created by 王潇 on 16/10/31.
//  Copyright © 2016年 王潇. All rights reserved.
//

#import "XCInduHeaderView.h"
#import "XCInduDetialModel.h"

@interface XCInduHeaderView ()

@property (nonatomic, strong) UIImageView	*iconImageView;
@property (nonatomic, strong) UILabel		*titleLael;
@property (nonatomic, strong) UILabel		*summaryLabel;
@property (nonatomic, strong) UILabel		*contryLabel;

@property (nonatomic, strong) UILabel		*productLabel;
@property (nonatomic, strong) UILabel		*technologyLabel;
@property (nonatomic, strong) UILabel		*projectLabel;
@property (nonatomic, strong) UILabel		*personLabel;

@end


@implementation XCInduHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
	
	self = [super initWithFrame:frame];
	
	[self setupView];
	[self layoutViews];
	
	return self;
}

static CGFloat height = 80;
static CGFloat margin = 10;
///
- (void)setupView {
	
	self.backgroundColor = [UIColor whiteColor];
	
	///
	self.iconImageView = ({
		UIImageView *imageView = [[UIImageView alloc] init];
		[self addSubview:imageView];
		imageView;
	});

	///
	self.titleLael = ({
		UILabel *title	= [[UILabel alloc] init];
		title.font		= _k_XCFont20;
		[title sizeToFit];
		[self addSubview:title];
		title;
	});
	
	///
	self.summaryLabel = ({
		UILabel *title			= [[UILabel alloc] init];
		title.numberOfLines		= 0;
		title.font				= _k_XCFont24;
		[self addSubview:title];
		title;
	});
	
	///
	self.contryLabel = ({
		UILabel *title = [[UILabel alloc] init];
		title.font		= _k_XCFont20;
		[self addSubview:title];
		title;
	});

	///////
	self.productLabel = ({
		UILabel *title = [[UILabel alloc] init];
		[self addSubview:title];
		title;
	});
	
	///
	self.technologyLabel = ({
		UILabel *title = [[UILabel alloc] init];
		[self addSubview:title];
		title;
	});
	
	self.technologyLabel = ({
		UILabel *title = [[UILabel alloc] init];
		[self addSubview:title];
		title;
	});
	
	self.projectLabel = ({
		UILabel *title = [[UILabel alloc] init];
		[self addSubview:title];
		title;
	});

	self.personLabel = ({
		UILabel *title = [[UILabel alloc] init];
		[self addSubview:title];
		title;
	});
	
	///
//	self.iconImageView.backgroundColor = [UIColor orangeColor];
//	self.titleLael.backgroundColor = [UIColor orangeColor];
//	self.summaryLabel.backgroundColor = [UIColor orangeColor];
//	self.contryLabel.backgroundColor = [UIColor orangeColor];
}

- (void)layoutViews {

	///
	[self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.top.equalTo(@(margin));
		make.width.height.equalTo(@(height - margin * 2));
	}];
	
	///
	[self.titleLael mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.equalTo(self.iconImageView.mas_right).offset(margin);
		make.top.equalTo(@(margin));
		make.height.equalTo(@(10));
	}];
	
	[self.contryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.equalTo(self.iconImageView.mas_right).offset(margin);
		make.bottom.equalTo(self.mas_bottom).offset(-margin);
		make.height.equalTo(@(10));
	}];
	
	[self.summaryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.equalTo(self.iconImageView.mas_right).offset(margin);
		make.top.equalTo(self.titleLael.mas_bottom).offset(margin * 0.5);
		make.bottom.equalTo(self.contryLabel.mas_top).offset(-margin * 0.5);
		make.right.equalTo(self.mas_right).offset(-60);
	}];
}

#pragma mark - 
- (void)setModel:(XCInduDetialModel *)model {
	_model = model;
	
	self.titleLael.text = model.k_cn;
	
	self.summaryLabel.text = model.kinfo_one;
	self.contryLabel.text = @"没股票";  // model.kinfo_country;
}


@end
