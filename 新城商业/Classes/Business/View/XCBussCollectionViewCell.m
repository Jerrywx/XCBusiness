//
//  XCBussCollectionViewCell.m
//  新城商业
//
//  Created by 王潇 on 16/4/28.
//  Copyright © 2016年 王潇. All rights reserved.
//

#import "XCBussCollectionViewCell.h"

@interface XCBussCollectionViewCell ()
@property (nonatomic, strong) UIImageView		*imgView;
@property (nonatomic, strong) UILabel			*titleLabel;
@property (nonatomic, strong) UILabel			*infoLabel;
@end

@implementation XCBussCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
	
	if (self = [super initWithFrame:frame]) {
		
		CGFloat imgH = self.contentView.frame.size.height * (23 / 33.0);
		CGFloat imgW = self.contentView.frame.size.width;
		CGFloat contentH = self.contentView.frame.size.height - imgH;
		// 1. 视频封面
		self.imgView = ({
			UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, imgW, imgH)];
			imgView.contentMode  = UIViewContentModeScaleAspectFill;
			imgView.clipsToBounds = YES;
			[self.contentView addSubview:imgView];
			imgView;
		});
		
		// 2. 视频标题
		self.titleLabel = ({
			UILabel *label	= [[UILabel alloc] initWithFrame:CGRectMake(0, imgH, imgW, contentH * (2 / 3.0))];
			label.text		= @"视频名称";
			label.font		= [UIFont systemFontOfSize:13];
			label.textColor = [UIColor blackColor];
			label.numberOfLines = 2;
			[self.contentView addSubview:label];
			label;
		});
		
		// 3. 视频描述信息
		self.infoLabel = ({
			UILabel *label	= [[UILabel alloc] initWithFrame:CGRectMake(0, imgH + contentH * (2 / 3.0), imgW, contentH * (1 / 3.0))];
			label.text		= @"太空探索 | 2016.05.14";
			label.font		= [UIFont systemFontOfSize:11];
			label.textColor = [UIColor lightGrayColor];
			[self.contentView addSubview:label];
			label;
		});
	}
	return self;
}

- (void)setModel:(XCBussNewsModel *)model {
	_model = model;
	// 1.
	[self.imgView sd_setImageWithURL:[NSURL URLWithString:model.logo]
					placeholderImage:nil
							 options:SDWebImageRetryFailed];
	
	// 2.
	self.titleLabel.text = [NSString stringWithFormat:@"%@ , %@", model.title1, model.title2];
	
	// 3.
	self.infoLabel.text = [NSString stringWithFormat:@"%@ | %@", model.in_cn, model.date];
}


- (void)setColor {
	self.imgView.backgroundColor	= [UIColor lightGrayColor];
	self.titleLabel.backgroundColor = [UIColor darkGrayColor];
	self.infoLabel.backgroundColor	= [UIColor grayColor];
}

- (void)clearColor {
	self.imgView.backgroundColor	= [UIColor clearColor];
	self.titleLabel.backgroundColor = [UIColor clearColor];
	self.infoLabel.backgroundColor	= [UIColor clearColor];
}

@end
