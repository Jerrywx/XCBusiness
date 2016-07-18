//
//  XCBottomNewCell.m
//  新城商业
//
//  Created by 王潇 on 16/7/7.
//  Copyright © 2016年 王潇. All rights reserved.
//

#import "XCBottomNewCell.h"
#import "XCBottonNews.h"
#import "XCRightVideo.h"

@interface XCBottomNewCell ()

@property (nonatomic, strong) UIImageView	*imgView;
@property (nonatomic, strong) UILabel		*titleLabel;
@property (nonatomic, strong) UILabel		*numbLabel;

@end

@implementation XCBottomNewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	
	if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
		[self setupView];
		[self configureLayout];
	}
	return self;
}

- (void)setupView {
	
	// 1. 图片
	self.imgView = ({
		UIImageView *imgView = [[UIImageView alloc] init];
		[self.contentView addSubview:imgView];
		imgView;
	});
	
	// 2. 标题
	self.titleLabel = ({
		UILabel *label		= [[UILabel alloc] init];
		label.font			= [UIFont systemFontOfSize:12];
		label.textColor		= [UIColor whiteColor];
		label.textAlignment = NSTextAlignmentRight;
		[self.contentView addSubview:label];
		label;
	});
	
	// 3. 期数
	self.numbLabel = ({
		UILabel *label		= [[UILabel alloc] init];
		label.font			= [UIFont systemFontOfSize:12];
		label.textColor		= [UIColor colorWithRed:0.59f green:0.59f blue:0.61f alpha:1.00f];
		label.textAlignment = NSTextAlignmentRight;
		[self.contentView addSubview:label];
		label;
	});
}

- (void)configureLayout {
	
	// 1. 图片
	CGFloat imgW = 60;
	[self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(self.contentView.mas_top).offset(10);
		make.right.equalTo(self.contentView.mas_right).offset(-10);
		make.width.height.equalTo(@(imgW));
	}];
	
	// 2.
	[self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(self.imgView.mas_top);
		make.right.equalTo(self.imgView.mas_left).offset(-10);
		make.left.equalTo(self.contentView.mas_left).offset(10);
		make.height.equalTo(@(25));
	}];
	
	// 3.
	[self.numbLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
		make.right.equalTo(self.imgView.mas_left).offset(-10);
		make.left.equalTo(self.contentView.mas_left).offset(10);
		make.height.equalTo(@(20));
	}];
}

- (void)setModel:(XCBottonNews *)model {
	_model = model;
	
	[self.imgView sd_setImageWithURL:[NSURL URLWithString:model.n_logo]
					placeholderImage:nil 
							 options:SDWebImageRetryFailed];
	
	self.titleLabel.text = model.n_title1;
	self.numbLabel.text  = model.n_title2;
}

- (void)setVideoModel:(XCRightVideo *)videoModel {
	_videoModel = videoModel;
	
	
	[self.imgView sd_setImageWithURL:[NSURL URLWithString:videoModel.logo]
					placeholderImage:nil
							 options:SDWebImageRetryFailed];
	
	self.titleLabel.text = videoModel.title1;
	self.numbLabel.text  = videoModel.title2;
}


@end










