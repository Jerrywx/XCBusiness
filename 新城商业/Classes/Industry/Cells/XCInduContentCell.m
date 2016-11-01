//
//  XCInduContentCell.m
//  新城商业
//
//  Created by 王潇 on 16/10/31.
//  Copyright © 2016年 王潇. All rights reserved.
//

#import "XCInduContentCell.h"
#import "XCInduDetialModel.h"

@interface XCInduContentCell ()

@property (nonatomic, strong) UILabel		*headTitle;
@property (nonatomic, strong) UIImageView	*imgView;
@property (nonatomic, strong) UILabel		*titleLabel;
@property (nonatomic, strong) UILabel		*contentLabel;

@end

@implementation XCInduContentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	
	[self setupView];
	[self layoutView];
	
	return self;
}

static CGFloat marginL = 20;
static CGFloat margin1 = 5;
static CGFloat margin2 = 10;

- (void)setupView {
	
	self.imgView = ({
		UIImageView *imageView = [[UIImageView alloc] init];
		[self.contentView addSubview:imageView];
		imageView;
	});
	
	self.titleLabel = ({
		UILabel *label = [[UILabel alloc] init];
		label.font = [UIFont systemFontOfSize:12];
		[self.contentView addSubview:label];
		label;
	});
	
	self.contentLabel = ({
		UILabel *label = [[UILabel alloc] init];
		label.font = [UIFont systemFontOfSize:10];
		label.numberOfLines = 0;
		[self.contentView addSubview:label];
		label;
	});
	
	self.headTitle = ({
		UILabel *label = [[UILabel alloc] init];
		label.font = [UIFont systemFontOfSize:12];
		[self.contentView addSubview:label];
		label;
	});
}

- (void)layoutView {
	
	[self.headTitle mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.equalTo(self.contentView.mas_left).offset(marginL);
		make.top.equalTo(self.contentView.mas_top).offset(margin1);
		make.width.equalTo(@(150));
		make.height.equalTo(@(10));
	}];
	
	[self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.equalTo(self.contentView.mas_left).offset(marginL);
		make.top.equalTo(self.headTitle.mas_bottom).offset(margin1);
		make.bottom.equalTo(self.contentView.mas_bottom).offset(-margin1);
		make.width.equalTo(@(80));
	}];
	
	[self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.equalTo(self.imgView.mas_right).offset(margin2);
		make.top.equalTo(self.imgView.mas_top);
		make.right.equalTo(self.contentView.mas_right).offset(-marginL);
		make.height.equalTo(@(12));
	}];
	
	[self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.equalTo(self.imgView.mas_right).offset(margin2);
		make.top.equalTo(self.titleLabel.mas_bottom).offset(margin1);
		make.bottom.equalTo(self.contentView.mas_bottom).offset(-margin1);
		make.right.equalTo(self.contentView.mas_right).offset(-marginL);
	}];
}

- (void)setModel:(XCDetialModel *)model {
	_model = model;
	
	if (model.isFirst) {
		self.headTitle.hidden = NO;
		[self.headTitle mas_updateConstraints:^(MASConstraintMaker *make) {
			make.left.equalTo(self.contentView.mas_left).offset(marginL);
			make.top.equalTo(self.contentView.mas_top).offset(margin1);
			make.width.equalTo(@(150));
			make.height.equalTo(@(10));
		}];
		
		self.headTitle.text = model.title;
		
	} else {
		self.headTitle.hidden = YES;
		[self.headTitle mas_updateConstraints:^(MASConstraintMaker *make) {
			make.top.equalTo(self.contentView.mas_top);
			make.height.equalTo(@(0));
		}];
	}
	
	[self.imgView sd_setImageWithURL:[NSURL URLWithString:model.n_logo]
					placeholderImage:[UIImage imageNamed:@"kj"]];
	
	self.titleLabel.text = model.sc_title;
	self.contentLabel.text = model.n_summary;
}

@end








