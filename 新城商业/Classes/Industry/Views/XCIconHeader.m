//
//  XCIconHeader.m
//  新城商业
//
//  Created by 王潇 on 16/10/30.
//  Copyright © 2016年 王潇. All rights reserved.
//

#import "XCIconHeader.h"

@implementation XCIconHeader

- (instancetype)initWithFrame:(CGRect)frame {
	
	self = [super initWithFrame:frame];
	
	UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,
											frame.size.width, frame.size.height)];
	imageView.contentMode = UIViewContentModeCenter;
	[self addSubview:imageView];
	imageView.image = [UIImage imageNamed:@"Indu"];
	
	return self;
}

@end
