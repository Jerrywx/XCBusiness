//
//  XCChannelHeaderView.m
//  新城商业
//
//  Created by 王潇 on 16/7/18.
//  Copyright © 2016年 王潇. All rights reserved.
//

#import "XCChannelHeaderView.h"


@interface XCChannelHeaderView()

@property (nonatomic, strong) UILabel		*titleLabel;
@property (nonatomic, strong) UIButton		*btnCountry;
@property (nonatomic, strong) UIButton		*btnPerson;
@property (nonatomic, strong) UIButton		*btnCompany;

@end


@implementation XCChannelHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
	
	if (self = [super initWithFrame:frame]) {
		[self setupView];
		[self layoutConfiguration];
	}
	return self;
}

- (void)setupView {
	
	// 1. titleLabel
	self.titleLabel = ({
		UILabel *label	= [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 25)];
		label.text		= @"标题";
		label.font		= [UIFont systemFontOfSize:16];
		label.textColor = [UIColor blackColor];
		label.textAlignment = NSTextAlignmentRight;
		[self addSubview:label];
		label;
	});
	
	// 2. btnCountry
	self.btnCountry = ({
		UIButton *button = [[UIButton alloc] init];
		button.titleLabel.font = [UIFont systemFontOfSize:14];
//		[button sizeToFit];
		button.contentEdgeInsets = UIEdgeInsetsMake(2, 5, 2, 5);
		[button setTitle:@"国家机构" forState:UIControlStateNormal];
		[self addSubview:button];
		button;
	});
	
	// 3. btnPerson
	self.btnPerson = ({
		UIButton *button = [[UIButton alloc] init];
		button.titleLabel.font = [UIFont systemFontOfSize:14];
//		[button sizeToFit];
		button.contentEdgeInsets = UIEdgeInsetsMake(2, 5, 2, 5);
		[button setTitle:@"人物" forState:UIControlStateNormal];
		[self addSubview:button];
		button;
	});
	
	// 4. btnCompany
	self.btnCompany = ({
		UIButton *button = [[UIButton alloc] init];
		button.titleLabel.font = [UIFont systemFontOfSize:14];
		button.contentEdgeInsets = UIEdgeInsetsMake(2, 5, 2, 5);
		[button setTitle:@"商业公司" forState:UIControlStateNormal];
		[self addSubview:button];
		button;
	});
	
	//
	self.titleLabel.backgroundColor = [UIColor orangeColor];
	self.btnCountry.backgroundColor = [UIColor redColor];
	self.btnCompany.backgroundColor = [UIColor grayColor];
	self.btnPerson.backgroundColor = [UIColor blueColor];
}

- (void)layoutConfiguration {
	
	CGFloat margin = 10;
	
	// 1. titleLabel
	[self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(self.mas_top).offset(margin);
		make.left.equalTo(self.mas_left).offset(margin);
		make.right.equalTo(self.mas_right).offset(-margin);
		make.height.equalTo(@(25));
	}];
	
	// 2. btnCompany
	[self.btnCompany mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(self.titleLabel.mas_bottom).offset(margin);
		make.right.equalTo(self.mas_right).offset(-margin);
	}];
	
	// 3. btnPerson
	[self.btnPerson mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(self.titleLabel.mas_bottom).offset(margin);
		make.right.equalTo(self.btnCompany.mas_left).offset(-margin);
	}];
	
	// 4. btnCountry
	[self.btnCountry mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(self.titleLabel.mas_bottom).offset(margin);
		make.right.equalTo(self.btnPerson.mas_left).offset(-margin);
	}];
}


@end
