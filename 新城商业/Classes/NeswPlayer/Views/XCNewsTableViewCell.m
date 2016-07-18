//
//  XCNewsTableViewCell.m
//  新城商业
//
//  Created by 王潇 on 16/6/15.
//  Copyright © 2016年 王潇. All rights reserved.
//

#import "XCNewsTableViewCell.h"
#import "XCNewsModel.h"

#define CELL_W (SCREEN_W / 3 - 20)

@interface XCNewsTableViewCell ()
@property (nonatomic, strong) UIImageView		*iconView;
@property (nonatomic, strong) UILabel			*titleLabel;
@property (nonatomic, strong) UILabel			*classLabel;
@end

@implementation XCNewsTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	
	if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
		
		// 视频图片
		self.iconView = ({
			CGFloat iconViewY	 = 10;
			CGFloat iconViewX	 = CELL_W - TABLECELL_H + iconViewY;
			UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(iconViewX, iconViewY, TABLEICON_H, TABLEICON_H)];
			[self.contentView addSubview:imgView];
			imgView;
		});
		
		// 标题
		self.titleLabel = ({
			UILabel *label	= [[UILabel alloc] initWithFrame:CGRectMake(10, 20, CELL_W - TABLECELL_H - 10, 15)];
			label.text		= @"视频标题";
			label.font		= [UIFont systemFontOfSize:14];
			label.textColor = [UIColor whiteColor];
			label.textAlignment = NSTextAlignmentRight;
			[self.contentView addSubview:label];
			label;
		});
		
		// 期数
		self.classLabel = ({
			UILabel *label	= [[UILabel alloc] initWithFrame:CGRectMake(10, 35, CELL_W - TABLECELL_H - 10, 15)];
			label.text		= @"第21期";
			label.font		= [UIFont systemFontOfSize:12];
			label.textColor = [UIColor colorWithRed:0.59f green:0.59f blue:0.61f alpha:1.00f];
			label.textAlignment = NSTextAlignmentRight;
			[self.contentView addSubview:label];
			label;
		});
		
		self.iconView.backgroundColor = [UIColor redColor];
	}
	return self;
}

- (void)setModel:(XCNewsModel *)model {
	
	[self.iconView sd_setImageWithURL:[NSURL URLWithString:model.logo]
					 placeholderImage:nil
							  options:SDWebImageRetryFailed];
	
	self.titleLabel.text = model.title1;
	
	self.classLabel.text = [NSString stringWithFormat:@"第%@期", model.nvg_t];
}




@end
