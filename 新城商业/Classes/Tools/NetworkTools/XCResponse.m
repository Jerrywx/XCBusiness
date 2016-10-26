//
//  XCResponse.m
//  新城商业
//
//  Created by 王潇 on 16/10/27.
//  Copyright © 2016年 王潇. All rights reserved.
//

#import "XCResponse.h"

@implementation XCResponse

+ (instancetype)initWithJson:(id)json {
	
	if (![json isKindOfClass:[NSDictionary class]]) {
		return nil;
	}
	
	XCResponse *response = [XCResponse mj_objectWithKeyValues:json];
	return response;
}


@end
