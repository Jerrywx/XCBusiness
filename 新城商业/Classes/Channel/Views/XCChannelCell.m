//
//  XCChannelCell.m
//  新城商业
//
//  Created by 王潇 on 16/7/22.
//  Copyright © 2016年 王潇. All rights reserved.
//

#import "XCChannelCell.h"
#import "XCChannelLog.h"

@interface XCChannelCell ()
@property (nonatomic, assign) BOOL				isOpen;
@property (nonatomic, strong) NSMutableArray	*buttons;
@end


@implementation XCChannelCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	
	if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
		self.buttons = [NSMutableArray array];
	}
	return self;
}

- (void)setIndustry:(Industry *)industry {
	_industry = industry;
	
	for (UIButton *btn in self.buttons) {
		[btn removeFromSuperview];
	}
	[self.buttons removeAllObjects];
	
	UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 200, 25)];
	button.backgroundColor = [UIColor redColor];
	[button setTitle:industry.k_cn forState:UIControlStateNormal];
	[self.contentView addSubview:button];
	[self.buttons addObject:button];
	[button addTarget:self action:@selector(openDetial) forControlEvents:UIControlEventTouchUpInside];
	
	for (int i = 0; i < industry.ptpe.count; i++) {
		Company *company = industry.ptpe[i];
		UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 25 + i * 25, 200, 25)];
		btn.hidden = !self.isOpen;
		[btn setTitle:company.ptpe_cn forState:UIControlStateNormal];
		[self.buttons addObject:btn];
		btn.backgroundColor = [UIColor greenColor];
		[self.contentView addSubview:btn];
	}
}

- (void)openDetial {
	self.isOpen = !self.isOpen;
	
	if ([self.delegate respondsToSelector:@selector(openCellDetial:isOpen:)]) {
		[self.delegate openCellDetial:self.index isOpen:self.isOpen];
	}
}


@end
